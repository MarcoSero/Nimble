// NimbleStore+Savers.h
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


#import <Foundation/Foundation.h>
#import "NimbleStore.h"

@interface NimbleStore (Savers)

+ (void)nb_saveInMain:(NimbleSimpleBlock)changes;

+ (void)nb_saveInMainWaiting:(NimbleSimpleBlock)changes;


/**
* Perform all the changes in a background queue and then merge everything into the main context
*
*/
+ (void)nb_saveInBackground:(NimbleSimpleBlock)changes;

/**
* Perform all the changes in a background queue and then merge everything into the main context.
* The completion block is called straight after the background context has been saved and
* all the changes might not be merged into the main context yet.
*
*/
+ (void)nb_saveInBackground:(NimbleSimpleBlock)changes completion:(NimbleErrorBlock)completion;

@end