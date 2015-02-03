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
    [SHStatisticalData requestDmalog:@"搜索"];
    mSearch.text = [self.intent.args objectForKey:@"keyword"];
    [mSearch becomeFirstResponder];
    mArrayRecord  =[[[NSUserDefaults standardUserDefaults] valueForKey:SEARCH_LIST]mutableCopy];
    if (!mArrayRecord) {
        mArrayRecord = [[NSMutableArray alloc]init];
    }
    [self createRecordView];
    
    
    SHPostTaskM * postKeyWord = [[SHPostTaskM alloc]init];
    postKeyWord.URL = URL_FOR(@"Pad/keywordrecom");
    postKeyWord.delegate = self;
    [postKeyWord start:^(SHTask *t) {
        
        mArrayRecomend = [[t result]mutableCopy];
        [self createRecomendView];
        
    } taskWillTry:^(SHTask *t) {
        
    } taskDidFailed:^(SHTask *t) {
        
        
    }];
}
-(void) createRecordView
{
    for (UIView* view in mViewRecord.subviews) {
        [view removeFromSuperview];
    }
    mViewRecord.alpha = 1;
    for (int i = 0; i<mArrayRecord.count; i+=2) {
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, i/2*40, 130, 30)];
        [button setTitle:[mArrayRecord objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        button.titleLabel.font =[UIFont systemFontOfSize:15 ];
        button.tag = i;
        [button addTarget:self action:@selector(btnRecord:) forControlEvents:UIControlEventTouchUpInside];
        
        [mViewRecord addSubview:button];
        if (i+1<mArrayRecord.count) {
            UIButton * button2 = [[UIButton alloc]initWithFrame:CGRectMake(140, i/2*40, 130, 30)];
            [button2 setTitle:[mArrayRecord objectAtIndex:i+1] forState:UIControlStateNormal];
            [button2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [button2 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            button2.titleLabel.font =[UIFont systemFontOfSize:15 ];
            button2.tag = i+1;
            [button2 addTarget:self action:@selector(btnRecord:) forControlEvents:UIControlEventTouchUpInside];
            [mViewRecord addSubview:button2];
        }
        
    }
}
-(void) createRecomendView
{
    for (UIView* view in mViewRecomend.subviews) {
        [view removeFromSuperview];
    }
    for (int i = 0; i<mArrayRecomend.count; i+=4) {
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, i/4*40, 130, 30)];
        [button setTitle:[[mArrayRecomend objectAtIndex:i] objectForKey:@"name"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        button.titleLabel.font =[UIFont systemFontOfSize:15];
        button.tag = i;
        [button addTarget:self action:@selector(btnRecomend:) forControlEvents:UIControlEventTouchUpInside];
        [mViewRecomend addSubview:button];
        if (i+1<mArrayRecomend.count) {
            UIButton * button2 = [[UIButton alloc]initWithFrame:CGRectMake(140, i/4*40, 130, 30)];
            [button2 setTitle:[[mArrayRecomend objectAtIndex:i+1] objectForKey:@"name"] forState:UIControlStateNormal];
            [button2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [button2 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            button2.titleLabel.font =[UIFont systemFontOfSize:15 ];
            button2.tag = i+1;
            [button2 addTarget:self action:@selector(btnRecomend:) forControlEvents:UIControlEventTouchUpInside];
            [mViewRecomend addSubview:button2];
        }
        if (i+2<mArrayRecomend.count) {
            UIButton * button2 = [[UIButton alloc]initWithFrame:CGRectMake(280, i/4*40, 130, 30)];
            [button2 setTitle:[[mArrayRecomend objectAtIndex:i+2] objectForKey:@"name"] forState:UIControlStateNormal];
            [button2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [button2 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            button2.titleLabel.font =[UIFont systemFontOfSize:15 ];
            button2.tag = i+2;
            [button2 addTarget:self action:@selector(btnRecomend:) forControlEvents:UIControlEventTouchUpInside];
            [mViewRecomend addSubview:button2];
        }
        if (i+3<mArrayRecomend.count) {
            UIButton * button2 = [[UIButton alloc]initWithFrame:CGRectMake(420, i/4*40, 130, 30)];
            [button2 setTitle:[[mArrayRecomend objectAtIndex:i+3] objectForKey:@"name"] forState:UIControlStateNormal];
            [button2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [button2 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            button2.titleLabel.font =[UIFont systemFontOfSize:15 ];
            button2.tag = i+3;
            [button2 addTarget:self action:@selector(btnRecomend:) forControlEvents:UIControlEventTouchUpInside];
            [mViewRecomend addSubview:button2];
        }
        
    }
}
- (IBAction)btnWatchRecordOntouch:(UIButton *)sender {
}

- (IBAction)btnDownloadOntouch:(UIButton *)sender {
}
-(void) btnRecord:(UIButton * )sender
{
    
    SHIntent * intent = [[SHIntent alloc]init];
    intent.target = @"SHSearchListViewController";
    [intent.args setValue:sender.titleLabel.text forKey:@"keyword"];
    intent.container  = self.navigationController;
    [[UIApplication sharedApplication]open:intent];
}
-(void) btnRecomend:(UIButton * )sender
{
    if (![mArrayRecord containsObject:sender.titleLabel.text]) {
        [mArrayRecord insertObject:sender.titleLabel.text atIndex:0];
    }
    if (mArrayRecord.count>10) {
        [mArrayRecord removeObjectAtIndex:mArrayRecord.count-1];
    }
    SHIntent * intent = [[SHIntent alloc]init];
    intent.target = @"SHSearchListViewController";
    [intent.args setValue:sender.titleLabel.text forKey:@"keyword"];
    intent.container  = self.navigationController;
    [[UIApplication sharedApplication]open:intent];
}
- (IBAction)btnGoBack:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)btnClearOntouch:(id)sender {
    [self showAlertDialog:@"亲，确定要清空吗？三思啊" button:@"保留" otherButton:@"清空"];
   
    
}
- (void)alertViewCancelOnClick
{
    [UIView animateWithDuration:0.5 animations:^{
        mViewRecord.alpha = 0;
    } completion:^(BOOL finished) {
        for (UIView* view in mViewRecord.subviews) {
            [view removeFromSuperview];
        }
        
    }];
    mArrayRecord = [[NSMutableArray alloc]init];
    [[NSUserDefaults standardUserDefaults ] setValue:[mArrayRecord mutableCopy] forKey:SEARCH_LIST];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [mSearch resignFirstResponder];
    if (![mArrayRecord containsObject:searchBar.text]) {
        [mArrayRecord insertObject:searchBar.text atIndex:0];
    }
    if (mArrayRecord.count>10) {
        [mArrayRecord removeObjectAtIndex:mArrayRecord.count-1];
    }
    SHIntent * intent = [[SHIntent alloc]init];
    intent.target = @"SHSearchListViewController";
    [intent.args setValue:searchBar.text forKey:@"keyword"];
    intent.container  = self.navigationController;
    [[UIApplication sharedApplication]open:intent];
    
}
-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    [[NSUserDefaults standardUserDefaults ] setValue:[mArrayRecord mutableCopy] forKey:SEARCH_LIST];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
