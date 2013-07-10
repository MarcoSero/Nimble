//
//  Created by marco on 10/07/13.
//
//
//


#import "NimbleStore.h"
#import "NimbleStore+Defaults.h"

#define sing [NimbleStore sharedInstance]

@interface NimbleStore ()
@property (strong, nonatomic) NSManagedObjectContext *mainContext;
@property (strong, nonatomic) NSManagedObjectContext *backgroundContext;
@end

@implementation NimbleStore

+ (NimbleStore *)sharedInstance
{
  static dispatch_once_t onceToken;
  static NimbleStore *singleton;
  dispatch_once(&onceToken, ^{
    singleton = [[NimbleStore alloc] init];
  });

  return singleton;
}

#pragma mark - Setup store

+ (void)setupStore
{
  [self setupStoreWithFilename:[self.class defaultStoreName]];
}

+ (void)setupStoreWithFilename:(NSString *)filename
{
  NSAssert(!sing.mainContext && !sing.backgroundContext, @"Store already was already set up", nil);
  NSParameterAssert(filename);

  NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
  NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];

  NSString *fileURL = [NSString localizedStringWithFormat:@"%@/%@", [self.class applicationDocumentsDirectory], filename];
  NSURL *url = [NSURL fileURLWithPath:fileURL];
  NSError *error;
  [persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error];

  sing.mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
  sing.backgroundContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
  [sing.mainContext setPersistentStoreCoordinator:persistentStoreCoordinator];
  [sing.backgroundContext setPersistentStoreCoordinator:persistentStoreCoordinator];

  // register observer to merge contexts
  [[NSNotificationCenter defaultCenter] addObserver:sing
                                           selector:@selector(contextDidSave:)
                                               name:NSManagedObjectContextDidSaveNotification
                                             object:nil];
}

#pragma mark - Saving

+ (void)saveMainContextWithChanges:(NimbleSimpleBlock)changesBlock
{
  NSParameterAssert(changesBlock);

  [sing.mainContext performBlock:^{
    changesBlock(sing.mainContext);
    [sing.mainContext save:nil];
  }];
}

+ (void)saveBackgroundContextWithChanges:(NimbleSimpleBlock)changesBlock
{
  NSParameterAssert(changesBlock);

  [sing.backgroundContext performBlock:^{
    changesBlock(sing.backgroundContext);
    [sing.backgroundContext save:nil];
  }];
}

+ (void)saveMainContextWithChangesAndWait:(NimbleSimpleBlock)changesBlock
{
  NSParameterAssert(changesBlock);

  [sing.mainContext performBlockAndWait:^{
    changesBlock(sing.mainContext);
    [sing.mainContext save:nil];
  }];
}

+ (void)saveBackgroundContextWithChangesAndWait:(NimbleSimpleBlock)changesBlock
{
  NSParameterAssert(changesBlock);

  [sing.backgroundContext performBlockAndWait:^{
    changesBlock(sing.backgroundContext);
    [sing.backgroundContext save:nil];
  }];
}

#pragma mark - Fetch request

+ (NSArray *)executeFetchRequest:(NSFetchRequest *)request inContext:(NimbleContext)context
{
  NSParameterAssert(request);
  NSParameterAssert(context);

  if (context == NimbleMainContext) {
    return [sing.mainContext executeFetchRequest:request error:nil];
  }
  else {
    return [sing.backgroundContext executeFetchRequest:request error:nil];
  }
}

#pragma mark - Contexts

+ (NSManagedObjectContext *)mainContext
{
  return sing.mainContext;
}

+ (NSManagedObjectContext *)backgroundContext
{
  return sing.backgroundContext;
}



#pragma mark - Merging

- (void)contextDidSave:(NSNotification *)notification
{
  SEL selector = @selector(mergeChangesFromContextDidSaveNotification:);
  [_mainContext performSelectorOnMainThread:selector withObject:notification waitUntilDone:YES];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:sing];
}

@end