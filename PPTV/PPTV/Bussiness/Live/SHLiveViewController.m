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
    
    [self createDateView];
    [self createBill];
    
    mListViewControll = [[SHLiveListViewController alloc]init];
    mListViewControll.view.frame = mViewContent.bounds;
    mListViewControll.delegate = self;
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
    
    arrayCollect = [[NSMutableArray alloc]init];
    NSData * data  = [[NSUserDefaults standardUserDefaults] valueForKey:COLLECT_LIST];
    if (data) {
        arrayCollect = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    if ([arrayCollect containsObject:dicPreInfo]) {
        mShowViewControll.isStore = YES;
    }
    
//    [mListViewControll.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    if (dicPreInfo) {
        [self request:[[dicPreInfo objectForKey:@"id"]intValue]];
    }
    
    
    
}


-(void) request:(NSInteger)videoID
{
    
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"Pad/liveinfo");
    [post.postArgs setValue:[NSNumber numberWithInt:videoID] forKey:@"id"];
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
       

        self.leftTitle = mVideotitle;
        NSURL * videoUrl = [NSURL URLWithString:mVideoUrl];
        [mShowViewControll quicklyReplayMovie:videoUrl title:[mResultDetail objectForKey:@"title"] seekToPos:0];
        
        if (mDemandDetailViewControll==nil) {// 详情
            mDemandDetailViewControll = [[SHDemandDetailViewController alloc]init];
            mDemandDetailViewControll.view.frame = mViewContent.bounds;
        }
        mDemandDetailViewControll.detail = [mResultDetail mutableCopy];
      
        
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
    [self request:[[detail objectForKey:@"id"]intValue]];
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
                if(!dicPreInfo){
                    return;
                }
                if([arrayCollect containsObject:dicPreInfo]){// 取消收藏
                    mShowViewControll.isStore = NO;
                    [arrayCollect removeObject:dicPreInfo];
                }else{
                    mShowViewControll.isStore = YES;
                    [arrayCollect addObject:dicPreInfo];
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
