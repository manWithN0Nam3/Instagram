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
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

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


    PFQuery *query = [PFQuery queryWithClassName:@"PictureUpload"];
    // [query whereKey:@"recipientIds" equalTo:[[PFUser currentUser] objectId]];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        else {
            // We found messages!
            self.pictures = objects;
            [self.collectionView reloadData];
            NSLog(@"Retrieved %lu messages", (unsigned long)[self.pictures count]);
        }
    }];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];

    PFUser *currentUser = [PFUser currentUser]; //show current user in console
    if (currentUser) {
        NSLog(@"Current user: %@", currentUser.username);
    }
    else {
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    }

//    self.pics = @[[UIImage imageNamed:@"robert"],[UIImage imageNamed:@"orlando"], [UIImage imageNamed:@"manWith"]];
//    self.usernameLabel.text = [pictureObject objectForKey:@"userName"];

}
-(void)viewDidAppear:(BOOL)animated{
//self.usernameLabel.text = [pictureObject objectForKey:@"userName"];
}
-(void)viewWillAppear:(BOOL)animated{
//
//self.usernameLabel.text = [pictureObject objectForKey:@"userName"];
}

- (IBAction)onLogoutButtonPressed:(UIBarButtonItem *)sender {

    [PFUser logOut];
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

//    File *file = [pictureObject objectForKey:@"file"];

//    [[pictureObject objectForKey:@"file"] data]

    PFFile *file = [pictureObject objectForKey:@"file"];
    NSData *data = [file getData];
//    cell.imageView.image = [UIImage imageWithData:file.data];
    UIImage *image = [UIImage imageWithData:data];
    cell.imageView.image = image;

    return cell;
}
@end
