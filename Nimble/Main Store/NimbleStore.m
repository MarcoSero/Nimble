// NimbleStore.m
//
// Copyright (c) 2013 Marco Sero (http://www.marcosero.com/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


#import "NimbleStore.h"
#import "NimbleStore+Defaults.h"
#import "NSManagedObjectContext+NimbleContexts.h"
#import "UIDevice+Version.h"

NSString *const NBCloudStoreWillReplaceLocalStore = @"NBCloudStoreWillReplaceLocalStore";
NSString *const NBCloudStoreDidReplaceLocalStore = @"NBCloudStoreDidReplaceLocalStore";

NSString *const NBPersistentStoreException = @"NBPersistentStoreException";
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

+ (BOOL)nb_setupStore:(NSError **)error
{
  return [self nb_setupStoreWithFilename:[self.class nb_defaultStoreName] error:error];
}

+ (BOOL)nb_setupStoreWithFilename:(NSString *)filename error:(NSError **)error
{
  NSParameterAssert(filename);

  return [self nb_setupStoreWithName:filename storeType:NSSQLiteStoreType error:error];
}

+ (BOOL)nb_setupInMemoryStore:(NSError **)error
{
  return [self nb_setupStoreWithName:nil storeType:NSInMemoryStoreType error:error];
}

+ (BOOL)nb_setupStoreWithName:(NSString *)filename storeType:(NSString * const)storeType error:(NSError **)error
{
  NSParameterAssert(filename);
  NSParameterAssert(storeType);

  return [self nb_setupStoreWithName:filename storeType:storeType options:nil error:error];
}

+ (BOOL)nb_setupStoreWithName:(NSString *)filename storeType:(NSString * const)storeType options:(NSDictionary *)options error:(NSError **)error
{
  NSAssert(!mainStore, @"Store already was already set up", nil);

  mainStore = [[NimbleStore alloc] init];

  NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];

  if (!model) {
    NSString *errorMessage = @"No managed object model found.";
    NBLog(errorMessage, nil);
    if (error != NULL) {
      *error = [NSError errorWithDomain:NBNimbleErrorDomain code:1 userInfo:@{@"error" : errorMessage}];
    }
#ifdef DEBUG
    @throw ([NSException exceptionWithName:NBPersistentStoreException reason:errorMessage userInfo:nil]);
#endif
    return NO;
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
    if (error != NULL) {
      *error = [NSError errorWithDomain:NBNimbleErrorDomain code:NBNimbleErrorCode userInfo:@{@"error" : errorMessage}];
    }
#ifdef DEBUG
    @throw ([NSException exceptionWithName:NBPersistentStoreException reason:errorMessage userInfo:nil]);
#endif
    return NO;
  }

  mainStore.mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
  mainStore.backgroundContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
  [mainStore.mainContext setPersistentStoreCoordinator:mainStore.persistentStoreCoordinator];
  [mainStore.backgroundContext setPersistentStoreCoordinator:mainStore.persistentStoreCoordinator];

  [mainStore pr_registerToNotifications];

  return YES;
}

+ (void)teardown {
    NSAssert(mainStore, @"Calling teardown when store was not set up", nil);

    mainStore.mainContext = nil;
    mainStore.backgroundContext = nil;
    mainStore.persistentStoreCoordinator = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:mainStore];
    
    mainStore = nil;
    
}

- (void)pr_registerToNotifications
{
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(pr_storesDidSaveHandler:)
                                               name:NSManagedObjectContextDidSaveNotification
                                             object:self.backgroundContext];

  // no iCloud support on iOS 6
  if ([[UIDevice currentDevice] systemMajorVersion] < 7) {
    return;
  }

  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(pr_storesDidChangeHandler:)
                                               name:NSPersistentStoreCoordinatorStoresDidChangeNotification
                                             object:self.persistentStoreCoordinator];

  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(pr_storesWillChangeHandler:)
                                               name:NSPersistentStoreCoordinatorStoresWillChangeNotification
                                             object:self.persistentStoreCoordinator];

  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(pr_storesDidImportHandler:)
                                               name:NSPersistentStoreDidImportUbiquitousContentChangesNotification
                                             object:self.persistentStoreCoordinator];
}

#pragma mark - Fetch request

+ (NSArray *)nb_executeFetchRequest:(NSFetchRequest *)request inContextOfType:(NBContextType)contextType error:(NSError **)error
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
- (void)pr_storesDidSaveHandler:(NSNotification *)notification
{
  [self.mainContext performBlock:^{
    [self.mainContext mergeChangesFromContextDidSaveNotification:notification];
  }];
}

/**
    Subscribe to NSPersistentStoreCoordinatorStoresWillChangeNotification
*/
- (void)pr_storesWillChangeHandler:(NSNotification *)notification
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
- (void)pr_storesDidChangeHandler:(NSNotification *)notification
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
- (void)pr_storesDidImportHandler:(NSNotification *)notification
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