//
//  Created by marco on 10/07/13.
//
//
//


#import <Foundation/Foundation.h>
#import "NimbleStore.h"

@interface NSManagedObject (Creation)

+ (instancetype)createInContextOfType:(NimbleContextType)contextType;
+ (NSManagedObject *)createInContext:(NSManagedObjectContext *)managedObjectContext;

@end