//
//  Created by marco on 10/07/13.
//
//
//


#import <Foundation/Foundation.h>
#import "NimbleStore.h"

@interface NimbleStore (Defaults)

+ (NSString *)nb_appName;
+ (NSString *)nb_defaultStoreName;
+ (NSString *)nb_applicationDocumentsDirectory;

@end