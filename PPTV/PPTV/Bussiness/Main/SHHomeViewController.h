//
//  SHHomeViewController.h
//  PPTV
//
//  Created by yebaohua on 14/11/16.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"

@interface SHHomeViewController : SHTableViewController<UISearchBarDelegate>
{
    __weak IBOutlet UIView *mViewContain;

    NSMutableDictionary* mDictionary;
    SHTableViewController* lastnacontroller;
    __weak IBOutlet UISearchBar *mSearch;
   
}

@property (weak, nonatomic) IBOutlet UIView *viewTitleBar;
@property (weak, nonatomic) IBOutlet UITabBar *tabbar;
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item; // called when a new view is selected by the user (but not programatically)
- (IBAction)btnWatchRecordOntouch:(UIButton *)sender;
- (IBAction)btnDownloadOntouch:(UIButton *)sender;
@end
