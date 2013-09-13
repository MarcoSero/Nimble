// NSManagedObject+Creators.m
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


#import "NimbleStore.h"
#import "NSManagedObjectContext+NimbleContexts.h"

@implementation NSManagedObject (Creation)

+ (instancetype)nb_createInContextOfType:(NBContextType)contextType
{
  NSManagedObjectContext *context = [NSManagedObjectContext nb_contextForType:contextType];
  return [self pr_createInContext:context];
}

+ (instancetype)nb_createInContextOfType:(NBContextType)contextType initializingValuesWithDictionary:(NSDictionary *)dictionary
{
  NSParameterAssert(dictionary);

  NSManagedObject *objectCreated = [self nb_createInContextOfType:contextType];
  [dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
    [objectCreated setValue:obj forKey:key];
  }];
  return objectCreated;
}

+ (NSManagedObject *)pr_createInContext:(NSManagedObjectContext *)managedObjectContext
{
  return [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(self) inManagedObjectContext:managedObjectContext];
}

@end