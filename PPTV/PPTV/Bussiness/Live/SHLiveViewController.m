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
     self.view.backgroundColor =[SHSkin.instance colorOfStyle:@"ColorBackGroundVideo"];
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

    [[UIApplication sharedApplication] setStatusBarHidden:NO];
//    app=(AppDelegate*)[UIApplication sharedApplication].delegate;
    dicPreInfo = [self.intent.args objectForKey:@"detailInfo"];
//    self.leftTitle = [dicPreInfo objectForKey:@"title"];
    [self createDateView];
    [self createBill];
    
    
    
    mListViewControll = [[SHLiveListViewController alloc]init];
    mListViewControll.view.frame = mViewContent.bounds;
    mListViewControll.delegate = self;
    if (!dicPreInfo) {
         mListViewControll.isLiveList = YES;
    }
   
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
  
    mShowViewControll.videoType = emLiving;
    [self.view addSubview:mShowViewControll.view];
    
    arrayCollect = [[NSMutableArray alloc]init];
    NSData * data  = [[NSUserDefaults standardUserDefaults] valueForKey:COLLECT_LIST];
    if (data) {
        arrayCollect = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    if ([Utility containsObject:arrayCollect forKey:@"id" forValue:[dicPreInfo objectForKey:@"id"]]) {
        mShowViewControll.isStore = YES;
    }
    
    if (dicPreInfo) {
        [self request:[dicPreInfo objectForKey:@"id"]];
    }
    
    
    mTimeLog  = [NSTimer scheduledTimerWithTimeInterval:5*60 target:self selector:@selector(requestOnline) userInfo:nil repeats:YES];
    
    
}
-(void)requestOnline
{
    if (mResultDetail) {
        NSMutableDictionary * dic  = [[NSMutableDictionary alloc]init];
        [dic setValue:@"在线统计" forKey:@"DMec"];
        [dic setValue:@"直播" forKey:@"DMel"];
        NSString * string  = [NSString stringWithFormat:@"%@|%@|%@",mVideotitle,[mResultDetail objectForKey:@"id"],@"直播"];//标题|视频id|栏目
        [dic setValue:string forKey:@"DMeo"];
        [SHStatisticalData requestDmaevent:dic];
    }
}


-(void) request:(NSString *)videoID
{
    [mShowViewControll request:@"102349" gid:@"p4840"];// ad
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"Pad/liveinfo");
    [post.postArgs setValue:videoID forKey:@"id"];
    post.delegate = self;
    [post start:^(SHTask *t) {
        
        mResultDetail = [[t result]mutableCopy];
        mVideotitle = [mResultDetail objectForKey:@"title"];
        if (![[mResultDetail objectForKey:@"playurl"]isEqualToString:@""]) {
             mVideoUrl = [mResultDetail objectForKey:@"playurl"];
        }else if (![[mResultDetail objectForKey:@"playurl2"]isEqualToString:@""]) {
            mVideoUrl = [mResultDetail objectForKey:@"playurl2"];
        }else{
            mVideoUrl = @"";
        }
       
//     mVideoUrl = @"http://183.136.140.38/hd_hbws/z.m3u8";
        self.leftTitle = mVideotitle;
        NSURL * videoUrl = [NSURL URLWithString:[Utility encodeVideoUrl:mVideoUrl]];
        [mShowViewControll quicklyReplayMovie:videoUrl title:[mResultDetail objectForKey:@"title"] seekToPos:0];
        
        if (mDemandDetailViewControll==nil) {// 详情
            mDemandDetailViewControll = [[SHDemandDetailViewController alloc]init];
            mDemandDetailViewControll.view.frame = mViewContent.bounds;
        }
        mDemandDetailViewControll.detail = [mResultDetail mutableCopy];
      
        // 节目单
        for (int i = 0; i< mListPagesView.count; i++) {
            SHBillListViewController * viewControll = [mListPagesView objectAtIndex:i];
            //                viewControll.list = arrayBills;
            NSDate * date =[arrayDate objectAtIndex:i];
            [viewControll refreBill:[date stringWithFormat:@"yyyy-MM-dd"] detail:mResultDetail];
            
        }
        
        NSMutableDictionary * dic  = [[NSMutableDictionary alloc]init];
        [dic setValue:@"直播监测" forKey:@"DMec"];
        
        NSString * string  = [NSString stringWithFormat:@"%@|%@",mVideotitle,[mResultDetail objectForKey:@"id"]];//频道名称|频道ID|节目名称|节目ID
        [dic setValue:string forKey:@"DMel"];
        [dic setValue:[NSDate stringFromDate:[NSDate date] withFormat:@"HH"] forKey:@"DMeo"];
        [SHStatisticalData requestDmaevent:dic];
        
    } taskWillTry:^(SHTask *t) {
        
    } taskDidFailed:^(SHTask *t) {
        [t.respinfo show];
    }];
    
}
#pragma 日期
-(void) createDateView
{
    arrayLine = [[NSArray alloc]initWithObjects:@"-610",@"-525",@"-432",@"-334",@"-224",@"-121",@"-16", nil];
    arrayBtnDay = [[NSArray alloc]initWithObjects:mbtnDay1,mbtnDay2,mbtnDay3,mbtnDay4,mbtnDay5,mbtnDay6,mbtnDay7, nil];
    arrayDate =[[NSDate date] arrayNextSevenDay];
    NSArray * arrayWeek = @[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期天"];
    for (int i = 2; i< arrayDate.count; i++) {
        int today = [[NSDate date]dayOfWeek:[arrayDate objectAtIndex:i]];
        UIButton * button = [arrayBtnDay objectAtIndex:i];
        [button setTitle:[arrayWeek objectAtIndex:today-1] forState:UIControlStateNormal];
    }
}
/**
 节目单
 */
-(void) createBill
{
    pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                             navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                           options:nil];
    [pageVC removeFromParentViewController];
    pageVC.dataSource = self;
    pageVC.delegate   = self;
    mListPagesView = [NSMutableArray array];
    for (int i = 0; i<7; i++) {
      SHBillListViewController*  mBillViewControll = [[SHBillListViewController alloc]init];
        mBillViewControll.tag = i;
//        NSDate * date =[arrayDate objectAtIndex:i];
//        [mBillViewControll refreBill:[date stringWithFormat:@"yyyy-MM-dd"] detail:mResultDetail];
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
-(void) showVideoControllerMenuDidSelct:(SHShowVideoViewController *)control sender:(UIButton *)sender tag:(int)tag
{
    
    [self changeRightViewContent:tag];
}
-(void) liveListDidSelect:(SHLiveListViewController*)controll info:(NSDictionary*)detail
{
    [self request:[detail objectForKey:@"id"]];
}
#pragma  菜单响应变化
-(void) changeRightViewContent:(int) index
{
    for (UIView * view in mViewContent.subviews) {
        [view removeFromSuperview];
    }
    switch (index) {
        case 1:// 剧集
            [mViewContent addSubview:mListViewControll.view];
            break;
        case 2:// 详情
            [mViewContent addSubview:mDemandDetailViewControll.view];
            break;
        case 3:// 下载
            
            break;
        case 4://收藏
            {
                if(!mResultDetail){
                    return;
                }
                
                if([Utility containsObject:arrayCollect forKey:@"id" forValue:[mResultDetail objectForKey:@"id"]]){// 取消收藏
                    mShowViewControll.isStore = NO;
                    [Utility removeObject:arrayCollect forKey:@"id" forValue:[mResultDetail objectForKey:@"id"]];
                }else{
                    mShowViewControll.isStore = YES;
                    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
                    [dic setValue:[mResultDetail objectForKey:@"id"] forKey:@"id"];
                    [dic setValue:mVideotitle forKey:@"title"];
                    [dic setValue:@"2" forKey:@"type"];// 直播2
                    [arrayCollect insertObject:dic atIndex:0];
                    if (arrayCollect.count>50) {
                        [arrayCollect removeObjectAtIndex:arrayCollect.count-1];
                    }
                }
                NSData * data = [NSKeyedArchiver archivedDataWithRootObject:arrayCollect];
                [[NSUserDefaults standardUserDefaults ] setValue:data forKey:COLLECT_LIST];
                [[NSUserDefaults standardUserDefaults]synchronize];
            
            }
         
            break;
            
        default:
            break;
    }
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
    [pageVC setViewControllers: @[[mListPagesView   objectAtIndex:sender.tag] ] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:^(BOOL finished) {
        
        NSLog(@"xxxxxxx");
    } ];
}
@end
