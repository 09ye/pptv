//
//  SHDownloadViewController.h
//  PPTV
//
//  Created by yebaohua on 14/12/23.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"
#import "SHDownloadCollectionViewCell.h"

@interface SHDownloadViewController : SHTableViewController
{
    __weak IBOutlet UILabel *mlabTotal;
    __weak IBOutlet UILabel *mlabFree;
    __weak IBOutlet UILabel *mlabDownSize;
    __weak IBOutlet UIProgressView *mProgressSize;
    __weak IBOutlet UIView *mViewNoData;
    __weak IBOutlet UICollectionView *mCollection;
    AppDelegate *app;
}
@property(nonatomic,retain) UINavigationController *navController; // If this view controller has been pushed onto a navigation controller, return it.

@end
