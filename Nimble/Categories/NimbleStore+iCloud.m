// NimbleStore+iCloud.m
//
// Copyright (c) 2013 Marco Sero (http://www.marcosero.com/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


#import "NimbleStore+iCloud.h"
#import "NimbleStore+Defaults.h"
#import "UIDevice+Version.h"

@implementation NimbleStore (iCloud)

+ (BOOL)nb_iCloudAvailable
{
  return [self nb_URLForUbiquityContainer] != nil;
}

+ (BOOL)nb_setup_iCloudStore:(NSError **)error
{
  if (![self nb_iCloudAvailable]) {
    NBLog(@"iCloud not available.");
    return [self nb_setupStore:error];
  }

  NSString *contentNameKey = @"iCloudNimbleStore";
  NSString *transactionsLogsSubdirectory = @"transactions_logs";
  return [self nb_setup_iCloudStoreWithContentNameKey:contentNameKey localStoreNamed:[self.class nb_appName] transactionsLogsSubdirectory:transactionsLogsSubdirectory error:error];
}

+ (BOOL)nb_setup_iCloudStoreWithContentNameKey:(NSString *)contentNameKey localStoreNamed:(NSString *)localStoreName transactionsLogsSubdirectory:(NSString *)logs error:(NSError **)error
{
  if([[UIDevice currentDevice] systemMajorVersion] < 7) {
    NBLog(@"No iCloud support on iOS 6! Local store will be used");
    return [NimbleStore nb_setupStoreWithFilename:localStoreName error:error];
  }

  if (![self nb_iCloudAvailable]) {
    NBLog(@"iCloud not available. Local store will be used instead");
  }

  NSDictionary *iCloudOptions = @{
    NSPersistentStoreUbiquitousContentNameKey : contentNameKey,
    NSPersistentStoreUbiquitousContentURLKey : logs,
    NSMigratePersistentStoresAutomaticallyOption : @YES,
    NSInferMappingModelAutomaticallyOption : @YES
  };
  return [self nb_setupStoreWithName:localStoreName storeType:NSSQLiteStoreType options:iCloudOptions error:error];
}


@end