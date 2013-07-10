//
//  Created by marco on 10/07/13.
//
//
//


#import <Foundation/Foundation.h>

// let's try not to get crazy
typedef void (^NimbleSimpleBlock)(NSManagedObjectContext *);
typedef void (^NimbleErrorBlock)(NSError *error);

typedef NS_ENUM(NSUInteger, NimbleContext) {
  NimbleMainContext = 0,
  NimbleBackgroundContext = 1
};

@interface NimbleStore : NSObject

+ (void)setupStore;
+ (void)setupStoreWithFilename:(NSString *)filename;

+ (void)saveMainContextWithChanges:(NimbleSimpleBlock)changesBlock;
+ (void)saveBackgroundContextWithChanges:(NimbleSimpleBlock)changesBlock;
+ (void)saveMainContextWithChangesAndWait:(NimbleSimpleBlock)changesBlock;
+ (void)saveBackgroundContextWithChangesAndWait:(NimbleSimpleBlock)changesBlock;

+ (NSArray *)executeFetchRequest:(NSFetchRequest *)request inContext:(NimbleContext)context;

+ (NSManagedObjectContext *)mainContext;
+ (NSManagedObjectContext *)backgroundContext;

@end