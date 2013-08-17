//
//  NBBooksViewController.m
//  Nimble
//
//  Created by Marco Sero on 10/07/13.
//  Copyright (c) 2013 Marco Sero. All rights reserved.
//

#import "NBBooksViewController.h"
#import "HBBooksDataSource.h"
#import "NimbleStore.h"
#import "NimbleStore+Savers.h"
#import "Book.h"
#import "NSManagedObject+Creators.h"

@interface NBBooksViewController () <UITextFieldDelegate>
@property(weak, nonatomic) IBOutlet UITableView *tableView;
@property(weak, nonatomic) IBOutlet UITextField *addTextField;
@property(strong, nonatomic) HBBooksDataSource *dataSource;
@end

@implementation NBBooksViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.tableView.dataSource = self.dataSource = [[HBBooksDataSource alloc] initWithTableView:self.tableView];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  if (textField.text.length == 0) {
    [self dismissKeyboardAndResetTextFied:textField];
    return YES;
  }

  [NimbleStore nb_saveInBackground:^(NimbleContextType contextType) {
    [Book nb_createInContextOfType:contextType initializingValuesWithDictionary:@{@"name" : textField.text}];
  }                     completion:^(NSError *error) {
    [self dismissKeyboardAndResetTextFied:textField];
  }];

  return YES;
}

- (void)dismissKeyboardAndResetTextFied:(UITextField *)textField
{
  [textField resignFirstResponder];
  textField.text = @"";
}


@end
