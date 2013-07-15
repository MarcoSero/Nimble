//
//  Created by marco on 10/07/13.
//
//
//


#import "NimbleStore.h"
#import "NSManagedObjectContext+NimbleContexts.h"

@implementation NSManagedObject (Creation)

+ (instancetype)nb_createInContextOfType:(NimbleContextType)contextType
{
  NSManagedObjectContext *context = [NSManagedObjectContext nb_contextForType:contextType];
  return [self createInContext:context];
}

+ (NSManagedObject *)createInContext:(NSManagedObjectContext *)managedObjectContext
{
  return [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(self) inManagedObjectContext:managedObjectContext];
}

@end