//
//  ProfileViewController.m
//  Instagram
//
//  Created by Alex Santorineos on 6/8/15.
//  Copyright (c) 2015 madApperz. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property NSArray *pics;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    PFUser *currentUser = [PFUser currentUser]; //show current user in console
    if (currentUser) {
        NSLog(@"Current user: %@", currentUser.username);
    }
    else {
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    }

    self.pics = @[[UIImage imageNamed:@"robert"],[UIImage imageNamed:@"orlando"], [UIImage imageNamed:@"manWith"]];
    
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
    return self.pics.count;


}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    cell.backgroundView = [[UIImageView alloc]initWithImage:[self.pics objectAtIndex:indexPath.row]];

    return cell;
}
@end