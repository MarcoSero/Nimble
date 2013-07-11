//
//  Created by marco on 10/07/13.
//
//
//


#import <Foundation/Foundation.h>

// let's try not to get crazy
typedef void (^NimbleSimpleBlock)(NSManagedObjectContext *);
typedef void (^NimbleErrorBlock)(NSError *error);

typedef NS_ENUM(NSUInteger, NimbleContextType) {
  NimbleMainContext = 0,
  NimbleBackgroundContext = 1
};

@interface NimbleStore : NSObject

+ (void)setupStore;
+ (void)setupStoreWithFilename:(NSString *)filename;

/**
* Perform all the changes in a background queue and then merge everything into the main context
*
*/
+ (void)saveInBackground:(NimbleSimpleBlock)changesBlock;

/**
* Perform all the changes in a background queue and then merge everything into the main context.
* The completion block is called straight after the background context has been saved and
* all the changes might be not yet merged into the main context.
*
*/
+ (void)saveInBackground:(NimbleSimpleBlock)changesBlock withCompletion:(NimbleErrorBlock)completion;

/**
* Save the main context in the main thread using -[NSManagedObjectContext performBlock:]
*
*/
+ (void)saveMainContext:(NimbleSimpleBlock)changesBlock;

/**
* Save the main context in the main thread using -[NSManagedObjectContext performBlockAndWait:]
*
*/
+ (void)saveMainContextAndWait:(NimbleSimpleBlock)changesBlock;

/**
* If you already are outside the main thread, you can (and have to) make your changes in the background context
* This saves the background context in using -[NSManagedObjectContext performBlock:]
*
*/
+ (void)saveBackgroundContext:(NimbleSimpleBlock)changesBlock;

/**
* If you already are outside the main thread, you can (and have to) make your changes in the background context
* This saves the background context in using -[NSManagedObjectContext performBlockAndWait:]
*
*/
+ (void)saveBackgroundContextAndWait:(NimbleSimpleBlock)changesBlock;

/**
* Execute a fetch request in one of the contexts
*
*/
+ (NSArray *)executeFetchRequest:(NSFetchRequest *)request inContextOfType:(NimbleContextType)contextType;

+ (NSManagedObjectContext *)mainContext;
+ (NSManagedObjectContext *)backgroundContext;

@end