//
//  SHLiveViewController.h
//  PPTV
//
//  Created by yebaohua on 14/12/1.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"
#import "SHShowVideoViewController.h"
#import "SHLiveListViewController.h"
@interface SHLiveViewController : SHTableViewController
{
    __weak IBOutlet UIView *mViewVideo;
    __weak IBOutlet UIView *mViewContent;
    __weak IBOutlet UIView *mViewDown;
    SHShowVideoViewController* mShowViewControll;
    SHLiveListViewController * mListViewControll;
    AppDelegate * app;
    CGRect videoRect;
}

@property(nonatomic,retain) UINavigationController *navController; // If this view controller has been pushed onto a navigation controller, return it.
@end
