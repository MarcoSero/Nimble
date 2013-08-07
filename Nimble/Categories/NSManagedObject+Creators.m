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

+ (instancetype)nb_createInContextOfType:(NimbleContextType)contextType initializingPropertiesWithDictionary:(NSDictionary *)dictionary
{
  NSParameterAssert(dictionary);

  NSManagedObject *objectCreated = [self nb_createInContextOfType:contextType];
  [dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
    [objectCreated setValue:obj forKey:key];
  }];
  return objectCreated;
}

+ (NSManagedObject *)createInContext:(NSManagedObjectContext *)managedObjectContext
{
  return [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(self) inManagedObjectContext:managedObjectContext];
}

@end