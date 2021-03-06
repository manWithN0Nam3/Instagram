//
//  CaptureViewController.m
//  Instagram
//
//  Created by Alex Santorineos on 6/8/15.
//  Copyright (c) 2015 madApperz. All rights reserved.
//

#import "CaptureViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import <Parse/Parse.h>
#import "PictureUploads.h"


@interface CaptureViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property UIImage *image;
@property NSString *videoFilePath;
@property NSMutableArray *images;

@end

@implementation CaptureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.images = [[NSMutableArray alloc]init];
    self.imagePicker = [[UIImagePickerController alloc]init];
    self.imagePicker.delegate  = self;
    self.imagePicker.allowsEditing =YES;
    self.imagePicker.videoMaximumDuration = 5;


    //checks if camera is accesible
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;

    } else {

        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;


    }
    self.imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:self.imagePicker.sourceType];

    [self presentViewController:self.imagePicker animated:true completion:nil];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:true];
    //taking a photo
    if (self.image == nil && [self.videoFilePath length] == 0) {

    self.imagePicker = [[UIImagePickerController alloc]init];
    self.imagePicker.delegate  = self;
    self.imagePicker.allowsEditing =YES;
    self.imagePicker.videoMaximumDuration = 5;

    //checks if camera is accesible
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;

    }else{

        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;


    }
    self.imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:self.imagePicker.sourceType];

    [self presentViewController:self.imagePicker animated:true completion:nil];

    }

    

}


#pragma mark imagepickerDelegate

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:NO completion:nil];

    [self.tabBarController setSelectedIndex:0];

}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];

    NSLog(@"*********%@*********",info);
    //if media is equeal to image
    if ([mediaType isEqual:(NSString *)kUTTypeImage]) {
        //a photo was taken
        self.image = [info objectForKey:UIImagePickerControllerEditedImage];

            if (self.imagePicker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            //save the image if taken a photo
                UIImageWriteToSavedPhotosAlbum(self.image, nil, nil, nil);

            }else {
                //VIDEO WAS TAKEN OR SELECTED

                //finds the path of video
                NSURL *imagePickerURL = [info objectForKey:UIImagePickerControllerMediaURL];
                self.videoFilePath = [imagePickerURL path];

                //check if you can put a video in camera roll
                if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(self.videoFilePath)) {
                    //save the video
                    UISaveVideoAtPathToSavedPhotosAlbum(self.videoFilePath, nil, nil, nil);
                }

            }

        [self uploadPic];
        [self dismissViewControllerAnimated:NO completion:nil];
        [self.tabBarController setSelectedIndex:0];
    }

}



-(void)uploadPic{


[PictureUploads UploadImage:self.image andVideoPath:self.videoFilePath completionHandler:^(NSMutableArray *array) {
    self.images = array;
 NSLog(@"😜😜😜😜%@😜😜😜😜",self.images);
    [[NSNotificationCenter defaultCenter]postNotificationName:@"Test1" object:self];
    [self reset];

}];
}

- (void)reset {
    self.image=nil;
    self.videoFilePath=nil;
}


@end
