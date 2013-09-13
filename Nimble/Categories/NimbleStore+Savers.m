// NimbleStore+Savers.m
//
// Copyright (c) 2013 Marco Sero (http://www.marcosero.com/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

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

    changes(NBMainContext);

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

    changes(NBMainContext);

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

  [backgroundContext performBlock:^{

    changes(NBBackgroundContext);

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