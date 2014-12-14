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
    self.view.backgroundColor = [UIColor clearColor];
}
-(void) setDetail:(NSMutableDictionary *)detail_
{
    _detail = detail_;
    UILabel *labTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 290, 45)];
    labTitle.numberOfLines = 0;
    labTitle.text = [detail_ objectForKey:@"title"];
    labTitle.textColor = [UIColor whiteColor];
    [labTitle sizeToFit];
    [self.view addSubview:labTitle];
    
    UILabel *labArea = [[UILabel alloc]initWithFrame:CGRectMake(10, labTitle.frame.origin.y+labTitle.frame.size.height+5, 290, 45)];
    labArea.numberOfLines = 0;
    labArea.text = [NSString stringWithFormat:@"地区:%@",[detail_ objectForKey:@"area"]];
    labArea.textColor = [UIColor grayColor];
    [labArea sizeToFit];
    [self.view addSubview:labArea];
    
    UILabel *labType = [[UILabel alloc]initWithFrame:CGRectMake(10, labArea.frame.origin.y+labArea.frame.size.height+5, 290, 45)];
    labType.numberOfLines = 0;
    labType.text = [NSString stringWithFormat:@"类型:%@  %@",[detail_ objectForKey:@"pname"],[detail_ objectForKey:@"cname"]];
    labType.textColor = [UIColor grayColor];
    [labType sizeToFit];
    [self.view addSubview:labType];
    
    UILabel *labDirector = [[UILabel alloc]initWithFrame:CGRectMake(10, labType.frame.origin.y+labType.frame.size.height+5, 290, 45)];
    labDirector.numberOfLines = 0;
    labDirector.text = [NSString stringWithFormat:@"导演:%@",[detail_ objectForKey:@"director"]];
    labDirector.textColor = [UIColor grayColor];
    [labDirector sizeToFit];
    [self.view addSubview:labDirector];
    
    UILabel *labActor = [[UILabel alloc]initWithFrame:CGRectMake(10, labDirector.frame.origin.y+labDirector.frame.size.height+5, 290, 45)];
    labActor.numberOfLines = 0;
    labActor.text = [NSString stringWithFormat:@"主演:%@",[detail_ objectForKey:@"actor"]];
    labActor.textColor = [UIColor grayColor];
    [labActor sizeToFit];
    [self.view addSubview:labActor];
    
    UILabel *labAbstract = [[UILabel alloc]initWithFrame:CGRectMake(10, labActor.frame.origin.y+labActor.frame.size.height+15, 290, 45)];
    labAbstract.numberOfLines = 0;
    labAbstract.text = [NSString stringWithFormat:@"简介:%@",[detail_ objectForKey:@"abstract"]];
    labAbstract.textColor = [UIColor grayColor];
    [labAbstract sizeToFit];
    [self.view addSubview:labAbstract];
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
