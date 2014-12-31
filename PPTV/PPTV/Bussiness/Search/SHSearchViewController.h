//
//  SHSearchViewController.h
//  PPTV
//
//  Created by yebaohua on 14/11/30.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"

@interface SHSearchViewController : SHTableViewController<SHTaskDelegate>
{
     __weak IBOutlet UISearchBar *mSearch;
    __weak IBOutlet UIView *mViewRecomend;
    __weak IBOutlet UIView *mViewRecord;
    NSMutableArray * mArrayRecord;
    NSMutableArray * mArrayRecomend;
}
- (IBAction)btnWatchRecordOntouch:(UIButton *)sender;
- (IBAction)btnDownloadOntouch:(UIButton *)sender;
- (IBAction)btnGoBack:(UIButton *)sender;
- (IBAction)btnClearOntouch:(id)sender;
@end
