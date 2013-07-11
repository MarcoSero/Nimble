//
//  Created by marco on 10/07/13.
//
//
//


#import <Foundation/Foundation.h>
#import "NimbleStore.h"

@interface NSManagedObject (Creation)

+ (instancetype)createInContext:(NSManagedObjectContext *)managedObjectContext;
+ (instancetype)createInNimbleContext:(NimbleContextType)context;

@end