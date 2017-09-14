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


@interface DashBoardController (){
    
    NSMutableArray *arrDateMovieList;      //// Use to hold array according to Date Range
    NSMutableArray *arrPopularMovieList;   //// Use to hold array according to popularity
    NSMutableArray *arrTopRatedMovieList;  //// use to hold array according to rating

    
    
}

@end

@implementation DashBoardController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    arrDateMovieList = [[NSMutableArray alloc] init];
    arrPopularMovieList = [[NSMutableArray alloc] init];
    arrTopRatedMovieList = [[NSMutableArray alloc] init];

    
    DashBoardView *dashBoardView = (DashBoardView*)self.view;
    [dashBoardView initializeViewWithController: self];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Movie List Fetch According to Date Limit

-(void)movieListFetchForDateLimit{
    
    [CMHud showHUDAddedTo:self.view animated:YES];
    
    NSString *urlRequest = @"http://api.themoviedb.org/3/discover/movie?api_key=da86572d94091de3671c20ed449c4c70&language=en&page=1&primary_release_date.gte=2017-07-01&primary_release_date.lte=2017-08-28";
    
    [ServiceRequestManager sendGetWithMethod:urlRequest withCompletion:^(NSData *data, NSURLResponse *response, NSError *error){
        dispatch_async(dispatch_get_main_queue(), ^{
            
            arrDateMovieList =nil;
            
            if (!error){
                NSError *error = nil;
                NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                NSLog(@"%@",responseDict);
                
                arrDateMovieList = [[responseDict objectForKey:@"results"] mutableCopy];
                [self movieListFetchForPopularity];
                
            }
            else{
                
            }

        
        });
        
    }];
    
}

#pragma mark - Movie List Fetch According to Popularity

-(void)movieListFetchForPopularity{
    
    NSString *urlRequest = @"http://api.themoviedb.org/3/discover/movie?api_key=da86572d94091de3671c20ed449c4c70&movie/popular";
    
    [ServiceRequestManager sendGetWithMethod:urlRequest withCompletion:^(NSData *data, NSURLResponse *response, NSError *error){
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            arrPopularMovieList =nil;
            
            if (!error){
                NSError *error = nil;
                NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                NSLog(@"%@",responseDict);
                
                arrPopularMovieList = [[responseDict objectForKey:@"results"] mutableCopy];
                [self movieListFetchForTopRated];
                
            }
            else{
                
            }

            
        });
        
    }];
    
    
}


#pragma mark - Movie List Fetch According to TopRated

-(void)movieListFetchForTopRated{
    
    NSString *urlRequest = @"http://api.themoviedb.org/3/discover/movie?api_key=da86572d94091de3671c20ed449c4c70&language=en&page=1&vote_count.gte=500&year=2017";
    
    [ServiceRequestManager sendGetWithMethod:urlRequest withCompletion:^(NSData *data, NSURLResponse *response, NSError *error){
        arrTopRatedMovieList =nil;
        
        [CMHud hideHUDForView:self.view animated:YES];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error){
                NSError *error = nil;
                NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                NSLog(@"%@",responseDict);
                
                arrTopRatedMovieList = [[responseDict objectForKey:@"results"] mutableCopy];
                
                DashBoardView *dashBoardView = (DashBoardView*)self.view;
                [dashBoardView populateTableWithMovieArrayWithDate:arrDateMovieList andArrayWithPopularity:arrPopularMovieList andArrayWithTopRated:arrTopRatedMovieList];
                
                
            }
            else{
                
            }

            
        });
        
    }];
    
    
}




@end
