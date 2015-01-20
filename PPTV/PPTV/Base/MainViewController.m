//
//  SHMainViewController.m
//  crowdfunding-arcturus
//
//  Created by WSheely on 14-4-8.
//  Copyright (c) 2014年 WSheely. All rights reserved.
//
#import "MainViewController.h"
#import "SHGuideViewController.h"
#import <MediaPlayer/MediaPlayer.h>


@interface MainViewController ()<SHGuideViewControllerDelegate>
{
    
    SHGuideViewController  *guideVC;
    MPMoviePlayerViewController* playerViewController;
    NSDictionary *mAdVideo;
}

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     homeViewController = [[SHHomeViewController alloc ] init];
    [self requestAd];
    
    // 引导页
    [self  showGuidePage] ;
    // Do any additional setup after loading the view from its nib.
    
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"Pad/listcategory");
    post.cachetype = CacheTypeTimes;
    post.delegate = self;
    [post start:^(SHTask *task) {
        self.listCategory = [[task result]mutableCopy];
    } taskWillTry:^(SHTask *task) {
        
    } taskDidFailed:^(SHTask *task) {
        
    }];
   
}

-(NSNumber *) categoryForKey:(NSString *) key defaultPic:(int)defaultPic
{
    for(NSDictionary *dic in self.listCategory){
        if ([[dic objectForKey:@"name"] caseInsensitiveCompare:key] == NSOrderedSame) {
            return [NSNumber numberWithInt:[[dic objectForKey:@"id"]intValue]];
        }
    }
    return defaultPic?[NSNumber numberWithInt:defaultPic]:[NSNumber numberWithInt:1];
}
-(void)bootSetting{
    
   
    UINavigationController * nacontroller = [[UINavigationController alloc]initWithRootViewController:homeViewController];
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil];
    [nacontroller.navigationBar setTitleTextAttributes:attributes];
    nacontroller.navigationBar.translucent = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    nacontroller.navigationBar.tintColor = [UIColor whiteColor];
    if(!iOS7){
        nacontroller.navigationBar.clipsToBounds = YES;
    }
    nacontroller.navigationBar.barTintColor = [SHSkin.instance colorOfStyle:@"ColorBase"];
    nacontroller.view.frame =  self.view.bounds;
    [self.view addSubview:nacontroller.view];
    [self addChildViewController:nacontroller];
    
    
}

#pragma  mark  引导页加载

-(void)showGuidePage {
    //判断是否出现引导页
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        
    }
    else{
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
        
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]&& false) {
        // 这里判断是否第一次
        guideVC=[[SHGuideViewController alloc]  init];
        guideVC.delegate=self;
        [self.view addSubview:guideVC.view];
        return  ;
        
    }else{
        
        [self bootSetting];
        
    }
   
}
-(void) guideViewController:(SHGuideViewController *)aguidVC viewClosed:(int)viewClosed{
    
    
    [guideVC.view   removeFromSuperview];
    
    [self bootSetting];
    
    
}
-(void)hideTarbar:(BOOL)value{

    if (!isFirst) {
        rectTabBar = homeViewController.tabbar.frame;
    }
    isFirst = true;
    [UIView animateWithDuration:0.5 animations:^{
       
        if(value){
            homeViewController.tabbar.alpha = 0;
            homeViewController.tabbar.frame = CGRectMake( homeViewController.tabbar.frame.origin.x, UIScreenHeight, homeViewController.tabbar.frame.size.width, homeViewController.tabbar.frame.size.height);
        }else{
            homeViewController.tabbar.hidden = NO;
            homeViewController.tabbar.alpha = 0.7;
            homeViewController.tabbar.frame = rectTabBar;
            
        }

    } completion:^(BOOL finished) {
         homeViewController.tabbar.hidden = value;
    }];
   
}
-(UIView*) hideSearchView:(BOOL)value
{
   
    [UIView animateWithDuration:0.5 animations:^{
        
        if(value){
            homeViewController.viewTitleBar.alpha = 0;
            homeViewController.viewTitleBar.frame = CGRectMake( 0, -homeViewController.viewTitleBar.frame.size.height, homeViewController.viewTitleBar.frame.size.width, homeViewController.viewTitleBar.frame.size.height);
        }else{
            homeViewController.viewTitleBar.hidden = NO;
            homeViewController.viewTitleBar.alpha = 0.9;
            homeViewController.viewTitleBar.frame = CGRectMake( 0, 0, homeViewController.viewTitleBar.frame.size.width, homeViewController.viewTitleBar.frame.size.height);
            
        }
        
    } completion:^(BOOL finished) {
         homeViewController.viewTitleBar.hidden = value;
    }];
   return  homeViewController.viewTitleBar;
}
#pragma  ads
-(void)requestAd
{
    SHPostTask *post  = [[SHPostTask alloc]init];
    post.URL = URL_ADS;
    NSData * data = [@"aid=101525&fmt=json&ver=1&m=1" dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    post.postData = data;
    [post.postHeader setValue:@"1" forKey:@"m"];
    post.delegate = self;
    [post start:^(SHTask *task) {
        NSDictionary * dic = [[task result]mutableCopy];
        if([[dic allKeys]containsObject:@"ad"]){
            NSArray * ads = [dic objectForKey:@"ad"];
            if (ads.count>0) {
                NSArray *adarray = [[ads objectAtIndex:0]objectForKey:@"creative"];
                if (adarray.count>0) {
                    mAdVideo= [adarray objectAtIndex:0];
                    NSArray * mediafiles = [mAdVideo objectForKey:@"mediafiles"];
                    if (mediafiles.count>0) {
                        NSString * url = [[mediafiles objectAtIndex:0]objectForKey:@"url"];
                        [self playMovie:url];
                        
                    }else{
                        [self  bootSetting];
                    }
                    
                }else{
                    [self  bootSetting];
                }
            }else{
                [self  bootSetting];
            }
        }else{
            [self  bootSetting];
        }
        
        
    } taskWillTry:^(SHTask *task) {
        
    } taskDidFailed:^(SHTask *task) {
        [self  bootSetting];
    }];
    
}
-(void)playMovie:(NSString *)fileName{
    
    NSURL *url = [NSURL URLWithString:fileName];
    playerViewController =[[MPMoviePlayerViewController alloc]     initWithContentURL:url];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playVideoFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:[playerViewController moviePlayer]];
    playerViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self.view addSubview:playerViewController.view];

    MPMoviePlayerController *player = [playerViewController moviePlayer];
    player.movieSourceType = MPMovieSourceTypeFile;
    player.shouldAutoplay = YES;
    [player setControlStyle:MPMovieControlStyleNone];
    [player setFullscreen:YES];
    player.scalingMode = MPMovieScalingModeFill;
    NSTimeInterval length = [player duration];
    NSLog(@"%f",length);
    [player.view setFrame:self.view.bounds];
    [player prepareToPlay];
    [player play];
    
    // 倒计时时间
    
}

#pragma mark -------------------视频播放结束委托--------------------

/*
 @method 当视频播放完毕释放对象
 */
- (void) playVideoFinished:(NSNotification *)theNotification//当点击Done按键或者播放完毕时调用此函数
{
    MPMoviePlayerController *player = [theNotification object];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:player];
    [player stop];
    [playerViewController.view removeFromSuperview];
    [self  bootSetting];
    
}
@end
