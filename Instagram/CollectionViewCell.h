//
//  CollectionViewCell.h
//  Instagram
//
//  Created by Alex Santorineos on 6/9/15.
//  Copyright (c) 2015 madApperz. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface CollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end
