//
//  Created by marco on 11/07/13.
//
//
//

#import <objc/runtime.h>
#import "NimbleStore+Savers.h"
#import "NSManagedObjectContext+NimbleContexts.h"
#import "NimbleStore+Defaults.h"

@implementation NimbleStore (Savers)

+ (void)saveInProperContext:(NimbleSimpleBlock)changes
{
  NSParameterAssert(changes);

  NimbleContextType contextType = [NSManagedObjectContext contextTypeForCurrentThread];
  NSManagedObjectContext *context = [NSManagedObjectContext contextForType:contextType];

  [context performBlock:^{
    changes(contextType);
    [context save:nil];
  }];
}

+ (void)saveInProperContextAndWait:(NimbleSimpleBlock)changes
{
  NSParameterAssert(changes);

  NimbleContextType contextType = [NSManagedObjectContext contextTypeForCurrentThread];
  NSManagedObjectContext *context = [NSManagedObjectContext contextForType:contextType];

  [context performBlockAndWait:^{
    changes(contextType);
    [context save:nil];
  }];
}

+ (void)saveInBackground:(NimbleSimpleBlock)changes
{
  [self saveInBackground:changes completion:nil];
}

+ (void)saveInBackground:(NimbleSimpleBlock)changes completion:(NimbleErrorBlock)completion
{
  NSParameterAssert(changes);

  dispatch_async([self backgroundSavingQueue], ^{

    NSManagedObjectContext *backgroundContext = [NSManagedObjectContext backgroundContext];
    [backgroundContext performBlockAndWait:^{
      changes(NimbleBackgroundContext);
      [backgroundContext save:nil];
    }];

    dispatch_async(dispatch_get_main_queue(), ^{
      if (completion) {
        completion(nil);
      }
    });
  });
}


@end