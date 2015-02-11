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

@interface SHChannelListViewController : SHTableViewController<SHTaskDelegate,EGORefreshTableHeaderDelegate,RadioGroupDelegate>
{
    EGORefreshTableHeaderView* _refreshHeaderView;
    SHFilterView * mFilterView;
    __weak IBOutlet UIImageView *imgArrow;
    __weak IBOutlet UIButton *mbtnSelect1;
    __weak IBOutlet UIButton *mbtnSelect2;
    
//    int pageSize;
    int pagenum;
    
    NSMutableDictionary * mResult;
    AppDelegate* app;
    NSArray * mArrayFilter;
    NSMutableDictionary * mSelect;

}
@property(nonatomic,retain) UINavigationController *navController; // If this view controller has been pushed onto a navigation controller, return it.
@property (nonatomic,strong) NSDictionary * type;//频道类型 ["name":"电影"，“id”：“1”]
@property (nonatomic,assign)BOOL isHorizontal;// 横图显示 小图
- (IBAction)btnShowSearchOntouch:(UIButton *)sender;
- (IBAction)btnSelectMainOntouch:(UIButton *)sender;
@end
