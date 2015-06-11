//
//  DetailViewController.m
//  Instagram
//
//  Created by Tom Carmona on 6/10/15.
//  Copyright (c) 2015 madApperz. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    PFFile *file = [self.selectedPhotos objectForKey:@"file"];
    NSData *data = [file getData];
    UIImage *image = [UIImage imageWithData:data];


    self.imageView.image = image;
}

-(void)viewWillAppear:(BOOL)animated{

    PFFile *file = [self.selectedPhotos objectForKey:@"file"];
    NSData *data = [file getData];
    UIImage *image = [UIImage imageWithData:data];


    self.imageView.image = image;


}



@end
