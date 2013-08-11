# Nimble

Core Data (and iCloud) made *nimble* and fast.

## Why

The answer is quite easy. I needed a Core Data wrapper with these features:

- easy setup and easy finders like MagicalRecord has
- just 2 contexts: one for the main thread and the other for the background ones, because as someone has actually proved, this is much faster than parent+children. Read [here](http://floriankugler.com/blog/2013/4/29/concurrent-core-data-stack-performance-shootout) and [here](http://floriankugler.com/blog/2013/5/11/backstage-with-nested-managed-object-contexts)
- iOS 7's new iCloud API

## Install

CocoaPods makes our lifes easy :)

    pod "Nimble"

and then import `Nimble.h` into your prefix file.

## Tests

Most of the code has been tested with the new `XCTest`.

## How it works

First, set up the local or cloud store based on what you need

    [NimbleStore nb_setupStore:&error];
    // OR
    [NimbleStore nb_setup_iCloudStore:&error]

The iCloud set up, thanks to iOS 7's API is completely asynchronous and a local store is created ready to use waiting for the iCloud's one.

### Savers

Easily save in main or background thread, everithing is then merged into the main context

    [NimbleStore nb_saveInBackground:^(NimbleContextType contextType) {
      Book *book = [Book nb_createInContextOfType:contextType];
      book.name = @"Best book ever";
    }];


### Creators

You can create a new object with 

    [YourModelObject nb_createInContextOfType:NimbleMainContext];

to create an object and in the same time initialize some of its property, you can just use

    [YourModelObject nb_createInContextOfType:NimbleMainContext initializingPropertiesWithDictionary:@{
        @"name" : @"Marco" ,
        @"surname" : @"Sero"
    }];

### Finders and fetchers

You can find all type of finders and fetchers in `NSManagedObject+Finders.h`

### Removing the nb_ prefix

If you want to use Nimble without the `nb_` prefix, you can just define `NBVeryNimble` before the main import

    #define NBVeryNimble
    #import "Nimble.h"

## Contact

Marco Sero

- http://www.marcosero.com
- http://twitter.com/marcosero 
- marco@marcosero.com

## License

Nimble is available under the MIT license. Here's a copy:

Copyright (c) 2013 Marco Sero (http://www.marcosero.com)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.