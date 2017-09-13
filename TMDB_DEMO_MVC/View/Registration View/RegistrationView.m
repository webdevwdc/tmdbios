//
//  RegistrationView.m
//  TMDB_DEMO_MVC
//
//  Created by webskitters on 12/09/17.
//  Copyright © 2017 webskitters. All rights reserved.
//

#import "RegistrationView.h"

@implementation RegistrationView

@synthesize firstNameField;
@synthesize lastNameField;
@synthesize emailField;
@synthesize passwordField;
@synthesize contactNoField;

@synthesize regController;

#pragma mark - Initialize the view

- (void)initializeViewWithController:(RegistrationController*)regViewController
{
    regController = regViewController;
    [self setNumberPadToTextField:contactNoField];
    
}


#pragma mark - setNumberPadToTextField
-(void)setNumberPadToTextField : (UITextField*)textField
{
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, regController.view.frame.size.width, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(cancelNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    textField.inputAccessoryView = numberToolbar;
}

#pragma mark - cancelNumberPad
-(void)cancelNumberPad
{
    [contactNoField resignFirstResponder];
    
}

#pragma mark - doneWithNumberPad
-(void)doneWithNumberPad
{
    [contactNoField resignFirstResponder];
}


#pragma mark - UITextField Delegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
    
}

#pragma mark - Button Actions


- (IBAction)btnSigninAction:(id)sender {
   
    if ([firstNameField.text length] == 0) {
        [DataManager showAlertWithTitle:@"Error" withMessage:@"The first Name field is required!" withController:regController];
    } else if([lastNameField.text length] == 0) {
        [DataManager showAlertWithTitle:@"Error" withMessage:@"The Last Name field is required!" withController:regController];
    }else if([emailField.text length] == 0) {
        [DataManager showAlertWithTitle:@"Error" withMessage:@"The Email field is required!" withController:regController];
    }else if([passwordField.text length] == 0) {
        [DataManager showAlertWithTitle:@"Error" withMessage:@"The Password field is required!" withController:regController];
    }else if([contactNoField.text length] == 0) {
        [DataManager showAlertWithTitle:@"Error" withMessage:@"The Contact Number field is required!" withController:regController];
    } else {
        [self endEditing:YES];
        
        DataManager.loginUser = [[UserData alloc] init];
        DataManager.loginUser.firstname = firstNameField.text;
        DataManager.loginUser.lastName = lastNameField.text;
        DataManager.loginUser.email = emailField.text;
        DataManager.loginUser.password = passwordField.text;
        DataManager.loginUser.contactNo = contactNoField.text;
        
        [regController registerWithUserdata:DataManager.loginUser];
    }

    
}
@end
