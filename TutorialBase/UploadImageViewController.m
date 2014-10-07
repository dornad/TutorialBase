//
//  TPUploadImageViewController.m
//  TutorialBase
//
//  Created by Antonio MG on 7/4/12.
//  Copyright (c) 2012 AMG. All rights reserved.
//

#import "UploadImageViewController.h"

@interface UploadImageViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) IBOutlet UIImageView *imgToUpload;
@property (nonatomic, strong) IBOutlet UITextField *commentTextField;
@property (nonatomic, strong) NSString *username;
@end

@implementation UploadImageViewController

#pragma mark - Private methods

-(IBAction)selectPicturePressed:(id)sender
{
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
    imgPicker.delegate = self;
    imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self.navigationController presentModalViewController:imgPicker animated:YES];
}

-(IBAction)sendPressed:(id)sender
{
    [self.commentTextField resignFirstResponder];
    
    // Disable the send button until we are ready
    self.navigationItem.rightBarButtonItem.enabled = NO;

    // Display the loading spinner
    UIActivityIndicatorView *loadingSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [loadingSpinner setCenter:CGPointMake(self.view.frame.size.width/2.0f, self.view.frame.size.height/2.0f)];
    [loadingSpinner startAnimating];
    [self.view addSubview:loadingSpinner];
    
    NSData *pictureData = UIImagePNGRepresentation(self.imgToUpload.image);
    
    // Upload new picture
    // 1
    PFFile *image = [PFFile fileWithName:@"img" data:pictureData];
    
    [image saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // 2
            PFObject *wallImageObject = [PFObject objectWithClassName:@"WallImageObject"];
            wallImageObject[@"image"] = image;
            wallImageObject[@"user"] = [PFUser currentUser].username;
            wallImageObject[@"comment"] = self.commentTextField.text;
            
            // 3
            [wallImageObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                // 4
                if (succeeded) {
                    [self.navigationController popViewControllerAnimated:YES];
                } else {
                    [[[UIAlertView alloc] initWithTitle:@"Error" message:[error userInfo][@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
                }
            }];
        } else {
            // 5
            [[[UIAlertView alloc] initWithTitle:@"Error" message:[error userInfo][@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
    } progressBlock:^(int percentDone) {
        NSLog(@"Uploaded: %d%%", percentDone);
    }];
}

-(void)showErrorView:(NSString *)errorMsg
{
    UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMsg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [errorAlertView show];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissModalViewControllerAnimated:YES];
    self.imgToUpload.image = info[UIImagePickerControllerOriginalImage];
}

@end
