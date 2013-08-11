//
//  Created by marco on 10/07/13.
//
//
//


#import <Foundation/Foundation.h>
#import "NimbleStore.h"

@interface NSManagedObject (Creation)

+ (instancetype)nb_createInContextOfType:(NimbleContextType)contextType;

+ (instancetype)nb_createInContextOfType:(NimbleContextType)contextType initializingPropertiesWithDictionary:(NSDictionary *)dictionary;

@end