//
//  Created by marco on 10/08/13.
//
//
//


#import "HBBooksDataSource.h"
#import "Book.h"
#import "NSManagedObject+Finders.h"

@interface HBBooksDataSource () <NSFetchedResultsControllerDelegate>
@property(weak, nonatomic) UITableView *tableView;
@property(strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property(strong, nonatomic) NSMutableArray *tableViewChanges;
@end

@implementation HBBooksDataSource

- (id)initWithTableView:(UITableView *)tableView
{
  self = [super init];
  if (self) {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(iCloudHasBeenEnabled:) name:NBStoreReplacedByCloudStore object:nil];
    _tableView = tableView;
    return self;
  }
  return nil;
}

- (void)iCloudHasBeenEnabled:(NSNotification *)notification
{
  NSLog(@"notification %@", notification);
  _fetchedResultsController = nil;
  [self.tableView reloadData];
}

- (NSFetchedResultsController *)fetchedResultsController
{
  if (_fetchedResultsController) {
    return _fetchedResultsController;
  }
  _fetchedResultsController = [Book nb_fetchAllGroupedBy:nil withPredicate:nil sortedBy:@"name" ascending:YES delegate:self];
  return _fetchedResultsController;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return self.fetchedResultsController.fetchedObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NBBookCell"];
  Book *book = [self.fetchedResultsController objectAtIndexPath:indexPath];
  cell.textLabel.text = book.name;
  return cell;
}

#pragma mark - NSFetchedResultControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
  self.tableViewChanges = [NSMutableArray array];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
  //TODO: fix fetched results controller as it is no safe
  __weak HBBooksDataSource *weakSelf = self;
  void (^update)() = ^{
    switch (type) {
      case NSFetchedResultsChangeInsert:
        [weakSelf.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        break;
      case NSFetchedResultsChangeDelete:
        [weakSelf.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        break;
      case NSFetchedResultsChangeMove:
        [weakSelf.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [weakSelf.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        break;
      case NSFetchedResultsChangeUpdate:
        [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        break;
      default:
        NSAssert(NO, @"Assert in %p", _cmd);
    }
  };
  [self.tableViewChanges addObject:[update copy]];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
  [self.tableView beginUpdates];
  [self.tableViewChanges enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    void (^updates)() = obj;
    updates();
  }];
  [self.tableView endUpdates];
}


@end