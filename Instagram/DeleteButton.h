//
//  DeleteButton.h
//  Instagram
//
//  Created by Alex Santorineos on 6/12/15.
//  Copyright (c) 2015 madApperz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DeleteButtonDelegate <NSObject>

-(void)DeleteButtonDelegate:(UIButton *)button;

@end

@interface DeleteButton : UIButton


@property (nonatomic)id<DeleteButtonDelegate>delegate;


@end
