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
  NSURL *URLForUbiquityContainerIdentifier = [self URLForUbiquityContainer];
  if (!URLForUbiquityContainerIdentifier) {
    NSLog(@"iCloud not available.");
    [self nb_setupStore];
    return;
  }

  NSString* coreDataCloudContent = [[URLForUbiquityContainerIdentifier path] stringByAppendingPathComponent:[self.class nb_defaultStoreName]];
  NSURL *cloudURL = [NSURL fileURLWithPath:coreDataCloudContent];
  NSString *containerID = [[[NSBundle mainBundle] infoDictionary] objectForKey:(id)kCFBundleIdentifierKey];
  NSString *contentNameKey = @"iCloudNimbleStore";

  [self nb_setup_iCloudStoreWithCloudURL:cloudURL localStoreNamed:[self.class nb_defaultStoreName] containerID:containerID contentNameKey:contentNameKey];
}

+ (void)nb_setup_iCloudStoreWithCloudURL:(NSURL *)cloudURL localStoreNamed:(NSString *)localStoreName containerID:(NSString *)containerID contentNameKey:(NSString *)contentNameKey
{
  BOOL iCloudAvailable = [self iCloudAvailable];
  if (!iCloudAvailable) {
    NSLog(@"iCloud not available.");
  }

  NSDictionary *iCloudOptions = @{
    NSPersistentStoreUbiquitousContentNameKey : contentNameKey,
    NSPersistentStoreUbiquitousContentURLKey : cloudURL,
    NSMigratePersistentStoresAutomaticallyOption : @(YES),
    NSInferMappingModelAutomaticallyOption : @(YES),
//    NSPersistentStoreUbiquitousContainerIdentifierKey : containerID,
//    NSPersistentStoreRebuildFromUbiquitousContentOption : @YES,
//    NSPersistentStoreRemoveUbiquitousMetadataOption: @YES
  };
  [self nb_setupStoreWithName:localStoreName storeType:NSSQLiteStoreType iCloudEnabled:iCloudAvailable options:iCloudOptions];
}

@end