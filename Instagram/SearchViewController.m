//
//  SearchViewController.m
//  Instagram
//
//  Created by Tom Carmona on 6/12/15.
//  Copyright (c) 2015 madApperz. All rights reserved.
//

#import "SearchViewController.h"
#import <Parse/Parse.h>

@interface SearchViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property BOOL isFiltered;
@property NSMutableArray *filteredUsers;
@property NSArray *users;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.delegate = self;
    self.searchBar.delegate = self;
    
    [self queryFromParse];
}

-(void)viewWillAppear:(BOOL)animated{

    [self queryFromParse];
}

-(void)queryFromParse {
    PFUser *currentUser = [PFUser currentUser];
    PFQuery* query = [PFUser query];
    self.users = [query findObjects];


//    [query orderByDescending:@"createdAt"];


    //        [query whereKey:@"userId" equalTo:[[PFUser currentUser] objectId]];

//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (error) {
//            NSLog(@"Error: %@ %@", error, [error userInfo]);
//        }
//        else {
//            // We found messages!
//            self.users = objects;
//            //            [self.collectionView reloadData];
//            NSLog(@"%@", objects);
//
//            NSLog(@"Retrieved %lu messages", (unsigned long)[self.users count]);
//        }

        [self.tableView reloadData];
        
        
//    }];

}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {

    if (searchText.length == 0) {
        self.isFiltered = NO;

    } else {
        self.isFiltered = YES;
        self.filteredUsers = [[NSMutableArray alloc]init];

        for (PFObject *object in self.users) {
            NSLog(@"%@ *****-----------", object);
            NSString *usersString = [object objectForKey:@"username"];
            NSRange usersRange = [usersString rangeOfString:searchText options:NSCaseInsensitiveSearch];

            if (usersRange.location != NSNotFound) {
                [self.filteredUsers addObject:object];
            }
        }
    }

    [self.tableView reloadData];

}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {


    [self.searchBar resignFirstResponder];



}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredUsers.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchCellID"];

    PFObject *object = [self.filteredUsers objectAtIndex:indexPath.row];
    cell.textLabel.text = [object objectForKey:@"username"];

    return cell;
}


@end
