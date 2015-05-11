
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
    NSDictionary *mAdVideo;
    int duration;
    NSTimer *mTimer ;
    UILabel * mlabCountdown;
    SHImageView * imgGuid;
    UIButton * mbtnClose;
    UIButton * mbtnWebView;
    bool isShow;//升级配置之后，加载界面只需加载一次，防止重复调升级接口，重复加载

    
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
    
    imgGuid  = [[SHImageView alloc]initWithFrame:self.view.bounds];
    imgGuid.image = [UIImage  imageNamed:@"default_guid"];

    [self.view addSubview:imgGuid];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configUpdate:) name:CORE_NOTIFICATION_CONFIG_STATUS_CHANGED object:nil];
   
    
    // 引导页
//    [self  showGuidePage] ;
    // Do any additional setup after loading the view from its nib.
    
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"Pad/listcategory");
    [post.postArgs setValue:SHEntironment.instance.version.description forKey:@"version"];
    post.cachetype = CacheTypeTimes;
    post.delegate = self;
    [post start:^(SHTask *task) {
        self.listCategory = [[task result]mutableCopy];
    } taskWillTry:^(SHTask *task) {
        
    } taskDidFailed:^(SHTask *task) {
        
    }];
}
// 升级接口成功返回信息后 才去展示界面
- (void)configUpdate:(NSObject*)sender
{
    if (!isShow) {
       [self requestAd];
//        isShow   = true;
    }
   
    
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
    NSString * stringPost  =[NSString stringWithFormat:@"aid=102357&fmt=json&ver=1&aw=%d&ah=%d",(int)UIScreenWidth,(int)UIScreenHeight];
    NSData * data = [stringPost dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
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
                    duration= [[mAdVideo objectForKey:@"duration"]intValue];
                    NSArray * mediafiles = [mAdVideo objectForKey:@"mediafiles"];
                    if (mediafiles.count>0) {
                        NSString * url = [[mediafiles objectAtIndex:0]objectForKey:@"url"];
                       
                        [self showGuidePng:url];
                        
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
-(void)showGuidePng:(NSString * )url
{
   
    [imgGuid setUrl:url];
  
    mlabCountdown  = [[UILabel alloc]initWithFrame:CGRectMake(900, 40, 40, 30)];
    mlabCountdown.layer.cornerRadius = 5;
    mlabCountdown.text = [NSString stringWithFormat:@"%d",duration];
    mlabCountdown.textAlignment = NSTextAlignmentCenter;
    mlabCountdown.textColor = [UIColor whiteColor];
    mlabCountdown.backgroundColor = [SHSkin.instance colorOfStyle:@"ColorStyleLight"];
    [self.view addSubview:mlabCountdown];
    mbtnWebView  = [[UIButton alloc]initWithFrame:self.view.bounds];
    [mbtnWebView addTarget:self action:@selector(btnGoWebView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mbtnWebView];
    mbtnClose = [[UIButton alloc]initWithFrame:CGRectMake(950, 32, 45, 45)];
    [mbtnClose setImage:[UIImage imageNamed:@"ic_lixian_delete.png"] forState:UIControlStateNormal];
    [mbtnClose addTarget:self action:@selector(btnCloseAd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mbtnClose];
    
     mTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(showGuidePngFinished:) userInfo:nil repeats:YES];

}
-(void)showGuidePngFinished:(NSTimer *)theTimer
{
    if (duration == 0) {
        SHImageView * image  = theTimer.userInfo ;
        [image removeFromSuperview];
        [mbtnClose removeFromSuperview];
        [mlabCountdown removeFromSuperview];
        [mbtnWebView removeFromSuperview];
        [mTimer invalidate];
        [self  bootSetting];
    }
  
    duration--;
    mlabCountdown.text = [NSString stringWithFormat:@"%d",duration];
}
-(void) btnCloseAd
{

    duration = 0;
}
-(void) btnGoWebView
{
    NSArray * mediafiles = [mAdVideo objectForKey:@"mediafiles"];
    if (mediafiles.count>0) {
        NSDictionary * dic = [mediafiles objectAtIndex:0];
        SHIntent *intent = [[SHIntent alloc]init];
        intent.target = @"WebViewController";
        [intent.args setValue:@"广告" forKeyPath:@"title"];
        [intent.args setValue:[dic objectForKey:@"value"] forKeyPath:@"url"];
        [intent.args setValue:dic forKeyPath:@"detailInfo"];
        [[UIApplication sharedApplication]open:intent];
    }
    
}

@end
