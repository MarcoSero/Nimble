//
//  Created by marco on 15/07/13.
//
//
//



#import "Book.h"
#import "NimbleStore.h"

@interface NimbleSaversTests : XCTestCase
@end

@implementation NimbleSaversTests

- (void)setUp
{
  [super setUp];
  [NimbleStore nb_setupInMemoryStore:nil];
}

- (void)tearDown
{
  [super tearDown];
  [NimbleStore teardown];
}

- (void)testSaveInMainThread
{
  [NimbleStore nb_saveInMain:^(NBContextType contextType) {
    XCTAssertTrue(([NSThread mainThread]), @"Is main thread");
  }];
}

- (void)testSaveInBackground
{
  [NimbleStore nb_saveInBackground:^(NBContextType contextType) {
    XCTAssertFalse(([NSThread isMainThread]), @"Not main thread");
  }                     completion:^(NSError *error) {
    XCTAssertTrue(([NSThread isMainThread]), @"Main thread");
  }];
}


@end