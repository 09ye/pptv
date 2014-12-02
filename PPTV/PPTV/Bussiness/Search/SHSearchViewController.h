//
//  SHSearchViewController.h
//  PPTV
//
//  Created by yebaohua on 14/11/30.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"

@interface SHSearchViewController : SHTableViewController
{
     __weak IBOutlet UISearchBar *mSearch;
}
- (IBAction)btnWatchRecordOntouch:(UIButton *)sender;
- (IBAction)btnDownloadOntouch:(UIButton *)sender;
- (IBAction)btnGoBack:(UIButton *)sender;
@end
