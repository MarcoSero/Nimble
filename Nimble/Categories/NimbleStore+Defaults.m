// NimbleStore+Defaults.m
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


#import "NimbleStore+Defaults.h"


@implementation NimbleStore (Defaults)

+ (NSString *)nb_appName
{
  return [[NSBundle mainBundle] infoDictionary][@"CFBundleDisplayName"];
}

+ (NSString *)nb_defaultStoreName
{
  return [NSString stringWithFormat:@"%@.sqlite", [self nb_appName]];
}

+ (NSString *)nb_applicationDocumentsDirectory
{
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  return ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
}

+ (NSURL *)nb_URLToStoreWithFilename:(NSString *)filename
{
  NSString *fileURL = [NSString localizedStringWithFormat:@"%@/%@", [self.class nb_applicationDocumentsDirectory], filename];
  NSURL *localStoreURL = [NSURL fileURLWithPath:fileURL];
  return localStoreURL;
}

+ (NSURL *)nb_URLForUbiquityContainer
{
  return [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
}

+ (NSURL *)nb_iCloudURLToStoreWithFilename:(NSString *)filename
{
  NSString *fileURL = [NSString localizedStringWithFormat:@"%@/%@", [self.class nb_URLForUbiquityContainer], filename];
  NSURL *localStoreURL = [NSURL fileURLWithPath:fileURL];
  return localStoreURL;
}


@end