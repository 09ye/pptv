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
    self.view.backgroundColor =[SHSkin.instance colorOfStyle:@"ColorBaseBlack"];
    
    AppDelegate* app=(AppDelegate*)[UIApplication sharedApplication].delegate;
    
    mScrollview.datasource = self;
    mScrollview.delegate = self;
    mList = [[[NSArray alloc]initWithObjects:@"1",@"2",@"2" ,@"1",@"2",@"2" ,nil]mutableCopy ];
    [mScrollview reloadData];
   

    mShowViewControll = [[SHShowVideoViewController alloc]init];
    mShowViewControll.delegate = self;
    mShowViewControll.videoTitle = @"xxx";
    mShowViewControll.videoUrl = @"http://183.136.140.38/gsws/z.m3u8";
    mShowViewControll.videoUrl = @"http://hot.vrs.sohu.com/ipad1407291_4596271359934_4618512.m3u8";
    if ([[self.intent.args objectForKey:@"type"]intValue] == 0) {
        self.title = @"播放详情(标清)";
         mShowViewControll.videoUrl = @"http://padload-cnc.wasu.cn/pcsan08/mams/vod/201409/29/16/201409291618464557d5afdfe_5f77c692.mp4?wsiphost=local";
    }else if ([[self.intent.args objectForKey:@"type"]intValue] == 1) {
        self.title = @"播放详情(高清)";
         mShowViewControll.videoUrl = @"http://padload-cnc.wasu.cn/pcsan08/mams/vod/201409/29/16/2014092916192198605db245e_e0a8255b.mp4?wsiphost=local";
    }else {
        self.title = @"播放详情(超清)";
        mShowViewControll.videoUrl = @"http://padload-cnc.wasu.cn/pcsan08/mams/vod/201409/29/16/201409291618156309b21cbd8_4e58bd54.mp4";
    }
   
   
    
   
     mShowViewControll.view.frame = CGRectMake(0, 0, UIScreenWidth, UIScreenHeight-64);

    mShowViewControll.isfull = YES;
    mViewVideoMenu.hidden = YES;
    
    mDrameViewControll = [[SHTVDrameViewController alloc]init];
    mDrameViewControll.list = [[NSMutableArray alloc]init ];
    mDrameViewControll.view.frame = mViewContent.bounds;
    [mViewContent addSubview:mDrameViewControll.view];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
  
    
    
    
}
-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self.view addSubview:mShowViewControll.view];
    [self.view bringSubviewToFront:mViewVideoMenu];
    [mDrameViewControll.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];

}


- (SHTableHorizontalViewCell*) tableView:(SHTableHorizontalView *)tableView cellForColumnAtIndexPath:(NSIndexPath *)indexPath
{
    
    SHTableHorizontalViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"defalut_cell"];
    if(cell == nil){
        NSArray * array = [[NSBundle mainBundle] loadNibNamed:@"SHChannelHorizontalCell" owner:nil options:nil];
        cell = [array objectAtIndex:0];
        cell.identifier = @"defalut_cell";
    }
    
    
    
//    ((SHChannelHorizontalCell*)cell).labName.text = [mList objectAtIndex:indexPath.row];
    
    return cell;
    
}
- (NSInteger)tableView:(SHTableHorizontalView *)tableView numberOfColumnInSection:(NSInteger)section
{
    
    return mList.count;
}

- (void)tableView:(SHTableHorizontalView *)tableView didSelectColumnAtIndexPath:(NSIndexPath *)indexPath
{
    //    CGRect rectInTableView = [tableView rectForRowAtIndexPath:indexPath];
    //    CGRect rect = [tableView convertRect:rectInTableView toView:[tableView superview]];
    
    
}
- (NSURL *)playCtrlGetNextMediaTitle:(NSString **)title lastPlayPos:(long *)lastPlayPos
{
    return [[NSURL alloc]initWithString:@"http://183.136.140.38/gsws/z.m3u8"];
}
#pragma video
- (void) showVideoControllerFullScreen:(SHShowVideoViewController*) control full:(BOOL) isFull
{

    [UIView animateWithDuration:0.3 animations:^{
        if (isFull) {
            
            mViewVideoMenu.hidden = YES;
            mShowViewControll.view.frame = CGRectMake(0, 0, UIScreenWidth, UIScreenHeight-64);
//            [[UIApplication sharedApplication] setStatusBarHidden:YES];
//            [self.navigationController setNavigationBarHidden:YES animated:YES];
//            [self.view bringSubviewToFront:mShowViewControll.view];
            
        } else {

            mShowViewControll.view.frame = mViewVideo.bounds;
           
        }
    }completion:^(BOOL finished) {
        if (!isFull) {
              mViewVideoMenu.hidden = NO;
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
