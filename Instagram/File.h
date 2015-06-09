//
//  File.h
//  Instagram
//
//  Created by Alex Santorineos on 6/9/15.
//  Copyright (c) 2015 madApperz. All rights reserved.
//

#import <Parse/Parse.h>

@interface File : PFFile

@property NSString *fileName;
@property NSData *data;

-(instancetype)initWithData:(NSData *)data andWithName:(NSString *)fileName;

@end
