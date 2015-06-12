//
//  DetailViewController.m
//  Instagram
//
//  Created by Tom Carmona on 6/10/15.
//  Copyright (c) 2015 madApperz. All rights reserved.
//
#import "DeleteButton.h"
#import "DetailViewController.h"

@interface DetailViewController ()<DeleteButtonDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet DeleteButton *deleteButton;
@property PFFile *file;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.deleteButton.delegate = self;
    self.file= [self.selectedPhotos objectForKey:@"file"];
    NSData *data = [self.file getData];
    UIImage *image = [UIImage imageWithData:data];


    self.imageView.image = image;

    self.userNameLabel.text = [self.selectedPhotos objectForKey:@"userName"];    
}

-(void)viewWillAppear:(BOOL)animated{

    self.file = [self.selectedPhotos objectForKey:@"file"];
    NSData *data = [self.file getData];
    UIImage *image = [UIImage imageWithData:data];


    self.imageView.image = image;

    self.userNameLabel.text = [self.selectedPhotos objectForKey:@"userName"];




}


-(void)DeleteButtonDelegate:(UIButton *)button{

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"delete" message:nil preferredStyle:UIAlertControllerStyleAlert];

    //cancels alert controller
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    //
    //saves what you wrote
    UIAlertAction *deleteAction =  [UIAlertAction actionWithTitle:@"DELETE FOREVER!!!" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {



        [self.selectedPhotos deleteInBackground];



    }];

    //add cancelAction variable to alertController
    [alertController addAction:cancelAction];


    [alertController addAction:deleteAction];


    //activates alertcontroler
    [self presentViewController:alertController animated:true completion:nil];




}



@end
