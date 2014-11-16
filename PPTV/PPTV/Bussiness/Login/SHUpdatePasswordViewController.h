//
//  SHUpdatePasswordViewController.h
//  zyj_businesstreasure
//
//  Created by yebaohua on 14/10/30.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"

@interface SHUpdatePasswordViewController : SHTableViewController<SHTaskDelegate>
{
    __weak IBOutlet UITextField *mTxtOldPass;
    __weak IBOutlet UITextField *mTxtNewPass1;
    __weak IBOutlet UITextField *mTxtNewPass2;
    __weak IBOutlet UIButton *mBtnComfrie;
}
- (IBAction)btnComfrieOntouch:(id)sender;

@end
