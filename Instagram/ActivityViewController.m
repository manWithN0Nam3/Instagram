//
//  ActivityViewController.m
//  Instagram
//
//  Created by Tom Carmona on 6/11/15.
//  Copyright (c) 2015 madApperz. All rights reserved.
//

#import "ActivityViewController.h"

@interface ActivityViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) NSArray *activities;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.activities = [[NSArray alloc]init];
    [self queryFromParse];


}

-(void)viewDidAppear:(BOOL)animated {
    [self queryFromParse];
}

-(void)queryFromParse{

    //    PFRelation *pictureRelation = [self.currentUser relationForKey:@"pictureRelation"];
    PFQuery* query = [PFQuery queryWithClassName:@"PictureUpload"];


    [query orderByDescending:@"createdAt"];

    //        [query whereKey:@"userId" equalTo:[[PFUser currentUser] objectId]];

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        else {
            // We found messages!
            self.activities = objects;
            //            [self.collectionView reloadData];
            NSLog(@"%@", objects);

            NSLog(@"Retrieved %lu messages", (unsigned long)[self.activities count]);
        }

        [self.tableView reloadData];
        
        
    }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.activities.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityCellID"];
    PFObject *activityObject = [self.activities objectAtIndex:indexPath.row];
//    PFFile *file = [activityObject objectForKey:@"file"];
//    PFFile *file = [activityObject objectForKey:@"userName"];
//    NSData *data = [file getData];
//    NSString *userString = [NSString stringWithFormat:@"%@", data];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ has posted a photo to Pimpstagram", [activityObject objectForKey:@"userName"]];
    return cell;
}

@end
