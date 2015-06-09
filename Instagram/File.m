//
//  File.m
//  Instagram
//
//  Created by Alex Santorineos on 6/9/15.
//  Copyright (c) 2015 madApperz. All rights reserved.
//

#import "File.h"

@implementation File


-(instancetype)initWithData:(NSData *)data andWithName:(NSString *)fileName{
    self = [super init];
    if (self) {
        self.data = data;
        self.fileName = fileName;

    }

    return self;
}

@end
