//
//  LoginView.m
//  TMDB_DEMO_MVC
//
//  Created by webskitters on 12/09/17.
//  Copyright © 2017 webskitters. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView
@synthesize emailField;
@synthesize passwordField;


@synthesize controller;


#pragma mark - Initialize the view

- (void)initializeViewWithController:(LoginController*)loginViewController
{
    controller = loginViewController;
    
}

#pragma mark - UITextField Delegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
   
    [textField resignFirstResponder];
    return YES;
    
}


#pragma mark - Login Button Action

- (IBAction)btnLoginAction:(id)sender
{
    if ([emailField.text length] == 0) {
        [DataManager showAlertWithTitle:@"Error" withMessage:@"The email field is required!" withController:controller];
    } else if([passwordField.text length] == 0) {
        [DataManager showAlertWithTitle:@"Error" withMessage:@"The password field is required!" withController:controller];
    } else {
        [self endEditing:YES];
        [controller loginWithEmail:[emailField text] AndPassword:[passwordField text]];
    }
}


#pragma mark - Signup Button Action

- (IBAction)btnSignupAction:(id)sender{
    
    [controller navigateToSignupPage];
    
}



@end
