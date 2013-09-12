//
//  NimbleStackCreationTest.m
//  Nimble
//
//  Created by Marco Sero on 14/07/13.
//  Copyright (c) 2013 Marco Sero. All rights reserved.
//

#import "NimbleStore.h"

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
  _defaultPath = [NSString stringWithFormat:@"%@/%@", [NimbleStore nb_applicationDocumentsDirectory], [NimbleStore nb_defaultStoreName]];
  _customPath = [NSString stringWithFormat:@"%@/%@", [NimbleStore nb_applicationDocumentsDirectory], _customPath];
  [[NSFileManager defaultManager] removeItemAtPath:_defaultPath error:nil];
  [[NSFileManager defaultManager] removeItemAtPath:_customPath error:nil];
}

- (void)tearDown
{  
  [super tearDown];
}

- (void)testFirstSetup
{
  [NimbleStore nb_setupStore:nil];
  XCTAssertTrue([[NSFileManager defaultManager] fileExistsAtPath:_defaultPath]);
}

- (void)testSecondSetup
{
  XCTAssertThrows(([NimbleStore nb_setupStoreWithFilename:_customStoreName error:nil]), @"");
}

@end