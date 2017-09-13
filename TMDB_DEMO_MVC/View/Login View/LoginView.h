//
//  LoginView.h
//  TMDB_DEMO_MVC
//
//  Created by webskitters on 12/09/17.
//  Copyright © 2017 webskitters. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginController.h"

@interface LoginView : UIView

@property (nonatomic, retain) IBOutlet UITextField *emailField;
@property (nonatomic, retain) IBOutlet UITextField *passwordField;


@property (nonatomic, retain) LoginController  *controller;

- (void)initializeViewWithController:(LoginController *)loginViewController;

- (IBAction)btnLoginAction:(id)sender;
- (IBAction)btnSignupAction:(id)sender;


@end
