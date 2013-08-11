//
//  Created by marco on 10/07/13.
//
//
//


#import <Foundation/Foundation.h>
#import "NimbleStore.h"

@interface NSManagedObjectContext (NimbleContexts)

+ (NSManagedObjectContext *)nb_mainContext;

+ (NSManagedObjectContext *)nb_backgroundContext;

+ (NSManagedObjectContext *)nb_contextForType:(NimbleContextType)contextType;

+ (NimbleContextType)nb_contextTypeForCurrentThread;

@end