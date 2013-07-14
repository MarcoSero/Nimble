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
+ (NSArray *)nb_findAllInContextType:(NimbleContextType)context;
+ (NSArray *)nb_findAllWithPredicate:(NSPredicate *)predicate;
+ (NSArray *)nb_findAllWithPredicate:(NSPredicate *)predicate inContextType:(NimbleContextType)context;
+ (NSArray *)nb_findAllSortedBy:(NSString *)sortTerm ascending:(BOOL)ascending;
+ (NSArray *)nb_findAllSortedBy:(NSString *)sortTerm ascending:(BOOL)ascending inContextType:(NimbleContextType)context;
+ (NSArray *)nb_findAllSortedBy:(NSString *)sortTerm ascending:(BOOL)ascending withPredicate:(NSPredicate *)predicate;
+ (NSArray *)nb_findAllSortedBy:(NSString *)sortTerm ascending:(BOOL)ascending withPredicate:(NSPredicate *)predicate inContextType:(NimbleContextType)context;

/**
* Find first
*
*/

+ (instancetype)nb_findFirst;
+ (instancetype)nb_findFirstInContextType:(NimbleContextType)context;
+ (instancetype)nb_findFirstWithPredicate:(NSPredicate *)predicate;
+ (instancetype)nb_findFirstWithPredicate:(NSPredicate *)predicate inContextType:(NimbleContextType)context;
+ (instancetype)nb_findFirstWithPredicate:(NSPredicate *)predicate sortedBy:(NSString *)sortTerm ascending:(BOOL)ascending;
+ (instancetype)nb_findFirstWithPredicate:(NSPredicate *)predicate sortedBy:(NSString *)sortTerm ascending:(BOOL)ascending inContextType:(NimbleContextType)context;

/**
* Find by attribute
*
*/

+ (NSArray *)nb_findAllByAttribute:(NSString *)attribute withValue:(id)searchValue;
+ (NSArray *)nb_findAllByAttribute:(NSString *)attribute withValue:(id)searchValue inContextType:(NimbleContextType)context;
+ (NSArray *)nb_findAllByAttribute:(NSString *)attribute withValue:(id)searchValue andOrderBy:(NSString *)sortTerm ascending:(BOOL)ascending;
+ (NSArray *)nb_findAllByAttribute:(NSString *)attribute withValue:(id)searchValue andOrderBy:(NSString *)sortTerm ascending:(BOOL)ascending inContextType:(NimbleContextType)context;

+ (instancetype)nb_findFirstByAttribute:(NSString *)attribute withValue:(id)searchValue;
+ (instancetype)nb_findFirstByAttribute:(NSString *)attribute withValue:(id)searchValue inContextType:(NimbleContextType)context;
+ (instancetype)nb_findFirstOrderedByAttribute:(NSString *)attribute ascending:(BOOL)ascending;
+ (instancetype)nb_findFirstOrderedByAttribute:(NSString *)attribute ascending:(BOOL)ascending inContextType:(NimbleContextType)context;

/**
* Easy fetches
*
*/

+ (NSFetchedResultsController *)fetchAllWithDelegate:(id <NSFetchedResultsControllerDelegate>)delegate;
+ (NSFetchedResultsController *)fetchAllWithDelegate:(id <NSFetchedResultsControllerDelegate>)delegate inContextType:(NimbleContextType)context;
+ (NSFetchedResultsController *)fetchAllSortedBy:(NSString *)sortTerm ascending:(BOOL)ascending withPredicate:(NSPredicate *)predicate groupBy:(NSString *)groupingKeyPath delegate:(id <NSFetchedResultsControllerDelegate>)delegate;
+ (NSFetchedResultsController *)fetchAllSortedBy:(NSString *)sortTerm ascending:(BOOL)ascending withPredicate:(NSPredicate *)predicate groupBy:(NSString *)groupingKeyPath delegate:(id <NSFetchedResultsControllerDelegate>)delegate inContextType:(NimbleContextType)context;
+ (NSFetchedResultsController *)fetchAllGroupedBy:(NSString *)group withPredicate:(NSPredicate *)predicate sortedBy:(NSString *)sortTerm ascending:(BOOL)ascending;
+ (NSFetchedResultsController *)fetchAllGroupedBy:(NSString *)group withPredicate:(NSPredicate *)predicate sortedBy:(NSString *)sortTerm ascending:(BOOL)ascending inContextType:(NimbleContextType)context;
+ (NSFetchedResultsController *)fetchAllGroupedBy:(NSString *)group withPredicate:(NSPredicate *)predicate sortedBy:(NSString *)sortTerm ascending:(BOOL)ascending delegate:(id <NSFetchedResultsControllerDelegate>)delegate;
+ (NSFetchedResultsController *)fetchAllGroupedBy:(NSString *)group withPredicate:(NSPredicate *)predicate sortedBy:(NSString *)sortTerm ascending:(BOOL)ascending delegate:(id <NSFetchedResultsControllerDelegate>)delegate inContextType:(NimbleContextType)contextType;

@end