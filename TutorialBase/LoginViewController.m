//
//  LoginViewController.m
//  TutorialBase
//
//  Created by Antonio MG on 6/23/12.
//  Copyright (c) 2012 AMG. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"

@interface LoginViewController ()
@property (nonatomic, strong) IBOutlet UITextField *userTextField;
@property (nonatomic, strong) IBOutlet UITextField *passwordTextField;
@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

#pragma mark - Private methods

-(IBAction)logInPressed:(id)sender
{
    [self performSegueWithIdentifier:@"LoginSuccesful" sender:self];
}

@end
