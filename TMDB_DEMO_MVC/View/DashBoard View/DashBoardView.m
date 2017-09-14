//
//  DashBoardView.m
//  TMDB_DEMO_MVC
//
//  Created by webskitters on 13/09/17.
//  Copyright © 2017 webskitters. All rights reserved.
//

#import "DashBoardView.h"
#import "TableCell.h"
#import "CollectionCell.h"


#define IMAGE_URL @"http://image.tmdb.org/t/p/w780/"

@implementation DashBoardView
{
    NSMutableArray *arrDateMovieList;      //// Use to hold array according to Date Range
    NSMutableArray *arrPopularMovieList;   //// Use to hold array according to popularity
    NSMutableArray *arrTopRatedMovieList;  //// use to hold array according to rating
}
@synthesize dashController;
@synthesize tblMovieList;
@synthesize sectionView;

- (void)initializeViewWithController:(DashBoardController *)dashViewController{
    
    dashController = dashViewController;
    
    arrDateMovieList = [[NSMutableArray alloc] init];
    arrPopularMovieList = [[NSMutableArray alloc] init];
    arrTopRatedMovieList = [[NSMutableArray alloc] init];
    
    
    tblMovieList.tableHeaderView = sectionView;
    
    [dashController movieListFetchForDateLimit];

    
}

- (void)populateTableWithMovieArrayWithDate:(NSMutableArray *)arrMovieDate andArrayWithPopularity:(NSMutableArray *)arrMoviePolular andArrayWithTopRated:(NSMutableArray *)arrMovieTopRated{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        arrDateMovieList = arrMovieDate;
        arrPopularMovieList = arrMoviePolular;
        arrTopRatedMovieList = arrMoviePolular;
        
        [tblMovieList reloadData];

        
    });
    
}



#pragma mark - Table View DataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0)
    {
        return 1;
    }
    else if (section==1)
    {
        return 1;
    }
    else
    {
        return 1;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    TableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[TableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    
    cell.collectionview.tag = indexPath.section;
    
    [cell.collectionview reloadData];
    
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40.0;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    sectionView = (HeaderView *)[[NSBundle mainBundle]loadNibNamed:@"HeaderView" owner:self options:nil][0];
    
    sectionView.frame = CGRectMake(0, 0, dashController.view.frame.size.width,40);
    
    if (section == 0)
        sectionView.lblHeaderName.text = @"New in Theatres";
    if (section == 1)
        sectionView.lblHeaderName.text = @"Popular";
    if (section == 2)
        sectionView.lblHeaderName.text = @"Highest Rated This Year";
    
    return sectionView;
    
}

#pragma mark - CollectionView Delegate Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    if (collectionView.tag == 0) {
        return arrDateMovieList.count;
    }
    else if (collectionView.tag == 1) {
        return arrPopularMovieList.count;
    }
    else{
        return arrTopRatedMovieList.count;
    }
    
}
- (NSIndexPath *)indexPathForRowAtPoint:(CGPoint)point

{
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectCell" forIndexPath:indexPath];
    
    
    cell.movieimage.layer.masksToBounds =YES;
    cell.movieimage.layer.cornerRadius = 8;
    
    if (collectionView.tag == 0) {
        cell.movieName.text = [[arrDateMovieList objectAtIndex:indexPath.item] valueForKey:@"title"];
        
        if ([[arrDateMovieList objectAtIndex:indexPath.item] valueForKey:@"poster_path"]) {
            
            [self loadCellImage:cell.movieimage imageUrl:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[[arrDateMovieList objectAtIndex:indexPath.item] valueForKey:@"poster_path"]]];
            
        }
        else{
            cell.movieimage.image = [UIImage imageNamed:@"No_Image"];
        }
        
        
    }
    else if (collectionView.tag == 1) {
        cell.movieName.text = [[arrPopularMovieList objectAtIndex:indexPath.item] valueForKey:@"title"];
        
        if ([[arrPopularMovieList objectAtIndex:indexPath.item] valueForKey:@"poster_path"]){
            
            [self loadCellImage:cell.movieimage imageUrl:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[[arrPopularMovieList objectAtIndex:indexPath.item] valueForKey:@"poster_path"]]];
        }
        else{
            cell.movieimage.image = [UIImage imageNamed:@"No_Image"];
        }
        
    }
    else{
        cell.movieName.text = [[arrTopRatedMovieList objectAtIndex:indexPath.item] valueForKey:@"title"];
        
        if ([[arrTopRatedMovieList objectAtIndex:indexPath.item] valueForKey:@"poster_path"]){
            
            [self loadCellImage:cell.movieimage imageUrl:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[[arrTopRatedMovieList objectAtIndex:indexPath.item] valueForKey:@"poster_path"]]];
            
        }
        else{
            cell.movieimage.image = [UIImage imageNamed:@"No_Image"];
            
        }
        
    }
    
    return cell;
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}



#pragma mark - Load Image Asynchronously

- (void)loadCellImage:(UIImageView *)imageView imageUrl:(NSString *)imageURL
{
    if (imageURL) {
        [[imageView viewWithTag:99] removeFromSuperview];
        
        __block UIActivityIndicatorView *activityIndicator;
        __weak UIImageView *weakImageView = imageView;
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageURL]
                     placeholderImage:nil
                              options:SDWebImageProgressiveDownload
                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                 if (!activityIndicator) {
                                     [weakImageView addSubview:activityIndicator = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite]];
                                     activityIndicator.tag = 99;
                                     activityIndicator.center = weakImageView.center;
                                     [activityIndicator startAnimating];
                                 }
                             }
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                [activityIndicator removeFromSuperview];
                                activityIndicator = nil;
                            }];
    }
}





@end
