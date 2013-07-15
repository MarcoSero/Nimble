//
//  NimbleStackCreationTest.m
//  Nimble
//
//  Created by Marco Sero on 14/07/13.
//  Copyright (c) 2013 Marco Sero. All rights reserved.
//

#import "NimbleStore.h"
#import "NimbleStore+Defaults.h"

@interface NimbleStackCreationTests : XCTestCase
@property (strong, nonatomic) NSString *customStoreName;
@property (strong, nonatomic) NSString *defaultPath;
@property (strong, nonatomic) NSString *customPath;
@end

@implementation NimbleStackCreationTests

- (void)setUp
{
  [super setUp];
  _customStoreName = @"Store_1.sqlite";
  _defaultPath = [NSString stringWithFormat:@"%@/%@", [NimbleStore applicationDocumentsDirectory], [NimbleStore defaultStoreName]];
  _customPath = [NSString stringWithFormat:@"%@/%@", [NimbleStore applicationDocumentsDirectory], _customPath];
  [[NSFileManager defaultManager] removeItemAtPath:_defaultPath error:nil];
  [[NSFileManager defaultManager] removeItemAtPath:_customPath error:nil];
}

- (void)tearDown
{  
  [super tearDown];
}

- (void)testDefaultSetup
{
  [NimbleStore setupStore];
  XCTAssertTrue([[NSFileManager defaultManager] fileExistsAtPath:_defaultPath]);
}

- (void)testDoubleSetup
{
  XCTAssertThrows(([NimbleStore setupStoreWithFilename:_customStoreName]), @"");
}

@end