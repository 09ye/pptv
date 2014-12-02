//
//  SHSearchViewController.m
//  PPTV
//
//  Created by yebaohua on 14/11/30.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHSearchViewController.h"

@interface SHSearchViewController ()

@end

@implementation SHSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [mSearch becomeFirstResponder];
}

- (IBAction)btnWatchRecordOntouch:(UIButton *)sender {
}

- (IBAction)btnDownloadOntouch:(UIButton *)sender {
}

- (IBAction)btnGoBack:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [mSearch resignFirstResponder];
    
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
