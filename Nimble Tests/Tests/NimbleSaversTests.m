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
}

- (void)tearDown
{
  [super tearDown];
}

- (void)testSaveInBackground
{
  [NimbleStore saveInBackground:^(NimbleContextType contextType) {
    XCTAssertFalse(([NSThread mainThread]), @"Is not main thread");
  } completion:^(NSError *error) {
    XCTAssertTrue(([NSThread mainThread]), @"Is main thread");
  }];
}

- (void)testSaveInProperContextUsingMainThread
{
  [NimbleStore saveInProperContext:^(NimbleContextType contextType) {
    XCTAssertTrue(([NSThread mainThread]), @"Is main thread");
  }];
}

- (void)testSaveInProperContextUsingBackgroundThread
{
  dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    [NimbleStore saveInProperContext:^(NimbleContextType contextType) {
      XCTAssertTrue(([NSThread mainThread]), @"Is not main thread");
    }];
  });
}

@end