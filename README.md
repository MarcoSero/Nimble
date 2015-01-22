

# Nimble

Core Data (and iCloud) made *nimble* and fast.

## Why

The answer is quite easy. I needed a Core Data wrapper with these features:

- Easy setup and finders (anyone said MagicalRecord?)
- Simple architecture with a main and a background context. A lot has been written about how much faster are 2 context rather than parent+children. Read [here](http://floriankugler.com/blog/2013/4/29/concurrent-core-data-stack-performance-shootout) and [here](http://floriankugler.com/blog/2013/5/11/backstage-with-nested-managed-object-contexts) if you're interested
- iOS 7 and iCloud ready (but still compatible)

## Install

CocoaPods makes our lifes easy :)

    pod "Nimble-CoreData"

and then import `Nimble.h` into your prefix file.

## How it works

First, set up the local or cloud store based on what you need

    [NimbleStore nb_setupStore:&error];
    // OR
    [NimbleStore nb_setup_iCloudStore:&error]

The iCloud set up, thanks to iOS 7's API is natively completely asynchronous and a local store is created ready to use waiting for the iCloud's one.  
At this moment, iCloud is available for iOS 7 only as it is not good enough in iOS 6.

### Savers

Easily save in main or background thread, everything is then merged into the main context

    [NimbleStore nb_saveInBackground:^(NBContextType contextType) {
      Book *book = [Book nb_createInContextOfType:contextType];
      book.name = @"Best book ever";
    }];


### Creators

You can create a new object with 

    [YourModelObject nb_createInContextOfType:NBMainContext];

to create an object and in the same time initialize some of its property, you can just use

    [YourModelObject nb_createInContextOfType:NBMainContext initializingPropertiesWithDictionary:@{
        @"name" : @"Marco" ,
        @"surname" : @"Sero"
    }];

### Finders and fetchers

You can find all type of finders and fetchers in `NSManagedObject+Finders.h`

For example, to fetch and change an object in background you can just do:

    [NimbleStore nb_saveInBackground:^(NBContextType contextType) {
      Book *book = [Book nb_findFirstInContext:contextType];
      book.name = @"updated name";
    }];

## TODOs

It just needs some love from you guys as it has never been tested on a real app. After that, here's my list:

- more tests & documentation
- iCloud sync issues handler
- compile time switch to use everything without the `nb_` prefix
- data importers

## Contact

Marco Sero

- http://www.marcosero.com
- http://twitter.com/marcosero 
- marco@marcosero.com

## License

Nimble is available under the MIT license. See the file LICENSE.