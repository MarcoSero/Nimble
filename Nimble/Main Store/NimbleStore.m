//
//  Created by marco on 10/07/13.
//
//
//


#import "NimbleStore.h"
#import "NimbleStore+Defaults.h"
#import "NSManagedObjectContext+NimbleContexts.h"

NSString *const NBCloudStoreWillReplaceLocalStore = @"NBCloudStoreWillReplaceLocalStore";
NSString *const NBCloudStoreDidReplaceLocalStore = @"NBCloudStoreDidReplaceLocalStore";

NSString *const NBPersistentStoreException = @"NBPersistentStoreException";
NSString *const NBFetchRequestException = @"NBFetchRequestException";

NSString *const NBNimbleErrorDomain = @"com.marcosero.Nimble";

NSUInteger const NBNimbleErrorCode = 1;

@interface NimbleStore ()

@property(strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property(strong, nonatomic) NSManagedObjectContext *mainContext;
@property(strong, nonatomic) NSManagedObjectContext *backgroundContext;

@end

static NimbleStore *mainStore;

@implementation NimbleStore

#pragma mark - Setup store

+ (void)nb_setupStore:(NSError **)error
{
  [self nb_setupStoreWithFilename:[self.class nb_defaultStoreName] error:error];
}

+ (void)nb_setupStoreWithFilename:(NSString *)filename error:(NSError **)error
{
  NSParameterAssert(filename);

  [self setupStoreWithName:filename storeType:NSSQLiteStoreType error:error];
}

+ (void)nb_setupInMemoryStore:(NSError **)error
{
  [self setupStoreWithName:nil storeType:NSInMemoryStoreType error:error];
}

+ (void)setupStoreWithName:(NSString *)filename storeType:(NSString * const)storeType error:(NSError **)error
{
  NSParameterAssert(filename);
  NSParameterAssert(storeType);

  [self nb_setupStoreWithName:filename storeType:storeType options:nil error:error];
}

+ (void)nb_setupStoreWithName:(NSString *)filename storeType:(NSString * const)storeType options:(NSDictionary *)options error:(NSError **)error
{
  NSAssert(!mainStore, @"Store already was already set up", nil);

  mainStore = [[NimbleStore alloc] init];

  NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];

  if (!model) {
    NSString *errorMessage = @"No managed object model found.";
    NBLog(errorMessage, nil);
    *error = [NSError errorWithDomain:NBNimbleErrorDomain code:1 userInfo:@{@"error" : errorMessage}];
#ifdef DEBUG
    @throw ([NSException exceptionWithName:NBPersistentStoreException reason:errorMessage userInfo:nil]);
#endif
    return;
  }

  mainStore.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];

  NSURL *localStoreURL = [self nb_URLToStoreWithFilename:filename];

  [mainStore.persistentStoreCoordinator lock];
  NSPersistentStore *persistentStore = [mainStore.persistentStoreCoordinator addPersistentStoreWithType:storeType
                                                     configuration:nil
                                                               URL:localStoreURL
                                                           options:options
                                                             error:error];
  [mainStore.persistentStoreCoordinator unlock];

  if (error || !persistentStore) {
    NSString *errorMessage = @"No managed object model found.";
    NBLog(errorMessage, nil);
    *error = [NSError errorWithDomain:NBNimbleErrorDomain code:NBNimbleErrorCode userInfo:@{@"error" : errorMessage}];
#ifdef DEBUG
    @throw ([NSException exceptionWithName:NBPersistentStoreException reason:errorMessage userInfo:nil]);
#endif
    return;
  }

  mainStore.mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
  mainStore.backgroundContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
  [mainStore.mainContext setPersistentStoreCoordinator:mainStore.persistentStoreCoordinator];
  [mainStore.backgroundContext setPersistentStoreCoordinator:mainStore.persistentStoreCoordinator];

  [mainStore registerToNotifications];
}

- (void)registerToNotifications
{
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(storesDidSaveHandler:)
                                               name:NSManagedObjectContextDidSaveNotification
                                             object:self.backgroundContext];

  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(storesDidChangeHandler:)
                                               name:NSPersistentStoreCoordinatorStoresDidChangeNotification
                                             object:self.persistentStoreCoordinator];

  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(storesWillChangeHandler:)
                                               name:NSPersistentStoreCoordinatorStoresWillChangeNotification
                                             object:self.persistentStoreCoordinator];

  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(storesDidImportHandler:)
                                               name:NSPersistentStoreDidImportUbiquitousContentChangesNotification
                                             object:self.persistentStoreCoordinator];
}

+ (BOOL)nb_removeAllStores:(NSError **)error
{
  NSPersistentStore *store = [mainStore.persistentStoreCoordinator.persistentStores lastObject];
  NSURL *storeURL = [mainStore.persistentStoreCoordinator URLForPersistentStore:store];
  BOOL success = [NSPersistentStoreCoordinator removeUbiquitousContentAndPersistentStoreAtURL:storeURL options:nil error:error];
  return success;
}

#pragma mark - Fetch request

+ (NSArray *)nb_executeFetchRequest:(NSFetchRequest *)request inContextOfType:(NimbleContextType)contextType error:(NSError **)error
{
  NSParameterAssert(request);

  NSArray *results = [[NSManagedObjectContext nb_contextForType:contextType] executeFetchRequest:request error:error];

  if (error) {
    NSString *errorMessage = [NSString stringWithFormat:@"Error in fetch request: %@\nError: %@", request, *error];
    NBLog(errorMessage, nil);
    *error = [NSError errorWithDomain:NBNimbleErrorDomain code:NBNimbleErrorCode userInfo:@{@"error" : errorMessage}];
#ifdef DEBUG
    @throw ([NSException exceptionWithName:NBPersistentStoreException reason:errorMessage userInfo:nil]);
#endif
  }

  return results;
}

#pragma mark - Contexts

+ (NSManagedObjectContext *)nb_mainContext
{
  return mainStore.mainContext;
}

+ (NSManagedObjectContext *)nb_backgroundContext
{
  return mainStore.backgroundContext;
}

#pragma mark - Notifications

/**
    Subscribe to NSManagedObjectContextDidSaveNotification
*/
- (void)storesDidSaveHandler:(NSNotification *)notification
{
  [self.mainContext performBlock:^{
    [self.mainContext mergeChangesFromContextDidSaveNotification:notification];
  }];
}

/**
    Subscribe to NSPersistentStoreCoordinatorStoresWillChangeNotification
*/
- (void)storesWillChangeHandler:(NSNotification *)notification
{
  NSManagedObjectContext *moc = self.mainContext;

  [moc performBlockAndWait:^{
    if ([moc hasChanges]) {
      NSError *error = nil;
      [moc save:&error];

      if (error) {
        NBLog(@"Error saving main context: %@", error);
      }
    }

    [moc reset];
  }];

  [[NSNotificationCenter defaultCenter] postNotificationName:NBCloudStoreWillReplaceLocalStore object:nil];
}

/**
    Subscribe to NSPersistentStoreCoordinatorStoresDidChangeNotification
*/
- (void)storesDidChangeHandler:(NSNotification *)notification
{
  if ([notification.userInfo objectForKey:@"removed"] == nil) {
    // just added local persistent store
    // TODO: HACKY! remove this!
    return;
  }

  [self.mainContext performBlock:^{
    [self.mainContext mergeChangesFromContextDidSaveNotification:notification];
    [[NSNotificationCenter defaultCenter] postNotificationName:NBCloudStoreDidReplaceLocalStore object:nil];
    NBLog(@"Using iCloud store");
  }];
}


/**
    Subscribe to NSPersistentStoreDidImportUbiquitousContentChangesNotification
*/
- (void)storesDidImportHandler:(NSNotification *)notification
{
  [self.mainContext performBlock:^{
    [self.mainContext mergeChangesFromContextDidSaveNotification:notification];
  }];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:mainStore];
}

@end