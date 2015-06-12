//
//  DeleteButton.m
//  Instagram
//
//  Created by Alex Santorineos on 6/12/15.
//  Copyright (c) 2015 madApperz. All rights reserved.
//

#import "DeleteButton.h"


@implementation DeleteButton

- (id) initWithCoder:(NSCoder *)aDecoder {

    self = [super initWithCoder:aDecoder];

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tappedButton)];
    [self addGestureRecognizer:tapGesture];

    return self;
    
}



-(void)tappedButton{

    NSLog(@"😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘😘");

    [self.delegate DeleteButtonDelegate:self];
}


@end
