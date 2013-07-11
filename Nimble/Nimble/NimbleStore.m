//
//  Created by marco on 10/07/13.
//
//
//


#import "NimbleStore.h"
#import "NimbleStore+Defaults.h"
#import "NSManagedObjectContext+NimbleContexts.h"

#define sing [NimbleStore sharedInstance]
#define MainThreadAssert NSAssert([NSThread isMainThread], @"%p has been called outside the main thread. Use saveBackgroundContext if you are in a background context", _cmd)
#define BackgroundThreadAssert NSAssert([NSThread isMainThread], @"%p has been called inside the main thread. Use the other savers if you are in the main context", _cmd)

@interface NimbleStore ()
@property (strong, nonatomic) NSManagedObjectContext *mainContext;
@property (strong, nonatomic) NSManagedObjectContext *backgroundContext;
@property (strong, nonatomic) dispatch_queue_t backgroundSavingQueue;
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

  sing.backgroundSavingQueue = dispatch_queue_create([@"BackgroundSavingQueue" UTF8String], nil);

  // register observer to merge contexts
  [[NSNotificationCenter defaultCenter] addObserver:sing
                                           selector:@selector(contextDidSave:)
                                               name:NSManagedObjectContextDidSaveNotification
                                             object:nil];
}

#pragma mark - Saving

+ (void)saveInBackground:(NimbleSimpleBlock)changesBlock
{
  MainThreadAssert;

  [self saveInBackground:changesBlock withCompletion:nil];
}

+ (void)saveInBackground:(NimbleSimpleBlock)changesBlock withCompletion:(NimbleErrorBlock)completion
{
  NSParameterAssert(changesBlock);
  MainThreadAssert;

  dispatch_async(sing.backgroundSavingQueue, ^{
    [self saveBackgroundContextAndWait:changesBlock];
    dispatch_async(dispatch_get_main_queue(), ^{
      if (completion) {
        completion(nil);
      }
    });
  });
}


+ (void)saveMainContext:(NimbleSimpleBlock)changesBlock
{
  NSParameterAssert(changesBlock);
  MainThreadAssert;

  [sing.mainContext performBlock:^{
    changesBlock(sing.mainContext);
    [sing.mainContext save:nil];
  }];
}


+ (void)saveMainContextAndWait:(NimbleSimpleBlock)changesBlock
{
  NSParameterAssert(changesBlock);
  MainThreadAssert;

  [sing.mainContext performBlockAndWait:^{
    changesBlock(sing.mainContext);
    [sing.mainContext save:nil];
  }];
}


+ (void)saveBackgroundContext:(NimbleSimpleBlock)changesBlock
{
  NSParameterAssert(changesBlock);
  BackgroundThreadAssert;

  [sing.backgroundContext performBlock:^{
    changesBlock(sing.backgroundContext);
    [sing.backgroundContext save:nil];
  }];
}

+ (void)saveBackgroundContextAndWait:(NimbleSimpleBlock)changesBlock
{
  NSParameterAssert(changesBlock);
  BackgroundThreadAssert;

  [sing.backgroundContext performBlockAndWait:^{
    changesBlock(sing.backgroundContext);
    [sing.backgroundContext save:nil];
  }];
}

#pragma mark - Fetch request

+ (NSArray *)executeFetchRequest:(NSFetchRequest *)request inContextOfType:(NimbleContextType)contextType
{
  NSParameterAssert(request);

  return [[NSManagedObjectContext contextForType:contextType] executeFetchRequest:request error:nil];
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