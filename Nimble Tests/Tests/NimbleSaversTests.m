//
//  Created by marco on 15/07/13.
//
//
//



#import "Book.h"

@interface NimbleSaversTests : XCTestCase
@end

@implementation NimbleSaversTests

- (void)setUp
{
  [super setUp];
  [NimbleStore nb_setupInMemoryStore];
}

- (void)tearDown
{
  [super tearDown];
}

- (void)testSaveInBackground
{
  [NimbleStore nb_saveInBackground:^(NimbleContextType contextType) {
    XCTAssertFalse(([NSThread mainThread]), @"Is not main thread");
  }                     completion:^(NSError *error) {
    XCTAssertTrue(([NSThread mainThread]), @"Is main thread");
  }];
}

- (void)testSaveInProperContextUsingMainThread
{
  [NimbleStore nb_saveInProperContext:^(NimbleContextType contextType) {
    XCTAssertTrue(([NSThread mainThread]), @"Is main thread");
  }];
}

- (void)testSaveInProperContextUsingBackgroundThread
{
  dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    [NimbleStore nb_saveInProperContext:^(NimbleContextType contextType) {
      XCTAssertTrue(([NSThread mainThread]), @"Is not main thread");
    }];
  });
}

@end