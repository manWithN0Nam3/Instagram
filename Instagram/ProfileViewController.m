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
@interface ProfileViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property NSArray *pics;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@property NSArray *pictures;
@property PFQuery *query;
@property NSMutableArray *tempArray;
@property PFObject *object;

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
//    [self.query whereKey:@"userName" equalTo:currentUser.username];
//    NSLog(@"%@",[self.query whereKeyExists:@"userName"]);

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

//    [self.query getObjectInBackgroundWithId:@"xWMyZ4YEGZ" block:^(PFObject *gameScore, NSError *error) {
//        // Do something with the returned PFObject in the gameScore variable.
//        NSLog(@"%@", gameScore);
//    }];


//
//    if (self.currentUser.objectId == [pictureObject objectForKey:@"userID"]) {
//
//    }


//    if (currentUser.objectId) {
//        NSLog(@"Current user: %@", currentUser.username);
//
////                [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
////            if (error) {
////                NSLog(@"Error: %@ %@", error, [error userInfo]);
////            }
////            else {
////                // We found messages!
////                self.pictures = objects;
////                [self.collectionView reloadData];
////                NSLog(@"Retrieved %lu messages", (unsigned long)self.pictures.count);
////            }
////        }];
////        
//
//    }
//    else {
//        [self performSegueWithIdentifier:@"showLogin" sender:self];
//    }


//    PFQuery *query = [PFQuery queryWithClassName:@"PictureUpload"];
//    // [query whereKey:@"recipientIds" equalTo:[[PFUser currentUser] objectId]];
//    [query orderByDescending:@"createdAt"];
//    [query whereKey:@"createdBy" equalTo:[PFObject objectWithoutDataWithClassName:@"_User" objectId:@"iu7I9QGjZ7"]];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (error) {
//            NSLog(@"Error: %@ %@", error, [error userInfo]);
//        }
//        else {
//            // We found messages!
//            self.pictures = objects;
//            [self.collectionView reloadData];
//            NSLog(@"Retrieved %lu messages", (unsigned long)[self.pictures count]);
//        }
//    }];
//    

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
//    self.pics = @[[UIImage imageNamed:@"robert"],[UIImage imageNamed:@"orlando"], [UIImage imageNamed:@"manWith"]];
//    self.usernameLabel.text = [pictureObject objectForKey:@"userName"];

}
//-(void)viewDidAppear:(BOOL)animated{
//    [self queryFromParse];
//}

-(void)viewDidAppear:(BOOL)animated{
//    self.object = [[PFObject alloc]init];

}
-(void)viewWillAppear:(BOOL)animated{
//        self.object = [[PFObject alloc]init];

    [self queryFromParse];
}

- (IBAction)onLogoutButtonPressed:(UIBarButtonItem *)sender {

    [PFUser logOut];
    PFUser *currentUser = [PFUser currentUser];

 [self performSegueWithIdentifier:@"showLogin" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([segue.identifier isEqualToString:@"showLogin"]) {

        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];

    }

}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.pictures.count;


}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    PFObject *pictureObject = [self.pictures objectAtIndex:indexPath.row];


//    cell.backgroundView = [[UIImageView alloc]initWithImage:[self.pics objectAtIndex:indexPath.row]];
//    cell. = [pictureObject objectForKey:@"userName"];

    cell.textView.text = [pictureObject objectForKey:@"userName"];

    PFFile *file = [pictureObject objectForKey:@"file"];
    NSData *data = [file getData];
    UIImage *image = [UIImage imageWithData:data];
    cell.imageView.image = image;

    return cell;
}
@end
