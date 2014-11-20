//
//  SHChannelListViewController.h
//  PPTV
//
//  Created by yebaohua on 14/11/19.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"
#import "SHFilterView.h"

@interface SHChannelListViewController : SHTableViewController
{
    SHFilterView * mFilterView;
}
@property(nonatomic,retain) UINavigationController *navController; // If this view controller has been pushed onto a navigation controller, return it.
- (IBAction)btnShowSearchOntouch:(UIButton *)sender;
@end
