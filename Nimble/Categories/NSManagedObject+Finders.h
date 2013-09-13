// NSManagedObject+Finders.h
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


#import <Foundation/Foundation.h>
#import "NimbleStore.h"

@interface NSManagedObject (Finders)

/**
* Find all
*
*/

+ (NSArray *)nb_findAll;

+ (NSArray *)nb_findAllInContextType:(NBContextType)context;

+ (NSArray *)nb_findAllWithPredicate:(NSPredicate *)predicate;

+ (NSArray *)nb_findAllWithPredicate:(NSPredicate *)predicate inContextType:(NBContextType)context;

+ (NSArray *)nb_findAllSortedBy:(NSString *)sortTerm ascending:(BOOL)ascending;

+ (NSArray *)nb_findAllSortedBy:(NSString *)sortTerm ascending:(BOOL)ascending inContextType:(NBContextType)context;

+ (NSArray *)nb_findAllSortedBy:(NSString *)sortTerm ascending:(BOOL)ascending withPredicate:(NSPredicate *)predicate;

+ (NSArray *)nb_findAllSortedBy:(NSString *)sortTerm ascending:(BOOL)ascending withPredicate:(NSPredicate *)predicate inContextType:(NBContextType)context;

/**
* Find first
*
*/

+ (instancetype)nb_findFirst;

+ (instancetype)nb_findFirstInContextType:(NBContextType)context;

+ (instancetype)nb_findFirstWithPredicate:(NSPredicate *)predicate;

+ (instancetype)nb_findFirstWithPredicate:(NSPredicate *)predicate inContextType:(NBContextType)context;

+ (instancetype)nb_findFirstWithPredicate:(NSPredicate *)predicate sortedBy:(NSString *)sortTerm ascending:(BOOL)ascending;

+ (instancetype)nb_findFirstWithPredicate:(NSPredicate *)predicate sortedBy:(NSString *)sortTerm ascending:(BOOL)ascending inContextType:(NBContextType)context;

/**
* Find by attribute
*
*/

+ (NSArray *)nb_findAllByAttribute:(NSString *)attribute withValue:(id)searchValue;

+ (NSArray *)nb_findAllByAttribute:(NSString *)attribute withValue:(id)searchValue inContextType:(NBContextType)context;

+ (NSArray *)nb_findAllByAttribute:(NSString *)attribute withValue:(id)searchValue andOrderBy:(NSString *)sortTerm ascending:(BOOL)ascending;

+ (NSArray *)nb_findAllByAttribute:(NSString *)attribute withValue:(id)searchValue andOrderBy:(NSString *)sortTerm ascending:(BOOL)ascending inContextType:(NBContextType)context;

+ (instancetype)nb_findFirstByAttribute:(NSString *)attribute withValue:(id)searchValue;

+ (instancetype)nb_findFirstByAttribute:(NSString *)attribute withValue:(id)searchValue inContextType:(NBContextType)context;

+ (instancetype)nb_findFirstOrderedByAttribute:(NSString *)attribute ascending:(BOOL)ascending;

+ (instancetype)nb_findFirstOrderedByAttribute:(NSString *)attribute ascending:(BOOL)ascending inContextType:(NBContextType)context;

/**
* Easy fetches
*
*/

+ (NSFetchedResultsController *)nb_fetchAllWithDelegate:(id <NSFetchedResultsControllerDelegate>)delegate;

+ (NSFetchedResultsController *)nb_fetchAllWithDelegate:(id <NSFetchedResultsControllerDelegate>)delegate inContextType:(NBContextType)context;

+ (NSFetchedResultsController *)nb_fetchAllSortedBy:(NSString *)sortTerm ascending:(BOOL)ascending withPredicate:(NSPredicate *)predicate groupBy:(NSString *)groupingKeyPath delegate:(id <NSFetchedResultsControllerDelegate>)delegate;

+ (NSFetchedResultsController *)nb_fetchAllSortedBy:(NSString *)sortTerm ascending:(BOOL)ascending withPredicate:(NSPredicate *)predicate groupBy:(NSString *)groupingKeyPath delegate:(id <NSFetchedResultsControllerDelegate>)delegate inContextType:(NBContextType)context;

+ (NSFetchedResultsController *)nb_fetchAllGroupedBy:(NSString *)group withPredicate:(NSPredicate *)predicate sortedBy:(NSString *)sortTerm ascending:(BOOL)ascending;

+ (NSFetchedResultsController *)nb_fetchAllGroupedBy:(NSString *)group withPredicate:(NSPredicate *)predicate sortedBy:(NSString *)sortTerm ascending:(BOOL)ascending inContextType:(NBContextType)context;

+ (NSFetchedResultsController *)nb_fetchAllGroupedBy:(NSString *)group withPredicate:(NSPredicate *)predicate sortedBy:(NSString *)sortTerm ascending:(BOOL)ascending delegate:(id <NSFetchedResultsControllerDelegate>)delegate;

+ (NSFetchedResultsController *)nb_fetchAllGroupedBy:(NSString *)group withPredicate:(NSPredicate *)predicate sortedBy:(NSString *)sortTerm ascending:(BOOL)ascending delegate:(id <NSFetchedResultsControllerDelegate>)delegate inContextType:(NBContextType)contextType;

@end