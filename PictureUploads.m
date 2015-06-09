//
//  PictureUploads.m
//  Instagram
//
//  Created by Alex Santorineos on 6/9/15.
//  Copyright (c) 2015 madApperz. All rights reserved.
//

#import "PictureUploads.h"
#import "File.h"
@implementation PictureUploads

-(instancetype)initWithData:(NSData *)data andFileName :(NSString *)fileName andFileType:(NSString *)fileType andImage:(UIImage*)image{

    self = [super init];


    if (self) {
//        self.data =data;
//        self.image = image;
//        self.fileName= fileName;
//        self.fileType = fileType;
    }
    return self;

}


+ (void)UploadImage:(UIImage *)image andVideoPath:(NSString *)videoFilePath completionHandler:(void (^)(NSMutableArray *))complete{

    NSData *fileData;
    NSString *fileName;
    NSString *fileType;



    if (image !=nil) {
        UIImage *newImage =image;

        //data is png
        //        fileData = UIImagePNGRepresentation(newImage);
        fileData = UIImageJPEGRepresentation(newImage, 0.5);
        fileName = @"image.jpg";
        fileType = @"image";
    }

    else{
        //data type is video
        fileData=[NSData dataWithContentsOfFile:videoFilePath];
        fileName = @"video.mov";
        fileType = @"video";

    }

    File *file1 = [[File alloc]initWithData:fileData andWithName:fileName];
    
    PFFile *file = [PFFile fileWithName:file1.fileName data:file1.data];

    

    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {



        if (error) {
            UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"error occured" message:@"please attempt to send ur message again, 😜" delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];

            [alertview show];
        }

        else{

            //file is on parse.com!!!

            //Make a PFQuery for the class PictureUpload

            //Run the query which will give you back in a block the PFOjects OR PFObject

            //acess the value for key "file" on that instance

            PFObject *picObject = [PFObject objectWithClassName:@"PictureUpload"];
            [picObject setObject:file forKey:@"file"];
            [picObject setObject:fileType forKey:@"fileType"];
            [picObject setObject:[[PFUser currentUser]objectId] forKey:@"UserId"];
            [picObject setObject:[[PFUser currentUser]username] forKey:@"userName"];

            [picObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                NSMutableArray *images = [[NSMutableArray alloc]init];
                NSMutableArray *images2 = [[NSMutableArray alloc]init];

                if (error) {
                    UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"error occured" message:@"please attempt  upload again" delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
                    [alertview show];
                }else{
                    //everything was succesful
                    [images addObject:picObject];
                    [images2 addObject:file1.data];
//                    NSLog(@"😜😜😜😜%@😜😜😜😜",images);
//                    NSLog(@"++++%@++++",images2);

//                    [self reset];
                }

                complete(images2);


            }];

        }
        
    }];




}
@end
