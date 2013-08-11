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

+ (void)nb_saveInMain:(NimbleSimpleBlock)changes
{
  NSParameterAssert(changes);

  NSManagedObjectContext *context = [NSManagedObjectContext nb_mainContext];

  [context performBlock:^{

    changes(NimbleMainContext);

    NSError *error;
    [context save:&error];

    if (error) {
      NBLog(@"Error saving main context: %@", error);
    }

  }];
}

+ (void)nb_saveInMainWaiting:(NimbleSimpleBlock)changes
{
  NSParameterAssert(changes);

  NSManagedObjectContext *context = [NSManagedObjectContext nb_mainContext];

  [context performBlockAndWait:^{

    changes(NimbleMainContext);

    NSError *error;
    [context save:&error];

    if (error) {
      NBLog(@"Error saving main context: %@", error);
    }

  }];
}

+ (void)nb_saveInBackground:(NimbleSimpleBlock)changes
{
  [self nb_saveInBackground:changes completion:nil];
}

+ (void)nb_saveInBackground:(NimbleSimpleBlock)changes completion:(NimbleErrorBlock)completion
{
  NSParameterAssert(changes);

  NSManagedObjectContext *backgroundContext = [NSManagedObjectContext nb_backgroundContext];

  [backgroundContext performBlockAndWait:^{

    changes(NimbleBackgroundContext);

    NSError *error;
    [backgroundContext save:&error];

    if (error) {
      NBLog(@"Error saving background context: %@", error);
    }

    if (completion) {
      dispatch_async(dispatch_get_main_queue(), ^{
        completion(nil);
      });
    }

  }];

}


@end