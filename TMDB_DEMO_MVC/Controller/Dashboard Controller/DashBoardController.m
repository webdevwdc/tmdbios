//
//  DashBoardController.m
//  TMDB_DEMO_MVC
//
//  Created by webskitters on 13/09/17.
//  Copyright © 2017 webskitters. All rights reserved.
//

#import "DashBoardController.h"
#import "DashBoardView.h"
#import "CMHud.h"


@interface DashBoardController ()

@end

@implementation DashBoardController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DashBoardView *dashBoardView = (DashBoardView*)self.view;
    [dashBoardView initializeViewWithController: self];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
