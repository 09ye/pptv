//
//  SHHomeViewController.h
//  PPTV
//
//  Created by yebaohua on 14/11/16.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"

@interface SHHomeViewController : SHTableViewController
{
    __weak IBOutlet UIView *mViewContain;
    __weak IBOutlet UITabBar *tabbar;
    NSMutableDictionary* mDictionary;
    SHTableViewController* lastnacontroller;
}
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item; // called when a new view is selected by the user (but not programatically)
@end
