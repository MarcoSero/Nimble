//
//  Created by marco on 10/07/13.
//
//
//


#import <objc/runtime.h>
#import "NimbleStore.h"
#import "NimbleStore+Defaults.h"
#import "NSManagedObjectContext+NimbleContexts.h"


@interface NimbleStore ()
@property (strong, nonatomic) NSManagedObjectContext *mainContext;
@property (strong, nonatomic) NSManagedObjectContext *backgroundContext;
@property (strong, nonatomic) NSOperationQueue *queueForBackgroundSavings;
@end

static NimbleStore *mainStore;

@implementation NimbleStore

#pragma mark - Setup store

+ (void)setupStore
{
  [self setupStoreWithFilename:[self.class defaultStoreName]];
}

+ (void)setupStoreWithFilename:(NSString *)filename
{
  NSAssert(!mainStore, @"Store already was already set up", nil);
  NSParameterAssert(filename);

  mainStore = [[NimbleStore alloc] init];

  NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
  NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];

  NSString *fileURL = [NSString localizedStringWithFormat:@"%@/%@", [self.class applicationDocumentsDirectory], filename];
  NSURL *url = [NSURL fileURLWithPath:fileURL];
  NSError *error;
  [persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error];

  mainStore.mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
  mainStore.backgroundContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
  [mainStore.mainContext setPersistentStoreCoordinator:persistentStoreCoordinator];
  [mainStore.backgroundContext setPersistentStoreCoordinator:persistentStoreCoordinator];

  mainStore.queueForBackgroundSavings = [[NSOperationQueue alloc] init];
  mainStore.queueForBackgroundSavings.maxConcurrentOperationCount = 1;

  // register observer to merge contexts
  [[NSNotificationCenter defaultCenter] addObserver:mainStore
                                           selector:@selector(contextDidSave:)
                                               name:NSManagedObjectContextDidSaveNotification
                                             object:mainStore.backgroundContext];
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
  return mainStore.mainContext;
}

+ (NSManagedObjectContext *)backgroundContext
{
  return mainStore.backgroundContext;
}

#pragma mark - Merging

- (void)contextDidSave:(NSNotification *)notification
{
  SEL selector = @selector(mergeChangesFromContextDidSaveNotification:);
  [_mainContext performSelectorOnMainThread:selector withObject:notification waitUntilDone:YES];
}

#pragma mark - Background saving queue

+ (NSOperationQueue *)queueForBackgroundSavings
{
  return mainStore.queueForBackgroundSavings;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:mainStore];
}

@end