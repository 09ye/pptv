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

@interface SHHomeViewController ()

@end

@implementation SHHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    mDictionary = [[NSMutableDictionary alloc]init];
    
    [self tabBar:tabbar didSelectItem:[[tabbar items] objectAtIndex:0]];
    tabbar.selectedItem = [tabbar.items objectAtIndex:0];
    tabbar.barTintColor = [[UIColor alloc]initWithRed:38/255 green:38/255 blue:38/255 alpha:1];
    tabbar.selectedImageTintColor = [SHSkin.instance colorOfStyle:@"ColorTextBlue"];
    
    
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
        nacontroller =[ mDictionary valueForKey:@"SHChannelListViewController"];
        if(!nacontroller){
            SHChannelListViewController * viewcontroller = [[SHChannelListViewController alloc]init];
            nacontroller = viewcontroller;
            [mDictionary setValue:nacontroller forKey:@"SHChannelListViewController"];
        }
    }
    
    if(lastnacontroller != nacontroller){
        nacontroller.view.frame = mViewContain.bounds;
        ((SHRecommendViewController*)nacontroller).navController = self.navigationController;
        nacontroller.view.backgroundColor =[UIColor clearColor];
        [mViewContain addSubview:nacontroller.view];
        [lastnacontroller.view removeFromSuperview];
        lastnacontroller = nacontroller;
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
