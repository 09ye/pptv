//
//  SHLiveViewController.m
//  PPTV
//
//  Created by yebaohua on 14/12/1.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHLiveViewController.h"

@interface SHLiveViewController ()

@end

@implementation SHLiveViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
     self.view.backgroundColor =[SHSkin.instance colorOfStyle:@"ColorBaseBlack"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
   
    self.title = @"播放详情";
    
    app=(AppDelegate*)[UIApplication sharedApplication].delegate;
    videoRect = mViewVideo.frame;
    
    mShowViewControll = [[SHShowVideoViewController alloc]init];
    mShowViewControll.delegate = self;
    mShowViewControll.videoTitle = @"xxx";
    mShowViewControll.videoUrl = @"http://183.136.140.38/gsws/z.m3u8";
    mShowViewControll.videoUrl = @"http://hot.vrs.sohu.com/ipad1407291_4596271359934_4618512.m3u8";
    mShowViewControll.videoUrl = @"http://padlive2-cnc.wasu.cn/cctv7/z.m3u8";
    mShowViewControll.view.frame = mViewVideo.bounds;
    
    mShowViewControll.resetBtn.enabled = NO;
    
    mListViewControll = [[SHLiveListViewController alloc]init];
    mListViewControll.list = [[NSMutableArray alloc]init ];
    mListViewControll.view.frame = mViewContent.bounds;
    [mViewContent addSubview:mListViewControll.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [mViewVideo addSubview:mShowViewControll.view];

    [mListViewControll.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    
}

#pragma video
- (void) showVideoControllerFullScreen:(SHShowVideoViewController*) control full:(BOOL) isFull
{
    
    [UIView animateWithDuration:0.3 animations:^{
        if (isFull) {
             [app hideTarBarSHDelegate:YES];
            mViewContent.hidden = YES;
            mViewDown.hidden = YES;
            mViewVideo.frame = CGRectMake(0, 0, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height-44) ;
//            mShowViewControll.view.frame = mViewVideo.bounds;
            
        } else {
            mViewContent.hidden = NO;
            [app hideTarBarSHDelegate:NO];
            mViewDown.hidden = NO;
            mViewVideo.frame = videoRect;
//            mShowViewControll.view.frame = mViewVideo.bounds;
        }
    }completion:^(BOOL finished) {
        
    }];

}

@end
