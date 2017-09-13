//
//  RegistrationController.m
//  TMDB_DEMO_MVC
//
//  Created by webskitters on 12/09/17.
//  Copyright © 2017 webskitters. All rights reserved.
//

#import "RegistrationController.h"
#import "DashBoardController.h"
#import "RegistrationView.h"
#import "CMHud.h"

@interface RegistrationController ()

@end

@implementation RegistrationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RegistrationView *regView = (RegistrationView*)self.view;
    [regView initializeViewWithController: self];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)registerWithUserdata:(UserData *)userData{
    
    [CMHud showHUDAddedTo:self.view animated:YES];
    
    NSDictionary *dictParams = @{
                                 @"firstName" : userData.firstname,
                                 @"lastName" : userData.lastName,
                                 @"email" : userData.email,
                                 @"password" : userData.password,
                                 @"contactNo" : userData.contactNo
                                 };
    [ServiceRequestManager registerWithParams:dictParams withCompletion:^(NSData *data, NSURLResponse *response, NSError *error){
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
    
}

@end
