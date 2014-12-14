//
//  SHHomeViewController.h
//  PPTV
//
//  Created by yebaohua on 14/11/16.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"
#import "SHShowRightView.h"

@interface SHHomeViewController : SHTableViewController<UISearchBarDelegate>
{
    __weak IBOutlet UIView *mViewContain;

    NSMutableDictionary* mDictionary;
    SHTableViewController* lastnacontroller;
    __weak IBOutlet UISearchBar *mSearch;
    
     BOOL mIsShow;
     int lastMoreTag;
    
     IBOutlet UIView *mViewMore;
     IBOutlet UIView *mViewMoreContent;
   
    __weak IBOutlet UIButton *btnOration;
    __weak IBOutlet UIButton *btnOriginal;
    __weak IBOutlet UIButton *btnEntertainment;
    __weak IBOutlet UIButton *btnLife;
    __weak IBOutlet UIButton *btnCar;
    __weak IBOutlet UIButton *btnSports;
    __weak IBOutlet UIButton *btnTravel;
    __weak IBOutlet UIButton *btnMicroShow;
    
    NSArray * arrayBtn;
    SHShowRightView *mViewRight;
    

}

@property (weak, nonatomic) IBOutlet UIView *viewTitleBar;
@property (weak, nonatomic) IBOutlet UITabBar *tabbar;
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item; // called when a new view is selected by the user (but not programatically)
- (IBAction)btnWatchRecordOntouch:(UIButton *)sender;
- (IBAction)btnDownloadOntouch:(UIButton *)sender;

- (IBAction)btnCloseOnTouch:(id)sender;

- (IBAction)btnMoreOntouch:(UIButton *)sender;
- (void)showIn:(CGRect) rect;

- (void)close;
@end
