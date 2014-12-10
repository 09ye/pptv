//
//  SHMainViewController.m
//  crowdfunding-arcturus
//
//  Created by WSheely on 14-4-8.
//  Copyright (c) 2014年 WSheely. All rights reserved.
//
#import "MainViewController.h"
#import "SHGuideViewController.h"


@interface MainViewController ()<SHGuideViewControllerDelegate>
{
    
    SHGuideViewController  *guideVC;
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
    
    // 引导页
    [self  showGuidePage] ;
    // Do any additional setup after loading the view from its nib.
   
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
@end
