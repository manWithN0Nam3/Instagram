//
//  ActivityViewController.m
//  Instagram
//
//  Created by Tom Carmona on 6/11/15.
//  Copyright (c) 2015 madApperz. All rights reserved.
//

#import "ActivityViewController.h"

@interface ActivityViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) NSArray *activities;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.activities = [[NSArray alloc]init];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityCellID"];
    cell.textLabel.text = [NSString stringWithFormat:@"tomcarmona has posted a photo to Pimpstagram"];
    return cell;
}

@end
