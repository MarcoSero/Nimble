//
//  Created by marco on 10/08/13.
//
//
//


#import "NimbleStore+iCloud.h"
#import "NimbleStore+Defaults.h"
#import "UIDevice+Version.h"

@implementation NimbleStore (iCloud)

+ (BOOL)iCloudAvailable
{
  return [self URLForUbiquityContainer] != nil;
}


+ (BOOL)nb_setup_iCloudStore:(NSError **)error
{
  if (![self iCloudAvailable]) {
    NBLog(@"iCloud not available.");
    return [self nb_setupStore:error];
  }

  NSString *contentNameKey = @"iCloudNimbleStore";
  NSString *transactionsLogsSubdirectory = @"transactions_logs";
  return [self nb_setup_iCloudStoreWithContentNameKey:contentNameKey localStoreNamed:[self.class nb_appName] transactionsLogsSubdirectory:transactionsLogsSubdirectory error:error];
}

+ (BOOL)nb_setup_iCloudStoreWithContentNameKey:(NSString *)contentNameKey localStoreNamed:(NSString *)localStoreName transactionsLogsSubdirectory:(NSString *)logs error:(NSError **)error
{
  if([[UIDevice currentDevice] systemMajorVersion] < 7) {
    NBLog(@"No iCloud support on iOS 6! Local store will be used");
    return [NimbleStore nb_setupStoreWithFilename:localStoreName error:error];
  }

  if (![self iCloudAvailable]) {
    NBLog(@"iCloud not available. Local store will be used instead");
  }

  NSDictionary *iCloudOptions = @{
    NSPersistentStoreUbiquitousContentNameKey : contentNameKey,
    NSPersistentStoreUbiquitousContentURLKey : logs,
    NSMigratePersistentStoresAutomaticallyOption : @YES,
    NSInferMappingModelAutomaticallyOption : @YES
  };
  return [self nb_setupStoreWithName:localStoreName storeType:NSSQLiteStoreType options:iCloudOptions error:error];
}


@end