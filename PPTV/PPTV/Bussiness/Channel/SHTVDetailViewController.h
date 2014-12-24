//
//  SHTVDetailViewController.h
//  PPTV
//
//  Created by yebaohua on 14/11/19.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"
#import "SHShowVideoViewController.h"
#import "SHChannelHorizontalCell.h"
#import "SHTVDrameViewController.h"
#import "SHDemandDetailViewController.h"
#import "SHMoviceDownloadViewController.h"

@interface SHTVDetailViewController : SHTableViewController<SHTableHorizontalViewDataSource,SHTableHorizontalViewDelegate,SHShowVideoViewControllerDelegate,SHTaskDelegate,SHTVDrameViewControllerDelegate>
{
    SHShowVideoViewController* mShowViewControll;
    SHTVDrameViewController * mDrameViewControll;
    SHDemandDetailViewController * mDemandDetailViewControll;
    SHMoviceDownloadViewController *mMoviceDownloadViewControll;
    __weak IBOutlet SHTableHorizontalView *mScrollview;
    __weak IBOutlet UIView *mViewVideo;
    __weak IBOutlet UIView *mViewContent;
    __weak IBOutlet UIView *mViewDown;
    NSDictionary * dicPreInfo;
    NSDictionary * mResultDetail;
    NSString * mVideoUrl;
    NSString * mVideotitle;
    NSMutableArray * arrayCollect;
    NSDictionary*  mDicVideoCurrent;//正在播放的视频 name id time
    

}


@end
