//
//  Created by marco on 10/08/13.
//
//
//


#import <Foundation/Foundation.h>
#import "NimbleStore.h"

@interface NimbleStore (iCloud)

+ (BOOL)iCloudAvailable;
+ (void)nb_setup_iCloudStore;

+ (void)nb_setup_iCloudStoreWithContentNameKey:(NSString *)contentNameKey containerID:(NSString *)containerID localStoreNamed:(NSString *)localStoreName;

@end