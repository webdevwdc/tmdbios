//
//  RegistrationView.h
//  TMDB_DEMO_MVC
//
//  Created by webskitters on 12/09/17.
//  Copyright © 2017 webskitters. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegistrationController.h"

@interface RegistrationView : UIView

@property (nonatomic, retain) RegistrationController  *regController;

@property (weak, nonatomic) IBOutlet UITextField *firstNameField;

@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *contactNoField;



- (void)initializeViewWithController:(RegistrationController*)regViewController;

- (IBAction)btnSigninAction:(id)sender;

@end
