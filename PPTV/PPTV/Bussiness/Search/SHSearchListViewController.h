//
//  SHSearchListViewController.h
//  PPTV
//
//  Created by Ye Baohua on 15/1/10.
//  Copyright (c) 2015年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"

@interface SHSearchListViewController : SHTableViewController<SHTaskDelegate>
{
    __weak IBOutlet UISearchBar *mSearch;
    IBOutlet UIView *mViewSection2;
    __weak IBOutlet UIButton *mbtnLast;
    __weak IBOutlet UIButton *mbtnMore;
    __weak IBOutlet UIButton *mbtnResultShort;
    IBOutlet UITableViewCell *mCellSeeMore;
}
- (IBAction)btnGoBack:(UIButton *)sender;
- (IBAction)btnSelectMainOntouch:(UIButton *)sender;
- (IBAction)btnSeeMoreOntouch:(id)sender;
@end
