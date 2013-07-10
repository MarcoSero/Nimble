//
//  Created by marco on 10/07/13.
//
//
//


#import "NSManagedObject+Finders.h"
#import "NimbleStore.h"


@implementation NSManagedObject (Finders)

/**
* Find all
*
*/

+ (NSArray *)nb_findAll
{
  return [self nb_findAllInContext:NimbleMainContext];
}

+ (NSArray *)nb_findAllInContext:(NimbleContext)context
{
  return [self nb_findAllWithPredicate:nil inContext:context];
}

+ (NSArray *)nb_findAllWithPredicate:(NSPredicate *)predicate
{
  return [self nb_findAllWithPredicate:predicate inContext:NimbleMainContext];
}

+ (NSArray *)nb_findAllWithPredicate:(NSPredicate *)predicate inContext:(NimbleContext)context
{
  return [self nb_findAllSortedBy:nil ascending:YES withPredicate:predicate inContext:context];
}

+ (NSArray *)nb_findAllSortedBy:(NSString *)sortTerm ascending:(BOOL)ascending
{
  return [self nb_findAllSortedBy:sortTerm ascending:ascending inContext:NimbleMainContext];
}

+ (NSArray *)nb_findAllSortedBy:(NSString *)sortTerm ascending:(BOOL)ascending inContext:(NimbleContext)context
{
  return [self nb_findAllSortedBy:sortTerm ascending:ascending withPredicate:nil inContext:context];
}

+ (NSArray *)nb_findAllSortedBy:(NSString *)sortTerm ascending:(BOOL)ascending withPredicate:(NSPredicate *)predicate
{
  return [self nb_findAllSortedBy:sortTerm ascending:ascending withPredicate:predicate inContext:NimbleMainContext];
}

+ (NSArray *)nb_findAllSortedBy:(NSString *)sortTerm ascending:(BOOL)ascending withPredicate:(NSPredicate *)predicate inContext:(NimbleContext)context
{
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass(self)];
  fetchRequest.predicate = predicate;
  fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:sortTerm ascending:ascending]];
  NSArray *results = [NimbleStore executeFetchRequest:fetchRequest inContext:context];
  return results;
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
* Find first
*
*/

+ (instancetype)nb_findFirst
{
  return nil;

}

+ (instancetype)nb_findFirstInContext:(NimbleContext)context
{
  return nil;

}

+ (instancetype)nb_findFirstWithPredicate:(NSPredicate *)predicate
{
  return nil;

}

+ (instancetype)nb_findFirstWithPredicate:(NSPredicate *)predicate inContext:(NimbleContext)context
{
  return nil;

}

+ (instancetype)nb_findFirstWithPredicate:(NSPredicate *)predicate sortedBy:(NSString *)property ascending:(BOOL)ascending
{
  return nil;

}

+ (instancetype)nb_findFirstWithPredicate:(NSPredicate *)predicate sortedBy:(NSString *)property ascending:(BOOL)ascending inContext:(NimbleContext)context
{
  return nil;

}

+ (instancetype)nb_findFirstWithPredicate:(NSPredicate *)predicate andRetrieveAttributes:(NSArray *)attributes
{
  return nil;

}

+ (instancetype)nb_findFirstWithPredicate:(NSPredicate *)predicate andRetrieveAttributes:(NSArray *)attributes inContext:(NimbleContext)context
{
  return nil;

}

+ (instancetype)nb_findFirstWithPredicate:(NSPredicate *)predicate sortedBy:(NSString *)sortBy ascending:(BOOL)ascending andRetrieveAttributes:(id)attributes, ...
{
  return nil;

}

+ (instancetype)nb_findFirstWithPredicate:(NSPredicate *)predicate sortedBy:(NSString *)sortBy ascending:(BOOL)ascending inContext:(NimbleContext)context andRetrieveAttributes:(id)attributes, ...
{
  return nil;

}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
* Find by attribute
*
*/

+ (NSArray *)nb_findAllByAttribute:(NSString *)attribute withValue:(id)searchValue
{
  return nil;

}

+ (NSArray *)nb_findAllByAttribute:(NSString *)attribute withValue:(id)searchValue inContext:(NimbleContext)context
{
  return nil;

}

+ (NSArray *)nb_findAllByAttribute:(NSString *)attribute withValue:(id)searchValue andOrderBy:(NSString *)sortTerm ascending:(BOOL)ascending
{
  return nil;

}

+ (NSArray *)nb_findAllByAttribute:(NSString *)attribute withValue:(id)searchValue andOrderBy:(NSString *)sortTerm ascending:(BOOL)ascending inContext:(NimbleContext)context
{
  return nil;

}

+ (instancetype)nb_findFirstByAttribute:(NSString *)attribute withValue:(id)searchValue
{
  return nil;

}

+ (instancetype)nb_findFirstByAttribute:(NSString *)attribute withValue:(id)searchValue inContext:(NimbleContext)context
{
  return nil;

}

+ (instancetype)nb_findFirstOrderedByAttribute:(NSString *)attribute ascending:(BOOL)ascending
{
  return nil;

}

+ (instancetype)nb_findFirstOrderedByAttribute:(NSString *)attribute ascending:(BOOL)ascending inContext:(NimbleContext)context
{
  return nil;

}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
* Easy fetches
*
*/

+ (NSFetchedResultsController *)fetchAllWithDelegate:(id <NSFetchedResultsControllerDelegate>)delegate
{
  return nil;

}

+ (NSFetchedResultsController *)fetchAllWithDelegate:(id <NSFetchedResultsControllerDelegate>)delegate inContext:(NimbleContext)context
{
  return nil;

}

+ (NSFetchedResultsController *)fetchAllSortedBy:(NSString *)sortTerm ascending:(BOOL)ascending withPredicate:(NSPredicate *)predicate groupBy:(NSString *)groupingKeyPath delegate:(id <NSFetchedResultsControllerDelegate>)delegate
{
  return nil;

}

+ (NSFetchedResultsController *)fetchAllSortedBy:(NSString *)sortTerm ascending:(BOOL)ascending withPredicate:(NSPredicate *)predicate groupBy:(NSString *)groupingKeyPath delegate:(id <NSFetchedResultsControllerDelegate>)delegate inContext:(NimbleContext)context
{
  return nil;

}

+ (NSFetchedResultsController *)fetchAllGroupedBy:(NSString *)group withPredicate:(NSPredicate *)predicate sortedBy:(NSString *)sortTerm ascending:(BOOL)ascending
{
  return nil;

}

+ (NSFetchedResultsController *)fetchAllGroupedBy:(NSString *)group withPredicate:(NSPredicate *)predicate sortedBy:(NSString *)sortTerm ascending:(BOOL)ascending inContext:(NimbleContext)context
{
  return nil;

}

+ (NSFetchedResultsController *)fetchAllGroupedBy:(NSString *)group withPredicate:(NSPredicate *)predicate sortedBy:(NSString *)sortTerm ascending:(BOOL)ascending delegate:(id <NSFetchedResultsControllerDelegate>)delegate
{
  return nil;

}

+ (NSFetchedResultsController *)fetchAllGroupedBy:(NSString *)group withPredicate:(NSPredicate *)predicate sortedBy:(NSString *)sortTerm ascending:(BOOL)ascending delegate:(id <NSFetchedResultsControllerDelegate>)delegate inContext:(NimbleContext)context
{
  return nil;

}

@end