//
//  SHMainViewController.h
//  crowdfunding-arcturus
//
//  Created by WSheely on 14-4-8.
//  Copyright (c) 2014年 WSheely. All rights reserved.
//

#import "SHViewController.h"
#import "SHLoginViewController.h"


@interface MainViewController : SHViewController <UITabBarDelegate,SHTaskDelegate>
{

    UINavigationController* lastnacontroller;
    SHLoginViewController* loginViewController;
    NSMutableDictionary * mDicViewController;

}
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item; // called when a new view is selected by the user (but not programatically)

@end
