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
    arrayLine = [[NSArray alloc]initWithObjects:@"-610",@"-525",@"-432",@"-334",@"-224",@"-121",@"-16", nil];
    arrayBtnDay = [[NSArray alloc]initWithObjects:mbtnDay1,mbtnDay2,mbtnDay3,mbtnDay4,mbtnDay5,mbtnDay6,mbtnDay7, nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    self.title = @"播放详情";
//    app=(AppDelegate*)[UIApplication sharedApplication].delegate;
    dicPreInfo = [self.intent.args objectForKey:@"detailInfo"];
    
    pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                  navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                options:nil];
    pageVC.dataSource = self;
    pageVC.delegate   = self;
    mListPagesView = [NSMutableArray array];
    for (int i = 0; i<7; i++) {
        mBillViewControll = [[SHBillListViewController alloc]init];
        mBillViewControll.tag = i;
        mBillViewControll.list = [[NSMutableArray alloc]init];
        mBillViewControll.view.frame = mViewBill.bounds;
        [mListPagesView addObject:mBillViewControll];
    }
    [pageVC setViewControllers: @[[mListPagesView objectAtIndex:0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
        
                NSLog(@"xxxxxxx");
            } ];

    
   
    [self addChildViewController:pageVC];
    [mViewBill addSubview:pageVC.view];
    pageVC.view.frame = mViewBill.bounds;
    [pageVC didMoveToParentViewController:self];
    
    mListViewControll = [[SHLiveListViewController alloc]init];
    mListViewControll.list = [[NSMutableArray alloc]init ];
    mListViewControll.view.frame = mViewContent.bounds;
    [mViewContent addSubview:mListViewControll.view];
    
    mShowViewControll = [[SHShowVideoViewController alloc]init];
    mShowViewControll.delegate = self;
    mShowViewControll.isLive = YES;
    if (dicPreInfo) {
        mShowViewControll.isfull = YES;
//        mShowViewControll.view.frame = CGRectMake(0, 0, UIScreenWidth, UIScreenHeight);
    }else{
         mShowViewControll.isfull = NO;
        mShowViewControll.view.frame = mViewVideo.frame;
    }

    [self.view addSubview:mShowViewControll.view];
    
    [mListViewControll.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    [self request:[[dicPreInfo objectForKey:@"id"]intValue]];
    
    
}


-(void) request:(NSInteger)videoID
{
    
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"Pad/liveinfo");
    [post.postArgs setValue:@"123456" forKey:@"id"];
    post.delegate = self;
    [post start:^(SHTask *t) {
        
        mResultDetail = [[t result]mutableCopy];
        mVideotitle = [mResultDetail objectForKey:@"title"];
        mVideoUrl = [mResultDetail objectForKey:@"playurl"];
        mVideoUrl = @"http://padlive2-cnc.wasu.cn/cctv7/z.m3u8";
        self.title = mVideotitle;
        NSURL * videoUrl = [NSURL URLWithString:mVideoUrl];
        [mShowViewControll quicklyReplayMovie:videoUrl title:[mResultDetail objectForKey:@"title"] seekToPos:0];
        
        
    } taskWillTry:^(SHTask *t) {
        
    } taskDidFailed:^(SHTask *t) {
        
    }];
    
}
#pragma video delegate
- (void)playCtrlGetNextMediaTitle:(SHShowVideoViewController *)control lastPlayPos:(long *)lastPlayPos
{
    
    [mShowViewControll quicklyReplayMovie:[NSURL URLWithString:mVideoUrl] title:mVideotitle seekToPos:0];
}

- (void) showVideoControllerFullScreen:(SHShowVideoViewController*) control full:(BOOL) isFull
{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        if(dicPreInfo){
            if (isFull) {
                mShowViewControll.view.frame = self.view.bounds;
                //            [[UIApplication sharedApplication] setStatusBarHidden:YES];
                //            [self.navigationController setNavigationBarHidden:YES animated:YES];
                //            [self.view bringSubviewToFront:mShowViewControll.view];
            } else {
               mShowViewControll.view.frame = mViewVideo.frame;
                
            }
        }else{
            if (isFull) {
            
                [app hideTarBarSHDelegate:YES];
                self.view.frame = CGRectMake(0, 0, UIScreenWidth, UIScreenHeight);
                mShowViewControll.view.frame = self.view.frame;
            } else {
                [app hideTarBarSHDelegate:NO];
                self.view.frame = CGRectMake(0, 64, UIScreenWidth, UIScreenHeight-64-49);
                mShowViewControll.view.frame = mViewVideo.frame;
                
                
            }
            
        }
    }completion:^(BOOL finished) {
        
    }];

}
#pragma mark UIPageViewControllerDataSource methods


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    
    
    NSInteger pageNumber = ((SHBillListViewController*)viewController).tag-1;
    NSLog(@"11111>>>>> %d",pageNumber);
    [self changeBill:pageNumber+1];
    return (pageNumber >= 0) ? mListPagesView[pageNumber] : nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    
    NSInteger pageNumber = ((SHBillListViewController*)viewController).tag+1;
    NSLog(@"2222>>>>> %d",pageNumber);
    [self changeBill:pageNumber-1];
    return (pageNumber < mListPagesView.count) ? mListPagesView[pageNumber] : nil;
}
-(void) changeBill:(int) tag
{
    //600 515
  
    [moveImageView  moveTo:CGPointMake([[arrayLine objectAtIndex:tag]intValue ], 50) duration:0.3 option:UIViewAnimationOptionCurveLinear];
    for (int i = 0;i<arrayBtnDay.count;i++) {
        UIButton * button = [arrayBtnDay objectAtIndex:i];
        if (button.tag ==tag) {
            [button setTitleColor:[SHSkin.instance colorOfStyle:@"ColorTextOrg"] forState:UIControlStateNormal];
        }else{
            [button setTitleColor:[SHSkin.instance colorOfStyle:@"ColorStyleLight"] forState:UIControlStateNormal];
        }
    }
    
}
- (IBAction)btnDaySelectOntouch:(UIButton *)sender {
    [self changeBill:sender.tag];
}
@end
