//
//  Created by marco on 11/07/13.
//
//
//


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