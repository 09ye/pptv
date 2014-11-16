//
//  SHLoginViewController.h
//  zyj_businesstreasure
//
//  Created by yebaohua on 14/10/30.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"

@interface SHLoginViewController : SHTableViewController<SHTaskDelegate>
{
    __weak IBOutlet UITextField *mTxtPhone;
    
    __weak IBOutlet UITextField *mTxtPassword;
    __weak IBOutlet UIButton *mBtnLogin;
}
- (IBAction)btnLoginOntouch:(id)sender;
- (IBAction)btnForgetPassOntouch:(id)sender;

@end
