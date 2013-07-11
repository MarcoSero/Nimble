//
//  Created by marco on 10/07/13.
//
//
//


#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, NimbleContextType) {
  NimbleMainContext = 0,
  NimbleBackgroundContext = 1
};

// let's try not to get crazy
typedef void (^NimbleSimpleBlock)(NimbleContextType contextType);
typedef void (^NimbleErrorBlock)(NSError *error);

@interface NimbleStore : NSObject

+ (void)setupStore;
+ (void)setupStoreWithFilename:(NSString *)filename;

/**
* Execute a fetch request in one of the contexts
*
*/
+ (NSArray *)executeFetchRequest:(NSFetchRequest *)request inContextOfType:(NimbleContextType)contextType;

+ (NSManagedObjectContext *)mainContext;
+ (NSManagedObjectContext *)backgroundContext;
+ (dispatch_queue_t)backgroundSavingQueue;

@end