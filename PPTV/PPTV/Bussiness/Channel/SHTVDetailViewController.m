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
    self.title = @"播放详情";
    AppDelegate* app=(AppDelegate*)[UIApplication sharedApplication].delegate;
    
    mScrollview.datasource = self;
    mScrollview.delegate = self;
    mList = [[[NSArray alloc]initWithObjects:@"1",@"2",@"2" ,@"1",@"2",@"2" ,nil]mutableCopy ];
    [mScrollview reloadData];
   
//        [mShowViewControll showIn:app.viewController.view];
//    [self.view addSubview:mShowViewControll.view];
//     [self.navigationController pushViewController:mShowViewControll animated:YES];
    mShowViewControll = [[SHShowVideoViewController alloc]init];
    mShowViewControll.delegate = self;
    mShowViewControll.videoTitle = @"xxx";
    mShowViewControll.videoUrl = @"http://183.136.140.38/gsws/z.m3u8";
    mShowViewControll.videoUrl = @"http://hot.vrs.sohu.com/ipad1407291_4596271359934_4618512.m3u8";
//    mShowViewControll.videoUrl = @"http://padlive1-cnc.wasu.cn/gsws/z.m3u8";
   
    mShowViewControll.view.frame = mViewVideo.bounds;
    videoRect = mViewVideo.frame;
//      mShowViewControll.isfull = YES;
    
    mDrameViewControll = [[SHTVDrameViewController alloc]init];
    mDrameViewControll.list = [[NSMutableArray alloc]init ];
    mDrameViewControll.view.frame = mViewContent.bounds;
    [mViewContent addSubview:mDrameViewControll.view];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
   
}
-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    [mViewVideo insertSubview:mShowViewControll.view atIndex:0];
   
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

#pragma video
- (void) showVideoControllerFullScreen:(SHShowVideoViewController*) control full:(BOOL) isFull
{

    [UIView animateWithDuration:0.3 animations:^{
        if (isFull) {
            
            mViewContent.hidden = YES;
            mViewVideoMenu.hidden = YES;
            mViewDown.hidden = YES;
            mViewVideo.frame = CGRectMake(0, 0, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height-44) ;
            mShowViewControll.view.frame = mViewVideo.bounds;
            
        } else {
            mViewContent.hidden = NO;
          
            mViewDown.hidden = NO;
            mViewVideo.frame = videoRect;
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
