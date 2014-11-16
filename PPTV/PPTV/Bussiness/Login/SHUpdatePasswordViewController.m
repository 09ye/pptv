//
//  SHUpdatePasswordViewController.m
//  zyj_businesstreasure
//
//  Created by yebaohua on 14/10/30.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHUpdatePasswordViewController.h"

@interface SHUpdatePasswordViewController ()

@end

@implementation SHUpdatePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"修改密码";
    mBtnComfrie.layer.cornerRadius = 5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)btnComfrieOntouch:(id)sender {
    if ([mTxtOldPass.text isEqualToString:@""]) {
        [self showAlertDialog:@"请输入原密码"];
        return;
    }
    if ([mTxtNewPass1.text isEqualToString:@""]) {
        [self showAlertDialog:@"请输入新密码"];
        return;
    }
    if (![mTxtNewPass2.text isEqualToString:mTxtNewPass1.text]) {
        [self showAlertDialog:@"两次输入新密码不一致，重新输入"];
        mTxtNewPass2.text = @"";
        return;
    }
}
@end
