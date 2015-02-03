//
//  SHAboutViewController.m
//  PPTV
//
//  Created by yebaohua on 14/12/20.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHAboutViewController.h"

@interface SHAboutViewController ()

@end

@implementation SHAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [SHSkin.instance colorOfStyle:@"ColorBackGroundRightView"];
    self.title = @"关于我们";
    [SHStatisticalData requestDmalog:self.title];
    mScrollview.layer.cornerRadius= 5;
    mTitle.text = [NSString stringWithFormat:@"华数TV    HD版    V%@",SHEntironment.instance.version.description];
    
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
