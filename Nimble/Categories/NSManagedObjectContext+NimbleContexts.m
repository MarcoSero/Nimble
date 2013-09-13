//
//  Created by marco on 10/07/13.
//
//
//


#import "NSManagedObjectContext+NimbleContexts.h"
#import "NimbleStore.h"


@implementation NSManagedObjectContext (NimbleContexts)

+ (NSManagedObjectContext *)nb_mainContext
{
  return [NimbleStore nb_mainContext];
}

+ (NSManagedObjectContext *)nb_backgroundContext
{
  return [NimbleStore nb_backgroundContext];
}

+ (NSManagedObjectContext *)nb_contextForType:(NimbleContextType)contextType
{
  if (contextType == NBMainContext) {
    return [self nb_mainContext];
  }
  return [self nb_backgroundContext];
}


+ (NimbleContextType)nb_contextTypeForCurrentThread
{
  if ([NSThread isMainThread]) {
    return NBMainContext;
  }
  return NBBackgroundContext;
}
@end