//
//  ProfileViewController.m
//  Instagram
//
//  Created by Alex Santorineos on 6/8/15.
//  Copyright (c) 2015 madApperz. All rights reserved.
//
#import "File.h"
#import "ProfileViewController.h"
#import "CollectionViewCell.h"
#import "DetailViewController.h"
@interface ProfileViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property NSArray *pics;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@property NSArray *pictures;
@property PFQuery *query;
@property NSMutableArray *tempArray;
@property PFObject *selectedPost;

@end

@implementation ProfileViewController


-(id)initWithCoder:(NSCoder *)aDecoder{

    self = [super initWithCoder:aDecoder];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotification:) name:@"Test1" object:nil];
    }
    return self;
}


-(void)receiveNotification:(NSNotification *)notification {
    if ([notification.name isEqualToString:@"Test1"]) {

        [self queryFromParse];

    }

}

-(void)queryFromParse{
PFUser *currentUser = [PFUser currentUser]; 
//    PFRelation *pictureRelation = [self.currentUser relationForKey:@"pictureRelation"];

    self.query = [PFQuery queryWithClassName:@"PictureUpload"];


    [self.query orderByDescending:@"createdAt"];

        [self.query whereKey:@"createdBy" equalTo:[PFObject objectWithoutDataWithClassName:@"_User" objectId:currentUser.objectId]];


    [self.query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        else {
            // We found messages!
            self.pictures = objects;
            [self.collectionView reloadData];
            NSLog(@"%@", objects);

            NSLog(@"Retrieved %lu messages", (unsigned long)[self.pictures count]);
        }
    }];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pictures = [[NSArray alloc]init];
   self.tempArray = [NSMutableArray new];

    self.currentUser = [PFUser currentUser]; //show current user in console
    if (self.currentUser) {
        NSLog(@"Current user: %@", self.currentUser.username);
    }
    else {
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    }


    self.currentUser = [PFUser currentUser];

    self.usernameLabel.text = self.currentUser.username;
}


-(void)viewWillAppear:(BOOL)animated{

    [self queryFromParse];

    self.currentUser = [PFUser currentUser];

    self.usernameLabel.text = self.currentUser.username;


}


- (IBAction)onLogoutButtonPressed:(UIBarButtonItem *)sender {

    [PFUser logOut];
    PFUser *currentUser = [PFUser currentUser];

 [self performSegueWithIdentifier:@"showLogin" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([segue.identifier isEqualToString:@"showLogin"]) {

        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];

    }else if ([segue.identifier isEqualToString:@"ProfileDetailSegue"]){
//      [self.cities objectAtIndex:self.tableView.indexPathForSelectedRow.row];

        DetailViewController *dvc = segue.destinationViewController;
        NSIndexPath *indexPath = self.collectionView.indexPathsForSelectedItems[0];
        dvc.selectedPhotos = [self.pictures objectAtIndex:indexPath.row];

    }

}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.pictures.count;


}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    self.selectedPost = [self.pictures objectAtIndex:indexPath.row];


    cell.textView.text = [self.selectedPost objectForKey:@"userName"];

    PFFile *file = [self.selectedPost objectForKey:@"file"];
    NSData *data = [file getData];
    UIImage *image = [UIImage imageWithData:data];
    cell.imageView.image = image;

    return cell;
}


@end
