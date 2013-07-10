//
//  Created by marco on 10/07/13.
//
//
//


#import <Foundation/Foundation.h>

@interface NSManagedObjectContext (NimbleContexts)

+ (NSManagedObjectContext *)mainContext;
+ (NSManagedObjectContext *)backgroundContext;

@end