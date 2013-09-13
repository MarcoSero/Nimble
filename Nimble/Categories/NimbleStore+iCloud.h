//
//  Created by marco on 10/08/13.
//
//
//


#import <Foundation/Foundation.h>
#import "NimbleStore.h"

@interface NimbleStore (iCloud)

+ (BOOL)nb_iCloudAvailable;

+ (BOOL)nb_setup_iCloudStore:(NSError **)error;

+ (BOOL)nb_setup_iCloudStoreWithContentNameKey:(NSString *)contentNameKey localStoreNamed:(NSString *)localStoreName transactionsLogsSubdirectory:(NSString *)logs error:(NSError **)error;


@end