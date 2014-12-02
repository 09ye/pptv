//
//  SHHomeViewController.m
//  PPTV
//
//  Created by yebaohua on 14/11/16.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHHomeViewController.h"
#import "SHRecommendViewController.h"
#import "SHChannelListViewController.H"
#import "SHLiveViewController.h"

@interface SHHomeViewController ()

@end

@implementation SHHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    mDictionary = [[NSMutableDictionary alloc]init];
    
    [self tabBar:self.tabbar didSelectItem:[[self.tabbar items] objectAtIndex:0]];
    self.tabbar.selectedItem = [self.tabbar.items objectAtIndex:0];
    self.tabbar.barTintColor = [[UIColor alloc]initWithRed:38/255 green:38/255 blue:38/255 alpha:1];
    self.tabbar.selectedImageTintColor = [SHSkin.instance colorOfStyle:@"ColorTextBlue"];
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    SHTableViewController * nacontroller;
    if(item.tag == 0){
        nacontroller =[ mDictionary valueForKey:@"SHRecommendViewController"];
        if(!nacontroller){
            SHRecommendViewController * viewcontroller = [[SHRecommendViewController alloc]init];
            nacontroller = viewcontroller;
            [mDictionary setValue:nacontroller forKey:@"SHRecommendViewController"];
        }
    }else if (item.tag == 1){
        nacontroller =[ mDictionary valueForKey:@"SHLiveViewController"];
        if(!nacontroller){
            SHLiveViewController * viewcontroller = [[SHLiveViewController alloc]init];
            nacontroller = viewcontroller;
            [mDictionary setValue:nacontroller forKey:@"SHLiveViewController"];
        }
    }else if (item.tag == 2){
        nacontroller =[ mDictionary valueForKey:@"SHChannelListViewController"];
        if(!nacontroller){
            SHChannelListViewController * viewcontroller = [[SHChannelListViewController alloc]init];
            nacontroller = viewcontroller;
            [mDictionary setValue:nacontroller forKey:@"SHChannelListViewController"];
        }
    }
    
    if(lastnacontroller != nacontroller){
      
        ((SHRecommendViewController*)nacontroller).navController = self.navigationController;
        nacontroller.view.backgroundColor =[UIColor clearColor];
        if(item.tag == 0){
            nacontroller.view.frame = self.view.bounds;
            mViewContain.hidden = YES;
            [self.view insertSubview:nacontroller.view atIndex:0];
        }else{
            nacontroller.view.frame = mViewContain.bounds;
            mViewContain.hidden = NO;
            [mViewContain addSubview:nacontroller.view];
        }
        
        
        [lastnacontroller.view removeFromSuperview];
        lastnacontroller = nacontroller;
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnWatchRecordOntouch:(UIButton *)sender {
}

- (IBAction)btnDownloadOntouch:(UIButton *)sender {
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    SHIntent * intent = [[SHIntent alloc]init];
    intent.target = @"SHSearchViewController";
    intent.container = self.navigationController;
    [[UIApplication sharedApplication]open:intent];
    return NO;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
     [mSearch resignFirstResponder];
    
}

@end
