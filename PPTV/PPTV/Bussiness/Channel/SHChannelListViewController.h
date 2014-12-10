//
//  SHChannelListViewController.h
//  PPTV
//
//  Created by yebaohua on 14/11/19.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"
#import "SHFilterView.h"
#import "RadioBox.h"
#import "RadioGroup.h"

@interface SHChannelListViewController : SHTableViewController<SHTaskDelegate,EGORefreshTableHeaderDelegate>
{
    EGORefreshTableHeaderView* _refreshHeaderView;
    SHFilterView * mFilterView;
    __weak IBOutlet UIImageView *imgArrow;
}
@property(nonatomic,retain) UINavigationController *navController; // If this view controller has been pushed onto a navigation controller, return it.
@property (nonatomic,strong) NSString * type;//频道类型
@property (nonatomic,assign) int tag;//频道类型
- (IBAction)btnShowSearchOntouch:(UIButton *)sender;
- (IBAction)btnSelectMainOntouch:(UIButton *)sender;
@end
