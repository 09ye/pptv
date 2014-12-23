//
//  SHRecordViewController.m
//  PPTV
//
//  Created by yebaohua on 14/12/13.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHRecordViewController.h"

@interface SHRecordViewController ()

@end

@implementation SHRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"播放记录";
    self.view.backgroundColor = [SHSkin.instance colorOfStyle:@"ColorBackGroundRightView"];
    self.tableView.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
