// NimbleStore.h
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


#import <Foundation/Foundation.h>

#define NBLog(...) NSLog(@"Nimble >> %s\n\t%@", __PRETTY_FUNCTION__, [NSString stringWithFormat:__VA_ARGS__])

/**
* Context types
*
* */
typedef NS_ENUM(NSUInteger, NBContextType) {
  NBMainContext = 0,
  NBBackgroundContext = 1
};


/**
* Notifications
*
* */
extern NSString *const NBCloudStoreWillReplaceLocalStore;
extern NSString *const NBCloudStoreDidReplaceLocalStore;

/**
* Errors and exceptions
*
* */
extern NSString *const NBPersistentStoreException;
extern NSString *const NBNimbleErrorDomain;

// let's try not to get crazy
typedef void (^NimbleSimpleBlock)(NBContextType contextType);
typedef void (^NimbleArrayWithErrorBlock)(NSArray *array, NSError *error);
typedef void (^NimbleObjectWithErrorBlock)(NSManagedObject *object, NSError *error);
typedef void (^NimbleErrorBlock)(NSError *error);

@interface NimbleStore : NSObject

/**
  Setup a in-memory store
*/
+ (BOOL)nb_setupInMemoryStore:(NSError * __autoreleasing*)error;

/**
  Setup a store with the default filename
*/
+ (BOOL)nb_setupStore:(NSError * __autoreleasing*)error;

/**
  Setup a store with a custom filename
*/
+ (BOOL)nb_setupStoreWithFilename:(NSString *)filename error:(NSError * __autoreleasing*)error;

/**
  Setup a custom store with a custom file name
*/
+ (BOOL)nb_setupStoreWithName:(NSString *)filename storeType:(NSString * const)storeType error:(NSError * __autoreleasing*)error;

/**
  Setup a custom store with a custom name, also passing specific options
*/
+ (BOOL)nb_setupStoreWithName:(NSString *)filename storeType:(NSString * const)storeType options:(NSDictionary *)options error:(NSError * __autoreleasing*)error;

/**
 Teardown existing Core Data setup
*/
+ (void)teardown;

/**
  Execute a fetch request in one of the contexts.
  It will use the same thread of the context your fetching from.
*/
+ (NSArray *)nb_executeFetchRequest:(NSFetchRequest *)request inContextOfType:(NBContextType)contextType error:(NSError *__autoreleasing*)error;

/**
  Shortcut to access main context
*/
+ (NSManagedObjectContext *)nb_mainContext;

/**
  Shortcut to access background context
*/
+ (NSManagedObjectContext *)nb_backgroundContext;

@end