//
//  Created by marco on 10/07/13.
//
//
//


#import "NimbleStore+Defaults.h"


@implementation NimbleStore (Defaults)

+ (NSString *)nb_appName
{
  return [[NSBundle mainBundle] infoDictionary][@"CFBundleDisplayName"];
}

+ (NSString *)nb_defaultStoreName
{
  return [NSString stringWithFormat:@"%@.sqlite", [self nb_appName]];
}

+ (NSString *)nb_applicationDocumentsDirectory
{
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  return ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
}

+ (NSURL *)nb_URLToStoreWithFilename:(NSString *)filename
{
  NSString *fileURL = [NSString localizedStringWithFormat:@"%@/%@", [self.class nb_applicationDocumentsDirectory], filename];
  NSURL *localStoreURL = [NSURL fileURLWithPath:fileURL];
  return localStoreURL;
}

+ (NSURL *)URLForUbiquityContainer
{
  return [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
}

+ (NSURL *)nb_iCloudURLToStoreWithFilename:(NSString *)filename
{
  NSString *fileURL = [NSString localizedStringWithFormat:@"%@/%@", [self.class URLForUbiquityContainer], filename];
  NSURL *localStoreURL = [NSURL fileURLWithPath:fileURL];
  return localStoreURL;
}


@end