//
//  ViewController.h
//  TMDB_DEMO_MVC
//
//  Created by webskitters on 12/09/17.
//  Copyright © 2017 webskitters. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginController : UIViewController

- (void)loginWithEmail:(NSString *)email AndPassword:(NSString *)password;
- (void)navigateToSignupPage;

@end

