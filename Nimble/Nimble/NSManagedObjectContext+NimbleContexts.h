//
//  Created by marco on 10/07/13.
//
//
//


#import <Foundation/Foundation.h>
#import "NimbleStore.h"

@interface NSManagedObjectContext (NimbleContexts)

+ (NSManagedObjectContext *)mainContext;
+ (NSManagedObjectContext *)backgroundContext;
+ (NSManagedObjectContext *)contextForType:(NimbleContextType)contextType;

@end