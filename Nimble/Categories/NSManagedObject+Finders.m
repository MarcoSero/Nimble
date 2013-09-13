// NSManagedObject+Finders.m
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


#import "NSManagedObject+Finders.h"
#import "NSManagedObjectContext+NimbleContexts.h"


@implementation NSManagedObject (Finders)

/**
* Find all
*
*/

+ (NSArray *)nb_findAll
{
  return [self nb_findAllInContextType:NBMainContext];
}

+ (NSArray *)nb_findAllInContextType:(NBContextType)context
{
  return [self nb_findAllWithPredicate:nil inContextType:context];
}

+ (NSArray *)nb_findAllWithPredicate:(NSPredicate *)predicate
{
  return [self nb_findAllWithPredicate:predicate inContextType:NBMainContext];
}

+ (NSArray *)nb_findAllWithPredicate:(NSPredicate *)predicate inContextType:(NBContextType)context
{
  return [self nb_findAllSortedBy:nil ascending:YES withPredicate:predicate inContextType:context];
}

+ (NSArray *)nb_findAllSortedBy:(NSString *)sortTerm ascending:(BOOL)ascending
{
  return [self nb_findAllSortedBy:sortTerm ascending:ascending inContextType:NBMainContext];
}

+ (NSArray *)nb_findAllSortedBy:(NSString *)sortTerm ascending:(BOOL)ascending inContextType:(NBContextType)context
{
  return [self nb_findAllSortedBy:sortTerm ascending:ascending withPredicate:nil inContextType:context];
}

+ (NSArray *)nb_findAllSortedBy:(NSString *)sortTerm ascending:(BOOL)ascending withPredicate:(NSPredicate *)predicate
{
  return [self nb_findAllSortedBy:sortTerm ascending:ascending withPredicate:predicate inContextType:NBMainContext];
}

+ (NSArray *)nb_findAllSortedBy:(NSString *)sortTerm ascending:(BOOL)ascending withPredicate:(NSPredicate *)predicate inContextType:(NBContextType)context
{
  return [self pr_find:sortTerm ascending:ascending predicate:predicate context:context fetchLimit:0];
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
  return [self nb_findFirstInContextType:NBMainContext];
}

+ (instancetype)nb_findFirstInContextType:(NBContextType)context
{
  return [self nb_findFirstWithPredicate:nil inContextType:context];
}

+ (instancetype)nb_findFirstWithPredicate:(NSPredicate *)predicate
{
  return [self nb_findFirstWithPredicate:predicate inContextType:NBMainContext];
}

+ (instancetype)nb_findFirstWithPredicate:(NSPredicate *)predicate inContextType:(NBContextType)context
{
  return [self nb_findFirstWithPredicate:predicate sortedBy:nil ascending:NO inContextType:context];
}

+ (instancetype)nb_findFirstWithPredicate:(NSPredicate *)predicate sortedBy:(NSString *)sortTerm ascending:(BOOL)ascending
{
  return [self nb_findFirstWithPredicate:predicate sortedBy:sortTerm ascending:ascending inContextType:NBMainContext];
}

+ (instancetype)nb_findFirstWithPredicate:(NSPredicate *)predicate sortedBy:(NSString *)sortTerm ascending:(BOOL)ascending inContextType:(NBContextType)context
{
  NSArray *results = [self pr_find:sortTerm ascending:ascending predicate:predicate context:context fetchLimit:1];
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
  return [self nb_findAllByAttribute:attribute withValue:searchValue inContextType:NBMainContext];
}

+ (NSArray *)nb_findAllByAttribute:(NSString *)attribute withValue:(id)searchValue inContextType:(NBContextType)context
{
  return [self nb_findAllByAttribute:attribute withValue:searchValue andOrderBy:nil ascending:NO inContextType:NBMainContext];
}

+ (NSArray *)nb_findAllByAttribute:(NSString *)attribute withValue:(id)searchValue andOrderBy:(NSString *)sortTerm ascending:(BOOL)ascending
{
  return [self nb_findAllByAttribute:attribute withValue:searchValue andOrderBy:sortTerm ascending:ascending inContextType:NBMainContext];
}

+ (NSArray *)nb_findAllByAttribute:(NSString *)attribute withValue:(id)searchValue andOrderBy:(NSString *)sortTerm ascending:(BOOL)ascending inContextType:(NBContextType)context
{
  NSPredicate *predicate = [self pr_getPredicateForAttribute:attribute searchValue:searchValue];
  return [self nb_findAllSortedBy:sortTerm ascending:ascending withPredicate:predicate inContextType:context];
}

+ (instancetype)nb_findFirstByAttribute:(NSString *)attribute withValue:(id)searchValue
{
  return [self nb_findFirstByAttribute:attribute withValue:searchValue inContextType:NBMainContext];
}

+ (instancetype)nb_findFirstByAttribute:(NSString *)attribute withValue:(id)searchValue inContextType:(NBContextType)context
{
  NSPredicate *predicate = [self pr_getPredicateForAttribute:attribute searchValue:searchValue];
  return [self nb_findFirstWithPredicate:predicate inContextType:context];
}

+ (instancetype)nb_findFirstOrderedByAttribute:(NSString *)attribute ascending:(BOOL)ascending
{
  return [self nb_findFirstOrderedByAttribute:attribute ascending:ascending inContextType:NBMainContext];
}

+ (instancetype)nb_findFirstOrderedByAttribute:(NSString *)attribute ascending:(BOOL)ascending inContextType:(NBContextType)context
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
  return [self nb_fetchAllGroupedBy:nil withPredicate:nil sortedBy:nil ascending:NO delegate:delegate inContextType:NBMainContext];
}

+ (NSFetchedResultsController *)nb_fetchAllWithDelegate:(id <NSFetchedResultsControllerDelegate>)delegate inContextType:(NBContextType)context
{
  return [self nb_fetchAllGroupedBy:nil withPredicate:nil sortedBy:nil ascending:NO delegate:delegate inContextType:context];
}

+ (NSFetchedResultsController *)nb_fetchAllSortedBy:(NSString *)sortTerm ascending:(BOOL)ascending withPredicate:(NSPredicate *)predicate groupBy:(NSString *)groupingKeyPath delegate:(id <NSFetchedResultsControllerDelegate>)delegate
{
  return [self nb_fetchAllGroupedBy:nil withPredicate:predicate sortedBy:sortTerm ascending:ascending delegate:delegate inContextType:NBMainContext];
}

+ (NSFetchedResultsController *)nb_fetchAllSortedBy:(NSString *)sortTerm ascending:(BOOL)ascending withPredicate:(NSPredicate *)predicate groupBy:(NSString *)groupingKeyPath delegate:(id <NSFetchedResultsControllerDelegate>)delegate inContextType:(NBContextType)context
{
  return [self nb_fetchAllGroupedBy:nil withPredicate:predicate sortedBy:sortTerm ascending:ascending delegate:delegate inContextType:context];
}

+ (NSFetchedResultsController *)nb_fetchAllGroupedBy:(NSString *)group withPredicate:(NSPredicate *)predicate sortedBy:(NSString *)sortTerm ascending:(BOOL)ascending
{
  return [self nb_fetchAllGroupedBy:group withPredicate:predicate sortedBy:sortTerm ascending:ascending delegate:nil inContextType:NBMainContext];
}

+ (NSFetchedResultsController *)nb_fetchAllGroupedBy:(NSString *)group withPredicate:(NSPredicate *)predicate sortedBy:(NSString *)sortTerm ascending:(BOOL)ascending inContextType:(NBContextType)context
{
  return [self nb_fetchAllGroupedBy:group withPredicate:predicate sortedBy:sortTerm ascending:ascending delegate:nil inContextType:context];
}

+ (NSFetchedResultsController *)nb_fetchAllGroupedBy:(NSString *)group withPredicate:(NSPredicate *)predicate sortedBy:(NSString *)sortTerm ascending:(BOOL)ascending delegate:(id <NSFetchedResultsControllerDelegate>)delegate
{
  return [self nb_fetchAllGroupedBy:group withPredicate:predicate sortedBy:sortTerm ascending:ascending delegate:delegate inContextType:NBMainContext];
}

+ (NSFetchedResultsController *)nb_fetchAllGroupedBy:(NSString *)group withPredicate:(NSPredicate *)predicate sortedBy:(NSString *)sortTerm ascending:(BOOL)ascending delegate:(id <NSFetchedResultsControllerDelegate>)delegate inContextType:(NBContextType)contextType
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

+ (NSArray *)pr_find:(NSString *)sortTerm ascending:(BOOL)ascending predicate:(NSPredicate *)predicate context:(NBContextType)context fetchLimit:(NSUInteger)fetchLimit
{
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass(self)];
  fetchRequest.predicate = predicate;
  fetchRequest.sortDescriptors = (sortTerm) ? @[[NSSortDescriptor sortDescriptorWithKey:sortTerm ascending:ascending]] : nil;
  if (fetchLimit > 0) {fetchRequest.fetchLimit = fetchLimit;}
  NSArray *results = [NimbleStore nb_executeFetchRequest:fetchRequest inContextOfType:context error:nil ];
  return results;
}

+ (NSPredicate *)pr_getPredicateForAttribute:(NSString *)attribute searchValue:(id)searchValue
{
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%@ = %@", attribute, searchValue];
  return predicate;
}

@end