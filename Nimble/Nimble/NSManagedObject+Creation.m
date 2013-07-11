//
//  Created by marco on 10/07/13.
//
//
//


#import "NSManagedObject+Creation.h"


@implementation NSManagedObject (Creation)

+ (instancetype)createInNimbleContext:(NimbleContextType)context
{
  NSManagedObjectContext *managedObjectContext;
  if (context == NimbleMainContext) {
    managedObjectContext = [NimbleStore mainContext];
  }
  else {
    managedObjectContext = [NimbleStore backgroundContext];
  }
  return [self createInContext:managedObjectContext];
}

+ (NSManagedObject *)createInContext:(NSManagedObjectContext *)managedObjectContext
{
  return [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(self) inManagedObjectContext:managedObjectContext];
}

@end