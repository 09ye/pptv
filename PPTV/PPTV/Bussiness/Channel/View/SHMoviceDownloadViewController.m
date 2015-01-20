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
  
    if (![[urls objectForKey:@"hd0"] isEqualToString:@""]) {
        
        [mbtn1 setTitle:@"流畅(320P)" forState:UIControlStateNormal];
        mbtn1.hidden = NO;
    }
    if (![[urls objectForKey:@"hd1"] isEqualToString:@""]) {
        if(mbtn1.hidden){
            [mbtn1 setTitle:@"高清(480P)" forState:UIControlStateNormal];
            mbtn1.hidden = NO;
        }else{
            [mbtn2 setTitle:@"高清(480P)" forState:UIControlStateNormal];
            mbtn2.hidden = NO;
        }
        
        
    }
    if (![[urls objectForKey:@"hd2"] isEqualToString:@""]) {
        if(mbtn1.hidden){
            [mbtn1 setTitle:@"超清(720P)" forState:UIControlStateNormal];
            mbtn1.hidden = NO;
        }else if(mbtn2.hidden){
            [mbtn2 setTitle:@"超清(720P)" forState:UIControlStateNormal];
            mbtn2.hidden = NO;
        }else if(mbtn3.hidden){
            [mbtn3 setTitle:@"超清(720P)" forState:UIControlStateNormal];
            mbtn3.hidden = NO;
        }
        
    }
   
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)btnDownloadOntouch:(UIButton *)sender {
    
//    [self showAlertDialog:@"成功添加至离线观看"];
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
    int  hdType = 0;
    if ([sender.titleLabel.text isEqualToString:@"流畅(320P)"]) {
        hdType = 0;
    }else if ([sender.titleLabel.text isEqualToString:@"高清(480P)"]) {
        hdType = 1;
    }else if ([sender.titleLabel.text isEqualToString:@"超清(720P)"]) {
        hdType = 2;
    }
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setValue:[self.detail objectForKey:@"title"] forKey:@"title"];
    [dic setValue:[self.detail objectForKey:@"id"] forKey:@"id"];
    [dic setValue:[self.detail objectForKey:@"pic"] forKey:@"pic"];
    [dic setValue:url forKey:@"url"];
    AppDelegate* app=(AppDelegate*)[UIApplication sharedApplication].delegate;
    [app beginRequest:[[self.detail objectForKey:@"id"]intValue] hdType:hdType isCollection:NO isBeginDown:YES];
}
@end
