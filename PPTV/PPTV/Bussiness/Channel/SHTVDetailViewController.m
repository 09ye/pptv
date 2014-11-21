//
//  SHTVDetailViewController.m
//  PPTV
//
//  Created by yebaohua on 14/11/19.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTVDetailViewController.h"

@interface SHTVDetailViewController ()

@end

@implementation SHTVDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    AppDelegate* app=(AppDelegate*)[UIApplication sharedApplication].delegate;
   
//        [mShowViewControll showIn:app.viewController.view];
//    [self.view addSubview:mShowViewControll.view];
//     [self.navigationController pushViewController:mShowViewControll animated:YES];

}
-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    mShowViewControll = [[SHShowVideoViewController alloc]init];
    mShowViewControll.delegate = self;
    mShowViewControll.videoTitle = @"xxx";
    mShowViewControll.videoUrl = @"http://hot.vrs.sohu.com/ipad1407291_4596271359934_4618512.m3u8";
    mShowViewControll.view.frame = CGRectMake(0, 5,710, 500);
     [self.view addSubview:mShowViewControll.view];
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
