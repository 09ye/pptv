//
//  SHMoviceDownloadViewController.m
//  PPTV
//
//  Created by yebaohua on 14/12/23.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHMoviceDownloadViewController.h"

@interface SHMoviceDownloadViewController ()

@end

@implementation SHMoviceDownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [SHSkin.instance colorOfStyle:@"ColorBaseBlack"];
    // Do any additional setup after loading the view from its nib.
}

-(void) setDetail:(NSMutableDictionary *)detail_
{
    NSDictionary *urls = [detail_ objectForKey:@"vods"];
    NSArray *keys = urls.allKeys;
    for (int i = 0; i< keys.count; i++) {
        if (![[urls objectForKey:[keys objectAtIndex:i]] isEqualToString:@""]) {

            
        }
    }
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
