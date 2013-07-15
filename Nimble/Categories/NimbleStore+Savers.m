//
//  Created by marco on 11/07/13.
//
//
//

#import <objc/runtime.h>
#import "NimbleStore+Savers.h"
#import "NSManagedObjectContext+NimbleContexts.h"
#import "NimbleStore+Defaults.h"

#define MainThreadAssert NSAssert([NSThread isMainThread], @"%p has been called outside the main thread. Use saveBackgroundContext if you are in a background context", _cmd)
#define BackgroundThreadAssert NSAssert([NSThread isMainThread], @"%p has been called inside the main thread. Use the other savers if you are in the main context", _cmd)

@implementation NimbleStore (Savers)

+ (void)nb_saveInProperContext:(NimbleSimpleBlock)changes
{
  NSParameterAssert(changes);

  NimbleContextType contextType = [NSManagedObjectContext nb_contextTypeForCurrentThread];
  NSManagedObjectContext *context = [NSManagedObjectContext nb_contextForType:contextType];

  [context performBlock:^{
    changes(contextType);
    [context save:nil];
  }];
}

+ (void)nb_saveInProperContextAndWait:(NimbleSimpleBlock)changes
{
  NSParameterAssert(changes);

  NimbleContextType contextType = [NSManagedObjectContext nb_contextTypeForCurrentThread];
  NSManagedObjectContext *context = [NSManagedObjectContext nb_contextForType:contextType];

  [context performBlockAndWait:^{
    changes(contextType);
    [context save:nil];
  }];
}

+ (void)nb_saveInBackground:(NimbleSimpleBlock)changes
{
  [self nb_saveInBackground:changes completion:nil];
}

+ (void)nb_saveInBackground:(NimbleSimpleBlock)changes completion:(NimbleErrorBlock)completion
{
  NSParameterAssert(changes);

  [[self nb_queueForBackgroundSavings] addOperationWithBlock:^{

    NSManagedObjectContext *backgroundContext = [NSManagedObjectContext nb_backgroundContext];
    [backgroundContext performBlockAndWait:^{
      changes(NimbleBackgroundContext);
      [backgroundContext save:nil];
    }];

    dispatch_async(dispatch_get_main_queue(), ^{
      if (completion) {
        completion(nil);
      }
    });

  }];
}


@end