//
//  SHMoviceDownloadViewController.h
//  PPTV
//
//  Created by yebaohua on 14/12/23.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"

@interface SHMoviceDownloadViewController : SHTableViewController
{
    
    __weak IBOutlet UIButton *mbtn1;
    __weak IBOutlet UIButton *mbtn2;
    __weak IBOutlet UIButton *mbtn3;
}



@property (nonatomic,strong) NSMutableDictionary * detail;
- (IBAction)btnDownloadOntouch:(UIButton *)sender;
@end
