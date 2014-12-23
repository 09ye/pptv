//
//  SHDemandDetailViewController.m
//  PPTV
//
//  Created by yebaohua on 14/12/14.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHDemandDetailViewController.h"

@interface SHDemandDetailViewController ()

@end

@implementation SHDemandDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [SHSkin.instance colorOfStyle:@"ColorBaseBlack"];
}
-(void) setDetail:(NSMutableDictionary *)detail_
{
    _detail = detail_;
    for (UIView * view in self.view.subviews) {
        [view removeFromSuperview];
    }
    UILabel *labTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 290, 45)];
    labTitle.numberOfLines = 0;
    labTitle.text = [detail_ objectForKey:@"title"];
    labTitle.font = [UIFont systemFontOfSize:17];
    labTitle.userstyle = @"labmidwhite";
    [labTitle sizeToFit];
    [self.view addSubview:labTitle];
    CGRect  lastRect = labTitle.frame;
    
    if ([detail_.allKeys containsObject:@"live_abstract"]) {// 直播详情
        UILabel *labAbstract = [[UILabel alloc]initWithFrame:CGRectMake(10, lastRect.origin.y+lastRect.size.height+15, 290, 45)];
        labAbstract.numberOfLines = 0;
        labAbstract.text = [NSString stringWithFormat:@"简介:%@",[detail_ objectForKey:@"live_abstract"]];
        labAbstract.textColor = [UIColor grayColor];
        [labAbstract sizeToFit];
        [self.view addSubview:labAbstract];
    }else{
        NSArray * item = [_detail objectForKey:@"item"];
        
        for(int i = 0 ;i< item.count;i++){
            UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, lastRect.origin.y+lastRect.size.height+5, 290, 45)];
            lable.numberOfLines = 0;
            lable.text = [item objectAtIndex:i];
            lable.textColor = [UIColor grayColor];
            [lable sizeToFit];
            lastRect = lable.frame;
            [self.view addSubview:lable];
        }
        UILabel *labAbstract = [[UILabel alloc]initWithFrame:CGRectMake(10, lastRect.origin.y+lastRect.size.height+15, 290, 45)];
        labAbstract.numberOfLines = 0;
        labAbstract.text = [NSString stringWithFormat:@"简介:%@",[detail_ objectForKey:@"abstract"]];
        labAbstract.textColor = [UIColor grayColor];
        [labAbstract sizeToFit];
        [self.view addSubview:labAbstract];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
