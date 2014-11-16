//
//  SHLoginViewController.m
//  zyj_businesstreasure
//
//  Created by yebaohua on 14/10/30.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHLoginViewController.h"


@interface SHLoginViewController ()

@end

@implementation SHLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    mBtnLogin.layer.cornerRadius = 5;
    self.title = @"商户宝";
}

- (IBAction)btnLoginOntouch:(id)sender {

    
//     [self presentModalViewController:[[SHHomeMainViewController alloc]init]  animated:YES];
    
}

- (IBAction)btnForgetPassOntouch:(id)sender {
        SHIntent * intent = [[SHIntent alloc]init];
        intent.target = @"SHUpdatePasswordViewController";
        intent.container = self.navigationController;
        [[UIApplication sharedApplication]open:intent];
}
@end
