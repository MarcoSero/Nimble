//
//  Created by marco on 10/07/13.
//
//
//


#import "NSManagedObject+Finders.h"
#import "NSManagedObjectContext+NimbleContexts.h"


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
  return [self nb_find:sortTerm ascending:ascending predicate:predicate context:context fetchLimit:0];
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
  return [self nb_findFirstInContextType:NimbleMainContext];
}

+ (instancetype)nb_findFirstInContextType:(NimbleContextType)context
{
  return [self nb_findFirstWithPredicate:nil inContextType:context];
}

+ (instancetype)nb_findFirstWithPredicate:(NSPredicate *)predicate
{
  return [self nb_findFirstWithPredicate:predicate inContextType:NimbleMainContext];
}

+ (instancetype)nb_findFirstWithPredicate:(NSPredicate *)predicate inContextType:(NimbleContextType)context
{
  return [self nb_findFirstWithPredicate:predicate sortedBy:nil ascending:NO inContextType:context];
}

+ (instancetype)nb_findFirstWithPredicate:(NSPredicate *)predicate sortedBy:(NSString *)sortTerm ascending:(BOOL)ascending
{
  return [self nb_findFirstWithPredicate:predicate sortedBy:sortTerm ascending:ascending inContextType:NimbleMainContext];
}

+ (instancetype)nb_findFirstWithPredicate:(NSPredicate *)predicate sortedBy:(NSString *)sortTerm ascending:(BOOL)ascending inContextType:(NimbleContextType)context
{
  NSArray *results = [self nb_find:sortTerm ascending:ascending predicate:predicate context:context fetchLimit:1];
  if (results.count == 0) {
    return nil;
  }
  return results[0];
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
  return [self nb_findAllByAttribute:attribute withValue:searchValue inContextType:NimbleMainContext];
}

+ (NSArray *)nb_findAllByAttribute:(NSString *)attribute withValue:(id)searchValue inContextType:(NimbleContextType)context
{
  return [self nb_findAllByAttribute:attribute withValue:searchValue andOrderBy:nil ascending:NO inContextType:NimbleMainContext];
}

+ (NSArray *)nb_findAllByAttribute:(NSString *)attribute withValue:(id)searchValue andOrderBy:(NSString *)sortTerm ascending:(BOOL)ascending
{
  return [self nb_findAllByAttribute:attribute withValue:searchValue andOrderBy:sortTerm ascending:ascending inContextType:NimbleMainContext];
}

+ (NSArray *)nb_findAllByAttribute:(NSString *)attribute withValue:(id)searchValue andOrderBy:(NSString *)sortTerm ascending:(BOOL)ascending inContextType:(NimbleContextType)context
{
  NSPredicate *predicate = [self getPredicateForAttribute:attribute searchValue:searchValue];
  return [self nb_findAllSortedBy:sortTerm ascending:ascending withPredicate:predicate inContextType:context];
}

+ (instancetype)nb_findFirstByAttribute:(NSString *)attribute withValue:(id)searchValue
{
  return [self nb_findFirstByAttribute:attribute withValue:searchValue inContextType:NimbleMainContext];
}

+ (instancetype)nb_findFirstByAttribute:(NSString *)attribute withValue:(id)searchValue inContextType:(NimbleContextType)context
{
  NSPredicate *predicate = [self getPredicateForAttribute:attribute searchValue:searchValue];
  return [self nb_findFirstWithPredicate:predicate inContextType:context];
}

+ (instancetype)nb_findFirstOrderedByAttribute:(NSString *)attribute ascending:(BOOL)ascending
{
  return [self nb_findFirstOrderedByAttribute:attribute ascending:ascending inContextType:NimbleMainContext];
}

+ (instancetype)nb_findFirstOrderedByAttribute:(NSString *)attribute ascending:(BOOL)ascending inContextType:(NimbleContextType)context
{
  return [self nb_findFirstWithPredicate:nil sortedBy:attribute ascending:ascending inContextType:context];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
* Easy fetches
*
*/

+ (NSFetchedResultsController *)nb_fetchAllWithDelegate:(id <NSFetchedResultsControllerDelegate>)delegate
{
  return [self nb_fetchAllGroupedBy:nil withPredicate:nil sortedBy:nil ascending:NO delegate:delegate inContextType:NimbleMainContext];
}

+ (NSFetchedResultsController *)nb_fetchAllWithDelegate:(id <NSFetchedResultsControllerDelegate>)delegate inContextType:(NimbleContextType)context
{
  return [self nb_fetchAllGroupedBy:nil withPredicate:nil sortedBy:nil ascending:NO delegate:delegate inContextType:context];
}

+ (NSFetchedResultsController *)nb_fetchAllSortedBy:(NSString *)sortTerm ascending:(BOOL)ascending withPredicate:(NSPredicate *)predicate groupBy:(NSString *)groupingKeyPath delegate:(id <NSFetchedResultsControllerDelegate>)delegate
{
  return [self nb_fetchAllGroupedBy:nil withPredicate:predicate sortedBy:sortTerm ascending:ascending delegate:delegate inContextType:NimbleMainContext];
}

+ (NSFetchedResultsController *)nb_fetchAllSortedBy:(NSString *)sortTerm ascending:(BOOL)ascending withPredicate:(NSPredicate *)predicate groupBy:(NSString *)groupingKeyPath delegate:(id <NSFetchedResultsControllerDelegate>)delegate inContextType:(NimbleContextType)context
{
  return [self nb_fetchAllGroupedBy:nil withPredicate:predicate sortedBy:sortTerm ascending:ascending delegate:delegate inContextType:context];
}

+ (NSFetchedResultsController *)nb_fetchAllGroupedBy:(NSString *)group withPredicate:(NSPredicate *)predicate sortedBy:(NSString *)sortTerm ascending:(BOOL)ascending
{
  return [self nb_fetchAllGroupedBy:group withPredicate:predicate sortedBy:sortTerm ascending:ascending delegate:nil inContextType:NimbleMainContext];
}

+ (NSFetchedResultsController *)nb_fetchAllGroupedBy:(NSString *)group withPredicate:(NSPredicate *)predicate sortedBy:(NSString *)sortTerm ascending:(BOOL)ascending inContextType:(NimbleContextType)context
{
  return [self nb_fetchAllGroupedBy:group withPredicate:predicate sortedBy:sortTerm ascending:ascending delegate:nil inContextType:context];
}

+ (NSFetchedResultsController *)nb_fetchAllGroupedBy:(NSString *)group withPredicate:(NSPredicate *)predicate sortedBy:(NSString *)sortTerm ascending:(BOOL)ascending delegate:(id <NSFetchedResultsControllerDelegate>)delegate
{
  return [self nb_fetchAllGroupedBy:group withPredicate:predicate sortedBy:sortTerm ascending:ascending delegate:delegate inContextType:NimbleMainContext];
}

+ (NSFetchedResultsController *)nb_fetchAllGroupedBy:(NSString *)group withPredicate:(NSPredicate *)predicate sortedBy:(NSString *)sortTerm ascending:(BOOL)ascending delegate:(id <NSFetchedResultsControllerDelegate>)delegate inContextType:(NimbleContextType)contextType
{
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass(self.class)];
  fetchRequest.predicate = (predicate) ? predicate : nil;
  fetchRequest.sortDescriptors = (sortTerm) ? @[[NSSortDescriptor sortDescriptorWithKey:sortTerm ascending:ascending]] : nil;

  NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[NSManagedObjectContext nb_contextForType:contextType] sectionNameKeyPath:group cacheName:nil];
  fetchedResultsController.delegate = delegate;
  
  NSError *error;
  [fetchedResultsController performFetch:&error];
  
  if (error) {
    return nil;
  }
  
  return fetchedResultsController;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
* Private
*
*/

+ (NSArray *)nb_find:(NSString *)sortTerm ascending:(BOOL)ascending predicate:(NSPredicate *)predicate context:(NimbleContextType)context fetchLimit:(NSUInteger)fetchLimit
{
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass(self)];
  fetchRequest.predicate = predicate;
  fetchRequest.sortDescriptors = (sortTerm) ? @[[NSSortDescriptor sortDescriptorWithKey:sortTerm ascending:ascending]] : nil;
  if (fetchLimit > 0) {fetchRequest.fetchLimit = fetchLimit;}
  NSArray *results = [NimbleStore nb_executeFetchRequest:fetchRequest inContextOfType:context];
  return results;
}

+ (NSPredicate *)getPredicateForAttribute:(NSString *)attribute searchValue:(id)searchValue
{
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%@ = %@", attribute, searchValue];
  return predicate;
}

@end