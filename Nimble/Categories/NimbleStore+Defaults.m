//
//  Created by marco on 10/07/13.
//
//
//


#import "NimbleStore+Defaults.h"


@implementation NimbleStore (Defaults)

+ (NSString *)nb_defaultStoreName
{
  return [NSString stringWithFormat:@"%@.sqlite", [[NSBundle mainBundle] infoDictionary][@"CFBundleDisplayName"]];
}

+ (NSString *)nb_applicationDocumentsDirectory
{
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  return ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
}

@end