//
//  Created by marco on 10/07/13.
//
//
//


#import "NSManagedObject+Finders.h"


@implementation NSManagedObject (Finders)

/**
* Find all
*
*/

+ (NSArray *)nb_findAll
{
  return [self nb_findAllInContextType:NimbleMainContext];
}

+ (NSArray *)nb_findAllInContextType:(NimbleContextType)context
{
  return [self nb_findAllWithPredicate:nil inContextType:context];
}

+ (NSArray *)nb_findAllWithPredicate:(NSPredicate *)predicate
{
  return [self nb_findAllWithPredicate:predicate inContextType:NimbleMainContext];
}

+ (NSArray *)nb_findAllWithPredicate:(NSPredicate *)predicate inContextType:(NimbleContextType)context
{
  return [self nb_findAllSortedBy:nil ascending:YES withPredicate:predicate inContextType:context];
}

+ (NSArray *)nb_findAllSortedBy:(NSString *)sortTerm ascending:(BOOL)ascending
{
  return [self nb_findAllSortedBy:sortTerm ascending:ascending inContextType:NimbleMainContext];
}

+ (NSArray *)nb_findAllSortedBy:(NSString *)sortTerm ascending:(BOOL)ascending inContextType:(NimbleContextType)context
{
  return [self nb_findAllSortedBy:sortTerm ascending:ascending withPredicate:nil inContextType:context];
}

+ (NSArray *)nb_findAllSortedBy:(NSString *)sortTerm ascending:(BOOL)ascending withPredicate:(NSPredicate *)predicate
{
  return [self nb_findAllSortedBy:sortTerm ascending:ascending withPredicate:predicate inContextType:NimbleMainContext];
}

+ (NSArray *)nb_findAllSortedBy:(NSString *)sortTerm ascending:(BOOL)ascending withPredicate:(NSPredicate *)predicate inContextType:(NimbleContextType)context
{
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass(self)];
  fetchRequest.predicate = predicate;
  if (sortTerm) {
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:sortTerm ascending:ascending]];
  }
  NSArray *results = [NimbleStore executeFetchRequest:fetchRequest inContextOfType:context];
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

+ (instancetype)nb_findFirstInContextType:(NimbleContextType)context
{
  return nil;

}

+ (instancetype)nb_findFirstWithPredicate:(NSPredicate *)predicate
{
  return nil;

}

+ (instancetype)nb_findFirstWithPredicate:(NSPredicate *)predicate inContextType:(NimbleContextType)context
{
  return nil;

}

+ (instancetype)nb_findFirstWithPredicate:(NSPredicate *)predicate sortedBy:(NSString *)property ascending:(BOOL)ascending
{
  return nil;

}

+ (instancetype)nb_findFirstWithPredicate:(NSPredicate *)predicate sortedBy:(NSString *)property ascending:(BOOL)ascending inContextType:(NimbleContextType)context
{
  return nil;

}

+ (instancetype)nb_findFirstWithPredicate:(NSPredicate *)predicate andRetrieveAttributes:(NSArray *)attributes
{
  return nil;

}

+ (instancetype)nb_findFirstWithPredicate:(NSPredicate *)predicate andRetrieveAttributes:(NSArray *)attributes inContextType:(NimbleContextType)context
{
  return nil;

}

+ (instancetype)nb_findFirstWithPredicate:(NSPredicate *)predicate sortedBy:(NSString *)sortBy ascending:(BOOL)ascending andRetrieveAttributes:(id)attributes, ...
{
  return nil;

}

+ (instancetype)nb_findFirstWithPredicate:(NSPredicate *)predicate sortedBy:(NSString *)sortBy ascending:(BOOL)ascending inContextType:(NimbleContextType)context andRetrieveAttributes:(id)attributes, ...
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

+ (NSArray *)nb_findAllByAttribute:(NSString *)attribute withValue:(id)searchValue inContextType:(NimbleContextType)context
{
  return nil;

}

+ (NSArray *)nb_findAllByAttribute:(NSString *)attribute withValue:(id)searchValue andOrderBy:(NSString *)sortTerm ascending:(BOOL)ascending
{
  return nil;

}

+ (NSArray *)nb_findAllByAttribute:(NSString *)attribute withValue:(id)searchValue andOrderBy:(NSString *)sortTerm ascending:(BOOL)ascending inContextType:(NimbleContextType)context
{
  return nil;

}

+ (instancetype)nb_findFirstByAttribute:(NSString *)attribute withValue:(id)searchValue
{
  return nil;

}

+ (instancetype)nb_findFirstByAttribute:(NSString *)attribute withValue:(id)searchValue inContextType:(NimbleContextType)context
{
  return nil;

}

+ (instancetype)nb_findFirstOrderedByAttribute:(NSString *)attribute ascending:(BOOL)ascending
{
  return nil;

}

+ (instancetype)nb_findFirstOrderedByAttribute:(NSString *)attribute ascending:(BOOL)ascending inContextType:(NimbleContextType)context
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

+ (NSFetchedResultsController *)fetchAllWithDelegate:(id <NSFetchedResultsControllerDelegate>)delegate inContextType:(NimbleContextType)context
{
  return nil;

}

+ (NSFetchedResultsController *)fetchAllSortedBy:(NSString *)sortTerm ascending:(BOOL)ascending withPredicate:(NSPredicate *)predicate groupBy:(NSString *)groupingKeyPath delegate:(id <NSFetchedResultsControllerDelegate>)delegate
{
  return nil;

}

+ (NSFetchedResultsController *)fetchAllSortedBy:(NSString *)sortTerm ascending:(BOOL)ascending withPredicate:(NSPredicate *)predicate groupBy:(NSString *)groupingKeyPath delegate:(id <NSFetchedResultsControllerDelegate>)delegate inContextType:(NimbleContextType)context
{
  return nil;

}

+ (NSFetchedResultsController *)fetchAllGroupedBy:(NSString *)group withPredicate:(NSPredicate *)predicate sortedBy:(NSString *)sortTerm ascending:(BOOL)ascending
{
  return nil;

}

+ (NSFetchedResultsController *)fetchAllGroupedBy:(NSString *)group withPredicate:(NSPredicate *)predicate sortedBy:(NSString *)sortTerm ascending:(BOOL)ascending inContextType:(NimbleContextType)context
{
  return nil;

}

+ (NSFetchedResultsController *)fetchAllGroupedBy:(NSString *)group withPredicate:(NSPredicate *)predicate sortedBy:(NSString *)sortTerm ascending:(BOOL)ascending delegate:(id <NSFetchedResultsControllerDelegate>)delegate
{
  return nil;

}

+ (NSFetchedResultsController *)fetchAllGroupedBy:(NSString *)group withPredicate:(NSPredicate *)predicate sortedBy:(NSString *)sortTerm ascending:(BOOL)ascending delegate:(id <NSFetchedResultsControllerDelegate>)delegate inContextType:(NimbleContextType)context
{
  return nil;

}

@end