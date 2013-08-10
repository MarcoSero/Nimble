//
//  Created by marco on 10/08/13.
//
//
//


#import "NimbleStore+iCloud.h"
#import "NimbleStore+Defaults.h"


@implementation NimbleStore (iCloud)

+ (BOOL)iCloudAvailable
{
  return [self URLForUbiquityContainer] != nil;
}

+ (NSURL *)URLForUbiquityContainer
{
  return [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
}

+ (void)nb_setup_iCloudStore
{
  if (![self iCloudAvailable]) {
    NSLog(@"iCloud not available.");
    [self nb_setupStore];
    return;
  }

  NSString *containerID = [[[NSBundle mainBundle] infoDictionary] objectForKey:(id)kCFBundleIdentifierKey];
  NSString *contentNameKey = @"iCloudNimbleStore";

  [self nb_setup_iCloudStoreWithContentNameKey:contentNameKey containerID:containerID localStoreNamed:[self.class nb_appName]];
}

+ (void)nb_setup_iCloudStoreWithContentNameKey:(NSString *)contentNameKey containerID:(NSString *)containerID localStoreNamed:(NSString *)localStoreName
{
  BOOL iCloudAvailable = [self iCloudAvailable];
  if (!iCloudAvailable) {
    NSLog(@"iCloud not available.");
  }

  NSDictionary *iCloudOptions = @{
    NSPersistentStoreUbiquitousContentNameKey : contentNameKey,
    NSPersistentStoreUbiquitousContentURLKey : @"logs",
    NSMigratePersistentStoresAutomaticallyOption : @(YES),
    NSInferMappingModelAutomaticallyOption : @(YES),
    NSPersistentStoreRebuildFromUbiquitousContentOption : @YES,
//    NSPersistentStoreUbiquitousContainerIdentifierKey : containerID
  };
  [self nb_setupStoreWithName:localStoreName storeType:NSSQLiteStoreType iCloudEnabled:iCloudAvailable options:iCloudOptions];
}

@end