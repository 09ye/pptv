//
//  SHChannelListViewController.m
//  PPTV
//
//  Created by yebaohua on 14/11/19.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHChannelListViewController.h"
#import "SHImgVertiaclViewCell.h"


@interface SHChannelListViewController ()

@end

@implementation SHChannelListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.tableView.backgroundColor = [UIColor clearColor];
     app=(AppDelegate*)[UIApplication sharedApplication].delegate;
    pagenum = 1;
    mIsEnd = NO;
    
    [self reloadRequest];
    if (_refreshHeaderView == nil) {
        _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0-self.tableView.bounds.size.height, self.tableView.frame.size.width, self.tableView.bounds.size.height)];
        _refreshHeaderView.delegate = self;
        [self.tableView addSubview:_refreshHeaderView];
        
    }
    
    [_refreshHeaderView refreshLastUpdatedDate];
//    mFilterView = [[[NSBundle mainBundle]loadNibNamed:@"SHFilterView" owner:nil options:nil] objectAtIndex:0];
    mFilterView = [[SHFilterView alloc]initWithFrame:self.view.bounds];
   
    mFilterView.imgArrow = imgArrow;
    
    [self requetFilter];
}

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
    [self reloadRequest];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{
    return NO;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    
    return [NSDate date]; // should return date data source was last changed
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

-(float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row >= 1 || mList.count == 0 ){
        return 44;
    }else{
         return ((mList.count-1)/5+1)*304+15;
    }
   
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (mIsEnd) {
        return 1;
    }else{
        if(mList.count == 0){
            return 1;
        }else{
            return 2;
        }
    }
}
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row ==1 || mList.count == 0 ){
        SHNoneViewCell * cell;
        if(mIsEnd){
            cell = [self dequeueReusableNoneViewCell];
            cell.labContent.text = @"暂无相关讯息...";
        }else{
            cell = [self.tableView dequeueReusableLoadingCell];
            [self loadNext];
        }
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        return [self tableView:tableView dequeueReusableStandardCellForRowAtIndexPath:indexPath];
    }
    return nil;
}
-(UITableViewCell*) tableView:(UITableView *)tableView dequeueReusableStandardCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHImgVertiaclViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"table_img_vertical_cell"];
    if(cell == nil){
        cell = (SHImgVertiaclViewCell*)[[[NSBundle mainBundle]loadNibNamed:@"SHImgVertiaclViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    cell.list = [mList mutableCopy];
    cell.type = self.type;
    cell.navController = self.navController;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma request
-(void) requetFilter
{
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"Pad/listfilter");
    [post.postArgs setValue:[app.viewController categoryForKey:[self.type objectForKey:@"name"] defaultPic:[[self.type objectForKey:@"id"]intValue]] forKeyPath:@"pid"];
    post.delegate = self;
    post.tag = 1000;
    [post start];
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
    post.URL = URL_FOR(@"Pad/listdata");
    [post.postArgs setValue:[NSString stringWithFormat:@"%d",LIST_PAGE_SIZE] forKeyPath:@"limit"];
    [post.postArgs setValue:[NSString stringWithFormat:@"%d",pagenum] forKeyPath:@"p"];
    [post.postArgs setValue:[app.viewController categoryForKey:[self.type objectForKey:@"name"] defaultPic:[[self.type objectForKey:@"id"]intValue]] forKeyPath:@"cid"];
    [post.postArgs setValuesForKeysWithDictionary:mSelect];
    post.delegate = self;
    [post start];
    pagenum++;
}
- (void)taskDidFinished:(SHTask*) task
{
    [self dismissWaitDialog];
    if (task.tag == 1000) {
        mArrayFilter= [[task result]mutableCopy];
        mSelect = [[NSMutableDictionary alloc]init];
        [mSelect setValue:@"1" forKey:@"sort"];//排序 ( 1, 更新时间; 2, 点击量 )
        [self createFilterView];
        
    }else{
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
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
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
//    [task.respinfo show];
}

#pragma  筛选

- (IBAction)btnShowSearchOntouch:(UIButton *)sender {
    [mFilterView showIn:self.view rect:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height-44)];
    
}

- (IBAction)btnSelectMainOntouch:(UIButton *)sender {
    [mFilterView close];
    [mSelect setValue:[NSNumber numberWithInt:sender.tag] forKey:@"sort"];//排序 ( 1, 更新时间; 2, 点击量 )
    [self reloadRequest];
    
    
}
-(void)createFilterView
{
    for (UIView * view  in mFilterView.subviews) {
        if (view.tag <10000) {
            [view removeFromSuperview];
        }
        
    }
    for (int i = 0; i< mArrayFilter.count; i++) {
        NSDictionary *dic = [mArrayFilter objectAtIndex:i];
        NSArray * listData = [dic objectForKey:@"data"];
        NSMutableArray * listRadio = [[NSMutableArray alloc]init];
        CGRect   lastRect = CGRectZero;
        for (int j= 0; j<listData.count; j++) {
            NSDictionary * resultName = [listData objectAtIndex:j];
            NSString *text = [NSString stringWithFormat:@"%@",[resultName objectForKey:@"name"]];
            CGSize constraint = CGSizeMake(MAXFLOAT, 40.0f);
            CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:14.00] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
            RadioBox * radioBox = [[RadioBox alloc]initWithFrame:CGRectMake(20+lastRect.origin.x+lastRect.size.width, 10, size.width+10, 30)];
            radioBox.text = [NSString stringWithFormat:@"%@",[resultName objectForKey:@"name"]];
            radioBox.index = j;
            radioBox.textColor = [UIColor whiteColor];
            radioBox.onTintColor = [UIColor orangeColor];
            radioBox.tintColor= [UIColor clearColor];
            radioBox.value = resultName;
            lastRect = radioBox.frame;
            [listRadio addObject:radioBox];
        }
        UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 1+i*50, 90, 50)];
        lable.userstyle = @"labmindark";
        lable.backgroundColor =[UIColor whiteColor];
        lable.text  =[NSString stringWithFormat:@"%@:",[dic objectForKey:@"name"]];
        lable.textAlignment = NSTextAlignmentCenter;
        //        [lable sizeToFit];
        
        [mFilterView addSubview:lable];
        RadioGroup * radioGroup = [[RadioGroup alloc] initWithFrame:CGRectMake(70, 1+i*50, 1024-70, 50) WithControl:listRadio];
        radioGroup.backgroundColor = [UIColor whiteColor];
        radioGroup.textFont = [UIFont systemFontOfSize:14.0];
        radioGroup.selectValue = 0;
        radioGroup.value = dic;
        radioGroup.delegate = self;
        radioGroup.alpha = 0.97;
        [mFilterView addSubview:radioGroup];
    }
    
    
    
}
-(void) radioGroupDidSelect:(RadioGroup*)radioGroup radioBox:(RadioBox*)radioBox select:(BOOL) isSelect
{
    
    [mSelect setValue:[radioBox.value objectForKey:@"id" ]forKey:[radioGroup.value objectForKey:@"id"]];
    [self reloadRequest];
    
}

@end
