//
//  PictureUploads.h
//  Instagram
//
//  Created by Alex Santorineos on 6/9/15.
//  Copyright (c) 2015 madApperz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@interface PictureUploads : NSObject

@property NSData* data;
@property NSString *fileName;
@property NSString *fileType;
@property UIImage *image;

+ (void)UploadImage:(UIImage *)image andVideoPath:(NSString *)videoFilePath completionHandler:(void (^)(NSMutableArray *))complete;


@end
