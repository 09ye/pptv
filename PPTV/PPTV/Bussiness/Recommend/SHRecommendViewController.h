//
//  SHRecommendViewController.h
//  PPTV
//
//  Created by yebaohua on 14/11/16.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"
#import "BestScrollView.h"

@interface SHRecommendViewController : SHTableViewController<BestScrollViewDatasource,BestScrollViewDelegate,SHTaskDelegate>
{
    NSArray * mListItme;
    BestScrollView     *csView;
    NSInteger      imagesCount;
    NSMutableArray *imagesArray;
    AppDelegate* app;
}
@property(nonatomic,retain) UINavigationController *navController; // If this view controller has been pushed onto a navigation controller, return it.

@end
