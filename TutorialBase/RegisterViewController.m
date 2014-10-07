//
//  RegisterViewController.m
//  TutorialBase
//
//  Created by Antonio MG on 6/27/12.
//  Copyright (c) 2012 AMG. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()
@property (nonatomic, strong) IBOutlet UITextField *userRegisterTextField;
@property (nonatomic, strong) IBOutlet UITextField *passwordRegisterTextField;
@end

@implementation RegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {

    }
    
    return self;
}

#pragma mark - Private methods

-(IBAction)signUpUserPressed:(id)sender
{
    //TODO
    //If signup sucessful:
    [self performSegueWithIdentifier:@"SignupSuccesful" sender:self];
}

@end
