//
//  Created by marco on 10/07/13.
//
//
//


#import <Foundation/Foundation.h>

#define NBLog(...) NSLog(@"Nimble >> %s\n\t%@", __PRETTY_FUNCTION__, [NSString stringWithFormat:__VA_ARGS__])

/**
* Context types
*
* */
typedef NS_ENUM(NSUInteger, NimbleContextType) {
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
typedef void (^NimbleSimpleBlock)(NimbleContextType contextType);
typedef void (^NimbleArrayWithErrorBlock)(NSArray *array, NSError *error);
typedef void (^NimbleObjectWithErrorBlock)(NSManagedObject *object, NSError *error);
typedef void (^NimbleErrorBlock)(NSError *error);

@interface NimbleStore : NSObject

+ (BOOL)nb_setupInMemoryStore:(NSError **)error;

+ (BOOL)nb_setupStore:(NSError **)error;

+ (BOOL)nb_setupStoreWithFilename:(NSString *)filename error:(NSError **)error;

+ (BOOL)nb_setupStoreWithName:(NSString *)filename storeType:(NSString * const)storeType error:(NSError **)error;

/**
  Shortcut to access main context
*/
+ (BOOL)nb_setupStoreWithName:(NSString *)filename storeType:(NSString * const)storeType options:(NSDictionary *)options error:(NSError **)error;

/**
  Execute a fetch request in one of the contexts.
  It will use the same thread of the context your fetching from.
*/
+ (NSArray *)nb_executeFetchRequest:(NSFetchRequest *)request inContextOfType:(NimbleContextType)contextType error:(NSError **)error;

/**
  Shortcut to access main context
*/
+ (NSManagedObjectContext *)nb_mainContext;

/**
  Shortcut to access background context
*/
+ (NSManagedObjectContext *)nb_backgroundContext;

@end