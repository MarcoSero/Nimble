//
//  Created by marco on 10/07/13.
//
//
//


#import <objc/runtime.h>
#import "NimbleStore.h"
#import "NimbleStore+Defaults.h"
#import "NimbleStore+Savers.h"
#import "NSManagedObjectContext+NimbleContexts.h"


#define sing [NimbleStore sharedInstance]
#define MainThreadAssert NSAssert([NSThread isMainThread], @"%p has been called outside the main thread. Use saveBackgroundContext if you are in a background context", _cmd)
#define BackgroundThreadAssert NSAssert([NSThread isMainThread], @"%p has been called inside the main thread. Use the other savers if you are in the main context", _cmd)

@interface NimbleStore ()
@property (strong, nonatomic) NSManagedObjectContext *mainContext;
@property (strong, nonatomic) NSManagedObjectContext *backgroundContext;
@end

static char BackgroundSavingQueue;

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

#pragma mark - Background saving queue

- (dispatch_queue_t)backgroundSavingQueue
{
  return objc_getAssociatedObject(self, &BackgroundSavingQueue);
}

+ (dispatch_queue_t)backgroundSavingQueue
{
  return objc_getAssociatedObject(sing, &BackgroundSavingQueue);
}

- (void)setBackgroundSavingQueue:(dispatch_queue_t)queue
{
  objc_setAssociatedObject(self, &BackgroundSavingQueue, queue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Dealloc

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:sing];
}

@end