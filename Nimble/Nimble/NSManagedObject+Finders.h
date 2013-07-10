//
//  Created by marco on 10/07/13.
//
//
//


#import <Foundation/Foundation.h>
#import "NimbleStore.h"

@interface NSManagedObject (Finders)

/**
* Find all
*
*/

+ (NSArray *)nb_findAll;
+ (NSArray *)nb_findAllInContext:(NimbleContext)context;
+ (NSArray *)nb_findAllWithPredicate:(NSPredicate *)predicate;
+ (NSArray *)nb_findAllWithPredicate:(NSPredicate *)predicate inContext:(NimbleContext)context;
+ (NSArray *)nb_findAllSortedBy:(NSString *)sortTerm ascending:(BOOL)ascending;
+ (NSArray *)nb_findAllSortedBy:(NSString *)sortTerm ascending:(BOOL)ascending inContext:(NimbleContext)context;
+ (NSArray *)nb_findAllSortedBy:(NSString *)sortTerm ascending:(BOOL)ascending withPredicate:(NSPredicate *)predicate;
+ (NSArray *)nb_findAllSortedBy:(NSString *)sortTerm ascending:(BOOL)ascending withPredicate:(NSPredicate *)predicate inContext:(NimbleContext)context;

/**
* Find first
*
*/

+ (instancetype)nb_findFirst;
+ (instancetype)nb_findFirstInContext:(NimbleContext)context;
+ (instancetype)nb_findFirstWithPredicate:(NSPredicate *)predicate;
+ (instancetype)nb_findFirstWithPredicate:(NSPredicate *)predicate inContext:(NimbleContext)context;
+ (instancetype)nb_findFirstWithPredicate:(NSPredicate *)predicate sortedBy:(NSString *)property ascending:(BOOL)ascending;
+ (instancetype)nb_findFirstWithPredicate:(NSPredicate *)predicate sortedBy:(NSString *)property ascending:(BOOL)ascending inContext:(NimbleContext)context;
+ (instancetype)nb_findFirstWithPredicate:(NSPredicate *)predicate andRetrieveAttributes:(NSArray *)attributes;
+ (instancetype)nb_findFirstWithPredicate:(NSPredicate *)predicate andRetrieveAttributes:(NSArray *)attributes inContext:(NimbleContext)context;
+ (instancetype)nb_findFirstWithPredicate:(NSPredicate *)predicate sortedBy:(NSString *)sortBy ascending:(BOOL)ascending andRetrieveAttributes:(id)attributes, ...;
+ (instancetype)nb_findFirstWithPredicate:(NSPredicate *)predicate sortedBy:(NSString *)sortBy ascending:(BOOL)ascending inContext:(NimbleContext)context andRetrieveAttributes:(id)attributes, ...;

/**
* Find by attribute
*
*/

+ (NSArray *)nb_findAllByAttribute:(NSString *)attribute withValue:(id)searchValue;
+ (NSArray *)nb_findAllByAttribute:(NSString *)attribute withValue:(id)searchValue inContext:(NimbleContext)context;
+ (NSArray *)nb_findAllByAttribute:(NSString *)attribute withValue:(id)searchValue andOrderBy:(NSString *)sortTerm ascending:(BOOL)ascending;
+ (NSArray *)nb_findAllByAttribute:(NSString *)attribute withValue:(id)searchValue andOrderBy:(NSString *)sortTerm ascending:(BOOL)ascending inContext:(NimbleContext)context;

+ (instancetype)nb_findFirstByAttribute:(NSString *)attribute withValue:(id)searchValue;
+ (instancetype)nb_findFirstByAttribute:(NSString *)attribute withValue:(id)searchValue inContext:(NimbleContext)context;
+ (instancetype)nb_findFirstOrderedByAttribute:(NSString *)attribute ascending:(BOOL)ascending;
+ (instancetype)nb_findFirstOrderedByAttribute:(NSString *)attribute ascending:(BOOL)ascending inContext:(NimbleContext)context;

/**
* Easy fetches
*
*/

+ (NSFetchedResultsController *)fetchAllWithDelegate:(id <NSFetchedResultsControllerDelegate>)delegate;
+ (NSFetchedResultsController *)fetchAllWithDelegate:(id <NSFetchedResultsControllerDelegate>)delegate inContext:(NimbleContext)context;
+ (NSFetchedResultsController *)fetchAllSortedBy:(NSString *)sortTerm ascending:(BOOL)ascending withPredicate:(NSPredicate *)predicate groupBy:(NSString *)groupingKeyPath delegate:(id <NSFetchedResultsControllerDelegate>)delegate;
+ (NSFetchedResultsController *)fetchAllSortedBy:(NSString *)sortTerm ascending:(BOOL)ascending withPredicate:(NSPredicate *)predicate groupBy:(NSString *)groupingKeyPath delegate:(id <NSFetchedResultsControllerDelegate>)delegate inContext:(NimbleContext)context;
+ (NSFetchedResultsController *)fetchAllGroupedBy:(NSString *)group withPredicate:(NSPredicate *)predicate sortedBy:(NSString *)sortTerm ascending:(BOOL)ascending;
+ (NSFetchedResultsController *)fetchAllGroupedBy:(NSString *)group withPredicate:(NSPredicate *)predicate sortedBy:(NSString *)sortTerm ascending:(BOOL)ascending inContext:(NimbleContext)context;
+ (NSFetchedResultsController *)fetchAllGroupedBy:(NSString *)group withPredicate:(NSPredicate *)predicate sortedBy:(NSString *)sortTerm ascending:(BOOL)ascending delegate:(id <NSFetchedResultsControllerDelegate>)delegate;
+ (NSFetchedResultsController *)fetchAllGroupedBy:(NSString *)group withPredicate:(NSPredicate *)predicate sortedBy:(NSString *)sortTerm ascending:(BOOL)ascending delegate:(id <NSFetchedResultsControllerDelegate>)delegate inContext:(NimbleContext)context;

@end