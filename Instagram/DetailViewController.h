//
//  DetailViewController.h
//  Instagram
//
//  Created by Tom Carmona on 6/10/15.
//  Copyright (c) 2015 madApperz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface DetailViewController : UIViewController
@property (nonatomic, strong) PFObject *selectedPhotos;

@end
