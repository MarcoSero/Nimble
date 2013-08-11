//
//  Created by marco on 10/07/13.
//
//
//


#import "NimbleStore.h"
#import "NimbleStore+Defaults.h"
#import "NSManagedObjectContext+NimbleContexts.h"

NSString *const NBStoreReplacedByCloudStore = @"NBStoreReplacedByCloudStore";

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

  [self nb_setupStoreWithName:filename storeType:storeType iCloudEnabled:NO options:nil error:error];
}

+ (void)nb_setupStoreWithName:(NSString *)filename storeType:(NSString * const)storeType iCloudEnabled:(BOOL)iCloudEnabled options:(NSDictionary *)options error:(NSError **)error
{
  NSAssert(!mainStore, @"Store already was already set up", nil);

  mainStore = [[NimbleStore alloc] init];

  NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];

  if (!model) {
    *error = [NSError errorWithDomain:@"com.marcosero.Nimble" code:1 userInfo:@{@"error" : @"No managed object model found."}];
  }

  mainStore.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];

  [self registerToNotificationsWith_iCloudEnabled:iCloudEnabled];

  NSURL *localStoreURL = [self nb_URLToStoreWithFilename:filename];

  [mainStore.persistentStoreCoordinator lock];
  [mainStore.persistentStoreCoordinator addPersistentStoreWithType:storeType
                                                     configuration:nil
                                                               URL:localStoreURL
                                                           options:options
                                                             error:error];

  if (error) {
    NBLog(@"");
    NBLog(@"Error initialising the store: %@", *error);
    return;
  }

  [mainStore.persistentStoreCoordinator unlock];

  mainStore.mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
  mainStore.backgroundContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
  [mainStore.mainContext setPersistentStoreCoordinator:mainStore.persistentStoreCoordinator];
  [mainStore.backgroundContext setPersistentStoreCoordinator:mainStore.persistentStoreCoordinator];


}

+ (void)registerToNotificationsWith_iCloudEnabled:(BOOL)iCloudEnabled
{
  [[NSNotificationCenter defaultCenter] addObserver:mainStore
                                           selector:@selector(storesDidChangeHandler:)
                                               name:NSManagedObjectContextDidSaveNotification
                                             object:mainStore.backgroundContext];

  if (iCloudEnabled) {
    [[NSNotificationCenter defaultCenter] addObserver:mainStore
                                             selector:@selector(storesWillChangeHandler:)
                                                 name:NSPersistentStoreCoordinatorStoresWillChangeNotification
                                               object:mainStore.persistentStoreCoordinator];
    [[NSNotificationCenter defaultCenter] addObserver:mainStore
                                             selector:@selector(storesDidImportHandler:)
                                                 name:NSPersistentStoreDidImportUbiquitousContentChangesNotification
                                               object:mainStore.persistentStoreCoordinator];
  }
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
    NBLog(@"Error in fetch request: %@\nError: %@", request, *error);
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

  //reset user interface
}

/**
    Subscribe to NSManagedObjectContextDidSaveNotification
*/
- (void)storesDidChangeHandler:(NSNotification *)notification
{
  [self.mainContext performBlock:^{
    
    [self.mainContext mergeChangesFromContextDidSaveNotification:notification];
    
    // read here https://devforums.apple.com/message/865235
    if (notification.object != self.backgroundContext) {
      [[NSNotificationCenter defaultCenter] postNotificationName:NBStoreReplacedByCloudStore object:nil];
    }
    
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