//
//  AddLoginViewController.m
//  Instagram
//
//  Created by Alex Santorineos on 6/8/15.
//  Copyright (c) 2015 madApperz. All rights reserved.
//

#import "AddLoginViewController.h"
#import <Parse/Parse.h>

@interface AddLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation AddLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navigationItem.hidesBackButton = true;
//    self.navigationItem.backBarButtonItem.tintColor = [UIColor clearColor];
;
    
}

- (IBAction)onLogginTapped:(UIButton *)sender {
    NSString *username = [self.userNameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    NSString *password = [self.passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];



    if ([username length]==0 || [password length]==0 ) {

        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Seriously?😡" message:@"enter Username and password" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil];

        [alertView show];
        
    }else{
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error) {

            if (user) {

                NSLog(@"%@",user.username);

                [self.navigationController popToRootViewControllerAnimated:true];


        // Do stuff after successful login.


        } else {

            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"sorry" message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil];
            [alertView show];

        // The login failed. Check error to see why.
                }
        }];

    }

}


@end
