//
//  SHTVDetailViewController.m
//  PPTV
//
//  Created by yebaohua on 14/11/19.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//
// detailInfo
#import "SHTVDetailViewController.h"
#import "SHChannelHorizontalCell.h"
#import "FileModel.h"


@interface SHTVDetailViewController ()

@end

@implementation SHTVDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    self.view.backgroundColor =[SHSkin.instance colorOfStyle:@"ColorBackGroundVideo"];
    
    AppDelegate* app=(AppDelegate*)[UIApplication sharedApplication].delegate;
    
    dicPreInfo = [self.intent.args objectForKey:@"detailInfo"];
    mScrollview.datasource = self;
    mScrollview.delegate = self;
    
    
    
    
    mShowViewControll = [[SHShowVideoViewController alloc]init];
    mShowViewControll.delegate = self;
    mShowViewControll.view.frame = CGRectMake(0, 0, UIScreenWidth, UIScreenHeight);
    mShowViewControll.isfull = YES;
    [self.view addSubview:mShowViewControll.view];
    
    arrayCollect = [[NSMutableArray alloc]init];
    NSData * data  = [[NSUserDefaults standardUserDefaults] valueForKey:COLLECT_LIST];
    if (data) {
        arrayCollect = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    if ([arrayCollect containsObject:dicPreInfo]) {
        mShowViewControll.isStore = YES;
    }
    
    [self request:[[dicPreInfo objectForKey:@"id"]intValue]];

}
-(void) request:(NSInteger)videoID
{
 
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"Pad/vodinfo");
    [post.postArgs setValue:[NSNumber numberWithInt:videoID] forKey:@"id"];
    post.delegate = self;
    [post start:^(SHTask *t) {

        mResultDetail = [[t result]mutableCopy];        
        mVideotitle = [mResultDetail objectForKey:@"title"];
        self.leftTitle = mVideotitle;
        mVideoUrl = @"";
        NSDictionary *urls = [mResultDetail objectForKey:@"vods"];
        NSArray *keys = urls.allKeys;
        for (int i = 0; i< keys.count; i++) {
            if (![[urls objectForKey:[keys objectAtIndex:i]] isEqualToString:@""]) {
                mVideoUrl = [urls objectForKey:[keys objectAtIndex:i]];
                break;
            }
        }
        NSURL * videoUrl = [NSURL URLWithString:mVideoUrl];
        [mShowViewControll quicklyReplayMovie:videoUrl title:[mResultDetail objectForKey:@"title"] seekToPos:0];
        if (mDrameViewControll ==nil) {// 剧集
            mDrameViewControll = [[SHTVDrameViewController alloc]init];
            mDrameViewControll.view.frame = mViewContent.bounds;
            mDrameViewControll.delegate = self;
        }
        [mDrameViewControll refresh:[[dicPreInfo objectForKey:@"id"]intValue]];
        
        [mViewContent addSubview:mDrameViewControll.view];
        if (mDemandDetailViewControll==nil) {// 详情
            mDemandDetailViewControll = [[SHDemandDetailViewController alloc]init];
            mDemandDetailViewControll.view.frame = mViewContent.bounds;
        }
        if (mMoviceDownloadViewControll == nil) {
            mMoviceDownloadViewControll = [[SHMoviceDownloadViewController alloc]init];
            mMoviceDownloadViewControll.view.frame = mViewContent.bounds;
            mMoviceDownloadViewControll.detail = mResultDetail;
        }
        mDemandDetailViewControll.detail = [mResultDetail mutableCopy];
        
        // 大家都在看
        mList = [[mResultDetail objectForKey:@"recoms"]mutableCopy];
        [mScrollview reloadData];
        
    } taskWillTry:^(SHTask *t) {
        
    } taskDidFailed:^(SHTask *t) {
        [t.respinfo show];
    }];

}


- (SHTableHorizontalViewCell*) tableView:(SHTableHorizontalView *)tableView cellForColumnAtIndexPath:(NSIndexPath *)indexPath
{
    
    SHTableHorizontalViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"defalut_cell"];
    if(cell == nil){
        NSArray * array = [[NSBundle mainBundle] loadNibNamed:@"SHChannelHorizontalCell" owner:nil options:nil];
        cell = [array objectAtIndex:0];
        cell.identifier = @"defalut_cell";
    }
    NSDictionary * dic = [mList objectAtIndex:indexPath.row];
    [((SHChannelHorizontalCell*)cell).imgPic setUrl:[dic objectForKey:@"pic"]];
    ((SHChannelHorizontalCell*)cell).labTitle.text = [dic objectForKey:@"title"];
    ((SHChannelHorizontalCell*)cell).labContent.text = [dic objectForKey:@"focus"];
    
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
//    [mScrollview selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];


    [self request:[[[mList objectAtIndex:indexPath.row] objectForKey:@"id"]intValue]];
    
}
#pragma video delegate
- (void)playCtrlGetNextMediaTitle:(SHShowVideoViewController *)control lastPlayPos:(long *)lastPlayPos
{
    
    [mShowViewControll quicklyReplayMovie:[NSURL URLWithString:mVideoUrl] title:mVideotitle seekToPos:0];
}

- (void) showVideoControllerFullScreen:(SHShowVideoViewController*) control full:(BOOL) isFull
{

    [UIView animateWithDuration:0.3 animations:^{
        if (isFull) {
            

            mShowViewControll.view.frame = self.view.bounds;
//            [[UIApplication sharedApplication] setStatusBarHidden:YES];
//            [self.navigationController setNavigationBarHidden:YES animated:YES];
//            [self.view bringSubviewToFront:mShowViewControll.view];
            
        } else {

            mShowViewControll.view.frame = mViewVideo.frame;
           
        }
    }completion:^(BOOL finished) {
        
    }];
}
-(void) showVideoControllerMenuDidSelct:(SHShowVideoViewController *)control sender:(UIButton *)sender tag:(int)tag
{
    
    [self changeRightViewContent:tag];
}

-(void) drameDidSelect:(SHTVDrameViewController*)controll info:(NSDictionary*)detail
{
    [self request:[[detail objectForKey:@"id"]intValue]];
}
#pragma  菜单响应变化
-(void) changeRightViewContent:(int) index
{
    for (UIView * view in mViewContent.subviews) {
        [view removeFromSuperview];
    }
    switch (index) {
        case 1:// 剧集
            mDrameViewControll.isDownload = NO;
            [mViewContent addSubview:mDrameViewControll.view];
            break;
        case 2:// 详情
            [mViewContent addSubview:mDemandDetailViewControll.view];
            break;
        case 3:// 下载
        {
            if ([[mResultDetail objectForKey:@"pid"]intValue] == 1) {// 电影
                [mViewContent addSubview:mMoviceDownloadViewControll.view];
            }else{
                mDrameViewControll.isDownload = YES;
                [mViewContent addSubview:mDrameViewControll.view];
            }
            FileModel* currentFile=[[FileModel alloc] init];
            currentFile.fileReceivedData=[[NSMutableData alloc] init];
            currentFile.fileReceivedSize=@"0";
            currentFile.fileID=@"";
            currentFile.fileName=  mVideotitle;
            currentFile.fileSize=@"未知";
            currentFile.fileURL= mVideoUrl;
            currentFile.isDownloading=NO;
            currentFile.isP2P=NO;

            AppDelegate* app=(AppDelegate*)[UIApplication sharedApplication].delegate;
            [app beginRequest:currentFile isBeginDown:YES];

        }
            break;
        case 4://收藏
        {
            if([arrayCollect containsObject:dicPreInfo]){// 取消收藏
                mShowViewControll.isStore = NO;
                [arrayCollect removeObject:dicPreInfo];
            }else{
                mShowViewControll.isStore = YES;
                [arrayCollect addObject:dicPreInfo];
            }
            NSData * data = [NSKeyedArchiver archivedDataWithRootObject:arrayCollect];
            [[NSUserDefaults standardUserDefaults ] setValue:data forKey:COLLECT_LIST];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
        }
            break;
            
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc
{
    
}


@end
