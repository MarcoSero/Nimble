//
//  Created by marco on 17/08/13.
//
//
//


#import "UIDevice+Version.h"

@implementation UIDevice (Version)

- (NSUInteger)systemMajorVersion
{
  NSString *versionString;
  versionString = [self systemVersion];
  return (NSUInteger)[versionString doubleValue];
}

@end