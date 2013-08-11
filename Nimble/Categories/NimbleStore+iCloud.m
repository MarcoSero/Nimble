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

  NSString *contentNameKey = @"iCloudNimbleStore";
  NSString *transactionsLogsSubdirectory = @"transactions_logs";
  [self nb_setup_iCloudStoreWithContentNameKey:contentNameKey localStoreNamed:[self.class nb_appName] transactionsLogsSubdirectory:transactionsLogsSubdirectory];
}

+ (void)nb_setup_iCloudStoreWithContentNameKey:(NSString *)contentNameKey localStoreNamed:(NSString *)localStoreName transactionsLogsSubdirectory:(NSString *)logs
{
  BOOL iCloudAvailable = [self iCloudAvailable];
  if (!iCloudAvailable) {
    NSLog(@"iCloud not available.");
  }

  NSDictionary *iCloudOptions = @{
    NSPersistentStoreUbiquitousContentNameKey : contentNameKey,
    NSPersistentStoreUbiquitousContentURLKey : logs,
    NSMigratePersistentStoresAutomaticallyOption : @YES,
    NSInferMappingModelAutomaticallyOption : @YES,
    NSPersistentStoreRebuildFromUbiquitousContentOption : @YES
  };
  [self nb_setupStoreWithName:localStoreName storeType:NSSQLiteStoreType iCloudEnabled:iCloudAvailable options:iCloudOptions];
}

@end