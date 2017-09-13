//
//  DashBoardView.h
//  TMDB_DEMO_MVC
//
//  Created by webskitters on 13/09/17.
//  Copyright © 2017 webskitters. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DashBoardController.h"
#import "HeaderView.h"

@interface DashBoardView : UIView

@property (nonatomic, retain) DashBoardController  *dashController;

@property (nonatomic, strong) HeaderView *sectionView;

@property (nonatomic, strong) IBOutlet UITableView *tblMovieList;

- (void)initializeViewWithController:(DashBoardController *)dashViewController;

@end
