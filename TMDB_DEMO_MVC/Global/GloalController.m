//
//  GloalController.m
//  TMDB_DEMO_MVC
//
//  Created by webskitters on 12/09/17.
//  Copyright © 2017 webskitters. All rights reserved.
//

#import "GloalController.h"

@implementation GloalController

@synthesize loginUser;

+ (GloalController *)sharedInstance {
    static GloalController *myGlobal = nil;
    
    if (myGlobal == nil) {
        myGlobal = [[[self class] alloc] init];
    }
    return myGlobal;
}


- (void)showAlertWithTitle:(NSString *)title withMessage:(NSString *)message withController:(UIViewController*)controller
{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:title
                                          message:message
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   NSLog(@"OK action");
                               }];
    
    [alertController addAction:okAction];
    [controller presentViewController:alertController animated:YES completion:nil];
}



@end
