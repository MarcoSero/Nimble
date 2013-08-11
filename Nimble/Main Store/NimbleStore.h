//
//  Created by marco on 10/07/13.
//
//
//


#import <Foundation/Foundation.h>

#define NBLog(...) NSLog(@"Nimble >> %s\n\t%@", __PRETTY_FUNCTION__, [NSString stringWithFormat:__VA_ARGS__])

typedef NS_ENUM(NSUInteger, NimbleContextType) {
  NimbleMainContext = 0,
  NimbleBackgroundContext = 1
};

extern NSString *const NBStoreReplacedByCloudStore;

// let's try not to get crazy
typedef void (^NimbleSimpleBlock)(NimbleContextType contextType);

typedef void (^NimbleErrorBlock)(NSError *error);

@interface NimbleStore : NSObject

+ (void)nb_setupInMemoryStore:(NSError **)error;

+ (void)nb_setupStore:(NSError **)error;

+ (void)nb_setupStoreWithFilename:(NSString *)filename error:(NSError **)error;

+ (void)setupStoreWithName:(NSString *)filename storeType:(NSString * const)storeType error:(NSError **)error;

+ (void)nb_setupStoreWithName:(NSString *)filename storeType:(NSString * const)storeType iCloudEnabled:(BOOL)iCloudEnabled options:(NSDictionary *)options error:(NSError **)error;

+ (BOOL)nb_removeAllStores:(NSError **)error;

/**
* Execute a fetch request in one of the contexts
*
*/
+ (NSArray *)nb_executeFetchRequest:(NSFetchRequest *)request inContextOfType:(NimbleContextType)contextType error:(NSError **)error;

+ (NSManagedObjectContext *)nb_mainContext;

+ (NSManagedObjectContext *)nb_backgroundContext;

@end