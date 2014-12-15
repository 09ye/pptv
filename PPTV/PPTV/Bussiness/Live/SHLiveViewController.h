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
#import "SHBillListViewController.h"
#import "UIViewAdditions.h"
@interface SHLiveViewController : SHTableViewController<SHTaskDelegate,SHShowVideoViewControllerDelegate,UIPageViewControllerDelegate,UIPageViewControllerDataSource>
{
    

    __weak IBOutlet UIView *mViewVideo;
    __weak IBOutlet UIView *mViewContent;
    __weak IBOutlet UIView *mViewDown;
    __weak IBOutlet UIImageView *moveImageView;
    __weak IBOutlet UIView *mViewBill;

    SHLiveListViewController * mListViewControll;
    SHShowVideoViewController* mShowViewControll;
    SHBillListViewController * mBillViewControll;
    AppDelegate * app;
    NSDictionary * dicPreInfo;
    NSDictionary * mResultDetail;
    NSString * mVideoUrl;
    NSString * mVideotitle;
    UIPageViewController         *pageVC;
    NSMutableArray * mListPagesView;
    NSArray * arrayBtnDay;
    NSArray * arrayLine;
    __weak IBOutlet UIButton *mbtnDay1;
    __weak IBOutlet UIButton *mbtnDay2;
    __weak IBOutlet UIButton *mbtnDay3;
    __weak IBOutlet UIButton *mbtnDay4;
    __weak IBOutlet UIButton *mbtnDay5;
    __weak IBOutlet UIButton *mbtnDay6;
    __weak IBOutlet UIButton *mbtnDay7;
}

- (IBAction)btnDaySelectOntouch:(UIButton *)sender;
@property(nonatomic,retain) UINavigationController *navController; // If this view controller has been pushed onto a navigation controller, return it.
@end
