//
//  SignUpViewController.m
//  Instagram
//
//  Created by Alex Santorineos on 6/8/15.
//  Copyright (c) 2015 madApperz. All rights reserved.
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>

@interface SignUpViewController ()
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)onSignUPButtonTapped:(UIButton *)sender {
    NSString *username = [self.usernameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    NSString *password = [self.passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];


    NSString *email = [self.emailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];;


    if ([username length]==0 || [password length]==0 || [email length]==0) {

        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"oops" message:@"enter Username and password and email" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil];

        [alertView show];

    }else{

        //creates new user object
        PFUser *newUser = [PFUser user];

        newUser.username = username;
        newUser.password = password;
        newUser.email = email;


        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                [self.navigationController popToRootViewControllerAnimated:true];

                // Hooray! Let them use the app now.
            } else {
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"sorry" message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil];
                [alertView show];

                // Show the errorString somewhere and let the user try again.

            }
        }];
    }
}

@end
