//
//  GloalController.h
//  TMDB_DEMO_MVC
//
//  Created by webskitters on 12/09/17.
//  Copyright © 2017 webskitters. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UserData.h"

@interface GloalController : NSObject

+ (GloalController*) sharedInstance;

@property(nonatomic, retain) UserData *loginUser;

- (void)showAlertWithTitle:(NSString *)title withMessage:(NSString *)message withController:(UIViewController*)controller;




@end
