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
    // 引导页
    [self  showGuidePage] ;
    // Do any additional setup after loading the view from its nib.

}

-(void)bootSetting{
    
    UINavigationController * nacontroller = [[UINavigationController alloc]initWithRootViewController: [[SHLoginViewController alloc ] init]];
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil];
    [nacontroller.navigationBar setTitleTextAttributes:attributes];
    nacontroller.navigationBar.translucent = NO;
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
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
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


@end
