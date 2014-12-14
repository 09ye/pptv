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

@interface SHTVDetailViewController : SHTableViewController<SHTableHorizontalViewDataSource,SHTableHorizontalViewDelegate,SHShowVideoViewControllerDelegate,SHTaskDelegate>
{
    SHShowVideoViewController* mShowViewControll;
    SHTVDrameViewController * mDrameViewControll;
    SHDemandDetailViewController * mDemandDetailViewControll;
    __weak IBOutlet SHTableHorizontalView *mScrollview;
    __weak IBOutlet UIView *mViewVideo;
    __weak IBOutlet UIView *mViewContent;
    __weak IBOutlet UIView *mViewDown;
    NSDictionary * dicPreInfo;
    NSDictionary * mResultDetail;
    NSString * mVideoUrl;
    NSString * mVideotitle;
    

}


@end
