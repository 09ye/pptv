//
//  SHCollectViewController.h
//  PPTV
//
//  Created by yebaohua on 14/12/13.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHViewController.h"

@interface SHCollectViewController : SHTableViewController
{
    __weak IBOutlet UIView *mViewDelete;
    NSMutableArray * mArraySelect;
    
}
- (IBAction)btnDeleteOntouch:(id)sender;
- (IBAction)btnClearAllOntouch:(id)sender;
- (IBAction)btnCancaleOntouch:(id)sender;

@end
