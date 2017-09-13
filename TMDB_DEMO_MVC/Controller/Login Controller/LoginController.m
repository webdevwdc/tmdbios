//
//  ViewController.m
//  TMDB_DEMO_MVC
//
//  Created by webskitters on 12/09/17.
//  Copyright © 2017 webskitters. All rights reserved.
//

#import "LoginController.h"
#import "RegistrationController.h"
#import "DashBoardController.h"
#import "LoginView.h"
#import "CMHud.h"

@interface LoginController ()

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LoginView *loginView = (LoginView*)self.view;
    [loginView initializeViewWithController: self];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loginWithEmail:(NSString *)email AndPassword:(NSString *)password{
    
   [CMHud showHUDAddedTo:self.view animated:YES];
    
    NSDictionary *dictParams = @{
                                 @"email" : email,
                                 @"password" : password,
                                };
    [ServiceRequestManager loginWithParams:dictParams withCompletion:^(NSData *data, NSURLResponse *response, NSError *error){
       [CMHud hideHUDForView:self.view animated:YES];
        
        if (!error){
          NSError *error = nil;
          NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            NSLog(@"%@",responseDict);
            if ([[responseDict valueForKey:@"status"] intValue] == 200) {
             
                [self navigateToDashboardpage];
                
            }
            else{
                [DataManager showAlertWithTitle:@"Alert" withMessage:[responseDict valueForKey:@"message"] withController:self];
            }
        }
        else{
         
           [DataManager showAlertWithTitle:@"Alert" withMessage:@"Please Try Again.Something wrong happened." withController:self];
        }
        
    }];
    
}


#pragma mark - Navigate to Dashboard Page

-(void)navigateToDashboardpage{
   
    DashBoardController *dashControllerVC = (DashBoardController *)[self.storyboard instantiateViewControllerWithIdentifier:@"DashBoardController"];
    [self.navigationController pushViewController:dashControllerVC animated:YES];
    [dashControllerVC view];
    
}


#pragma mark - Navigate To Signup Page

-(void)navigateToSignupPage{
    
    RegistrationController *regControllerVC = (RegistrationController *)[self.storyboard instantiateViewControllerWithIdentifier:@"RegistrationController"];
    [self.navigationController pushViewController:regControllerVC animated:YES];

}
@end
