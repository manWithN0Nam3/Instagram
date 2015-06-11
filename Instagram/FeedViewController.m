//
//  FeedViewController.m
//  Instagram
//
//  Created by Tom Carmona on 6/10/15.
//  Copyright (c) 2015 madApperz. All rights reserved.
//

#import "FeedViewController.h"

@interface FeedViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableViewCell *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property NSArray *pictures;
@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.


}


-(id)initWithCoder:(NSCoder *)aDecoder{

    self = [super initWithCoder:aDecoder];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotification:) name:@"Test1" object:nil];
    }
    return self;
}


-(void)receiveNotification:(NSNotification *)notification {
    if ([notification.name isEqualToString:@"Test1"]) {

        [self queryFromParse];

    }

}

-(void)queryFromParse{

    //    PFRelation *pictureRelation = [self.currentUser relationForKey:@"pictureRelation"];

    PFQuery* query = [PFQuery queryWithClassName:@"PictureUpload"];


    [query orderByDescending:@"createdAt"];

    //        [query whereKey:@"userId" equalTo:[[PFUser currentUser] objectId]];

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        else {
            // We found messages!
            self.pictures = objects;
//            [self.collectionView reloadData];
            NSLog(@"%@", objects);

            NSLog(@"Retrieved %lu messages", (unsigned long)[self.pictures count]);
        }
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

   return self.pictures.count;

}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"feedCell"];

    PFObject *pictureObject = [self.pictures objectAtIndex:indexPath.row];


    //    cell.backgroundView = [[UIImageView alloc]initWithImage:[self.pics objectAtIndex:indexPath.row]];
    //    cell. = [pictureObject objectForKey:@"userName"];

//    cell.textView.text = [pictureObject objectForKey:@"userName"];


    PFFile *file = [pictureObject objectForKey:@"file"];
    NSData *data = [file getData];
    UIImage *image = [UIImage imageWithData:data];
//    cell.imageView.image = image;
    cell.backgroundView = [[UIImageView alloc]initWithImage:image];

    return cell;


}



@end
