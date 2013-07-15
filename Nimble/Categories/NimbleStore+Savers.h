//
//  Created by marco on 11/07/13.
//
//
//


#import <Foundation/Foundation.h>
#import "NimbleStore.h"

@interface NimbleStore (Savers)


/**
* Perform all the changes *asynchronously* in the right context based on the thread you are in
* (whether it is the main thread or a background one) and in case will use the
* background context the merge is done automatically.
*
*/
+ (void)nb_saveInProperContext:(NimbleSimpleBlock)changes;

/**
* Perform all the changes *synchronously* in the right context based on the thread you are in
* (whether it is the main thread or a background one) and in case will use the
* background context the merge is done automatically.
*
*/
+ (void)nb_saveInProperContextAndWait:(NimbleSimpleBlock)changes;

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