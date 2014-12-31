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
@synthesize detail = _detail;
- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [SHSkin.instance colorOfStyle:@"ColorBaseBlack"];
    mbtn1.layer.cornerRadius = 5;
    mbtn2.layer.cornerRadius = 5;
    mbtn3.layer.cornerRadius = 5;
    // Do any additional setup after loading the view from its nib.
}

-(void) setDetail:(NSMutableDictionary *)detail_
{
    _detail = detail_;
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



- (IBAction)btnDownloadOntouch:(UIButton *)sender {
    
    [self showAlertDialog:@"成功添加至离线观看"];
    NSString * url = @"";
    NSDictionary *vods =[self.detail objectForKey:@"vods"];
    switch (sender.tag) {
        case 0:
            [mbtn1 setTitleColor:[SHSkin.instance colorOfStyle:@"ColorTextOrg"] forState:UIControlStateNormal];
            [mbtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [mbtn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            url = [vods objectForKey:@"hd0"];
            break;
        case 1:
            [mbtn2 setTitleColor:[SHSkin.instance colorOfStyle:@"ColorTextOrg"] forState:UIControlStateNormal];
            [mbtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [mbtn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            url = [vods objectForKey:@"hd1"];
            break;
        case 2:
            [mbtn3 setTitleColor:[SHSkin.instance colorOfStyle:@"ColorTextOrg"] forState:UIControlStateNormal];
            [mbtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [mbtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            url = [vods objectForKey:@"hd2"];
            break;
            
        default:
            break;
    }
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setValue:[self.detail objectForKey:@"title"] forKey:@"title"];
    [dic setValue:[self.detail objectForKey:@"id"] forKey:@"id"];
    [dic setValue:[self.detail objectForKey:@"pic"] forKey:@"pic"];
    [dic setValue:url forKey:@"url"];
    AppDelegate* app=(AppDelegate*)[UIApplication sharedApplication].delegate;
    [app beginRequest:dic isBeginDown:YES];
}
@end
