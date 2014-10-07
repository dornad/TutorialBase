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
    //TODO: Get the wall objects from the server
}

-(void)loadWallViews
{
    //TODO: Put the wall objects in the scroll view
}

-(IBAction)logoutPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)showErrorView:(NSString *)errorMsg{
    
    UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMsg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [errorAlertView show];
}

@end
