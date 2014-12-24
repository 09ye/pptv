//
//  SHLiveListViewController.m
//  PPTV
//
//  Created by yebaohua on 14/12/1.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHLiveListViewController.h"
#import "SHDrameMoviceViewCell.h"

@interface SHLiveListViewController ()

@end

@implementation SHLiveListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    pagenum = 1;
    mIsEnd = NO;
    [self requestCategory];
    
}
-(void) requestCategory
{
    SHPostTaskM *post  =[[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"/Pad/livecategory");
    post.cachetype = CacheTypeTimes;
    post.tag = 1000;
    post.delegate = self;
    [post start];
}

-(void) viewWillAppear:(BOOL)animated
{
    //    [super viewWillAppear:YES];
}
-(float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(UITableViewCell*) tableView:(UITableView *)tableView dequeueReusableStandardCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHDrameMoviceViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"table_drame_movice_cell"];
    if(cell == nil){
        cell = (SHDrameMoviceViewCell*)[[[NSBundle mainBundle]loadNibNamed:@"SHDrameMoviceViewCell" owner:nil options:nil] objectAtIndex:0];
        

        cell.imgDetail.frame =CGRectMake(38, 15, 50, 50);
    }
    NSDictionary * dic = [mList objectAtIndex:indexPath.row];
    [cell.imgDetail setUrl:[dic objectForKey:@"logo"]];
    cell.labTitle.text = [dic objectForKey:@"title"];
    cell.labContent.text = [dic objectForKey:@"bill"];
    cell.backgroundColor = [UIColor clearColor];
    if ([[dic objectForKey:@"id"]integerValue] == selctID) {
        
        [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(liveListDidSelect:info:)]) {
        [self.delegate liveListDidSelect:self info:[mList objectAtIndex:indexPath.row]];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) reloadRequest
{
    pagenum = 1;
    mIsEnd = NO;
    [mList removeAllObjects];
    [self loadNext];
}
- (void)loadNext
{
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"Pad/livedata");
    [post.postArgs setValue:[NSString stringWithFormat:@"%d",LIST_PAGE_SIZE] forKeyPath:@"limit"];
    [post.postArgs setValue:[NSString stringWithFormat:@"%d",pagenum] forKeyPath:@"p"];
    [post.postArgs setValue:[NSNumber numberWithInt:cid] forKeyPath:@"cid"];
    post.delegate = self;
    [post start];
    pagenum++;
}
- (void)taskDidFinished:(SHTask*) task
{
    [self dismissWaitDialog];
    if (task.tag == 1000) {
        mListCategory = [[task result]mutableCopy];
        CGRect  lastRect = CGRectZero;
        for (int i=0; i<mListCategory.count; i++) {
            NSDictionary * dic = [mListCategory objectAtIndex:i];
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(lastRect.origin.x+lastRect.size.width+20, 5, 50, 34)];
            [button setTitle:[dic objectForKey:@"title"] forState:UIControlStateNormal];
            button.tag = i;
            [button addTarget:self action:@selector(btnCategory:) forControlEvents:UIControlEventTouchUpInside];
            [button sizeToFit];
            lastRect = button.frame;
            [mScrollviewCate addSubview:button];
        }
        mScrollviewCate.contentSize = CGSizeMake(lastRect.origin.x+lastRect.size.width+20.f, 44);
        
    }else{
        mResult = [[task result] mutableCopy];
        NSArray * list = [task.result valueForKeyPath:@"list"];
        if([[mResult objectForKey:@"total"]intValue] < pagenum){
            mIsEnd = YES;
        }
        if(list.count > 0){
            if(mList == NULL){
                mList = [[NSMutableArray alloc] init];
            }
            [mList addObjectsFromArray:list];
            
        }
        [self.tableView reloadData];
        
    }
    
    
}
- (void)taskDidFailed:(SHTask *)task
{
    [self dismissWaitDialog];
//    [task.respinfo show];
}
#pragma  btnaction
-(void) btnCategory:(UIButton *)sender
{
    NSDictionary* dic  =[mListCategory objectAtIndex:sender.tag];
    cid = [[dic objectForKey:@"id"]integerValue];
    [self reloadRequest];
}

@end
