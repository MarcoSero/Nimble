//
//  main.m
//  Nimble
//
//  Created by Marco Sero on 10/07/13.
//  Copyright (c) 2013 Marco Sero. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

@interface TestAppDelegate : UIResponder <UIApplicationDelegate>
@end
@implementation TestAppDelegate
@end

int main(int argc, char *argv[]) {
  @autoreleasepool {
    BOOL isRunningTests = NSClassFromString(@"XCTest") != nil;
    Class appDelegateClass = isRunningTests ? TestAppDelegate.class : AppDelegate.class;
    return UIApplicationMain(argc, argv, nil, NSStringFromClass(appDelegateClass));
  }
}
