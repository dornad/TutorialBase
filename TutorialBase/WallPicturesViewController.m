//
//  WallPicturesViewController.m
//  TutorialBase
//
//  Created by Antonio MG on 6/23/12.
//  Copyright (c) 2012 AMG. All rights reserved.
//

#import "WallPicturesViewController.h"
#import "UploadImageViewController.h"

@interface WallPicturesViewController ()
@property (nonatomic, strong) IBOutlet UIScrollView *wallScroll;
@property (nonatomic, retain) NSArray *wallObjectsArray;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;
@end

@implementation WallPicturesViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getWallImages];
    
}

#pragma mark - Private methods

-(void)getWallImages
{
    // 1
    PFQuery *query = [PFQuery queryWithClassName:@"WallImageObject"];
    
    // 2
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        // 3
        if (!error) {
            self.wallObjectsArray = objects;
            [self loadWallViews];
        } else {
            // 4
            [[[UIAlertView alloc] initWithTitle:@"Error" message:[error userInfo][@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
    }];
}

-(void)loadWallViews
{
    // Clean the scroll view
    [self.wallScroll.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isMemberOfClass:[UIView class]]) [obj removeFromSuperview];
    }];
    
    __block int originY = 10;
    
    [self.wallObjectsArray enumerateObjectsUsingBlock:^(PFObject *wallImageObject, NSUInteger idx, BOOL *stop) {
        // 1
        UIView *wallImageView = [[UIView alloc] initWithFrame:CGRectMake(10.0f, originY, self.view.frame.size.width - 20.0f, 300.0f)];
        
        // 2
        PFFile *image = (PFFile *)wallImageObject[@"image"];
        UIImageView *userImage = [[UIImageView alloc] initWithImage:[UIImage imageWithData:[image getData]]];
        userImage.frame = CGRectMake(0.0f, 0.0f, wallImageView.frame.size.width, 200.0f);
        userImage.contentMode = UIViewContentModeScaleAspectFit;
        [wallImageView addSubview:userImage];
        
        // 3
        NSDate *creationDate = wallImageObject.createdAt;
        NSDateFormatter *formatter = [NSDateFormatter new];
        formatter.dateStyle = NSDateFormatterShortStyle;
        formatter.timeStyle = NSDateFormatterShortStyle;
        
        // 4
        UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 210.0f, wallImageView.frame.size.width, 15.0f)];
        infoLabel.text = [NSString stringWithFormat:@"Uploaded by: %@, %@", wallImageObject[@"user"], [formatter stringFromDate:creationDate]];
        infoLabel.font = [UIFont fontWithName:@"Arial-ItalicMT" size:9.0f];
        infoLabel.textColor = [UIColor whiteColor];
        infoLabel.backgroundColor = [UIColor clearColor];
        [wallImageView addSubview:infoLabel];
        
        // 5
        UILabel *commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 240.0f, wallImageView.frame.size.width, 15.0f)];
        commentLabel.text = wallImageObject[@"comment"];
        commentLabel.font = [UIFont fontWithName:@"ArialMT" size:13.0f];
        commentLabel.textColor = [UIColor whiteColor];
        commentLabel.backgroundColor = [UIColor clearColor];
        [wallImageView addSubview:commentLabel];
        
        // 6
        [self.wallScroll addSubview:wallImageView];
        originY += (wallImageView.frame.size.height + 20);
    }];
    
    // 7
    self.wallScroll.contentSize = CGSizeMake(self.wallScroll.frame.size.width, originY);
}

-(IBAction)logoutPressed:(id)sender
{
    [PFUser logOut];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)showErrorView:(NSString *)errorMsg{
    
    UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMsg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [errorAlertView show];
}

@end
