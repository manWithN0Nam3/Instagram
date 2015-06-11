//
//  UserViewController.m
//  Instagram
//
//  Created by Tom Carmona on 6/10/15.
//  Copyright (c) 2015 madApperz. All rights reserved.
//

#import "UserViewController.h"

@interface UserViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    return cell;
}


@end
