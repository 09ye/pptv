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
    pageSize = LIST_PAGE_SIZE;
    pagenum = 1;
    mIsEnd = NO;
    
    [self reloadRequest];
    if (_refreshHeaderView == nil) {
        _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0-self.tableView.bounds.size.height, self.tableView.frame.size.width, self.tableView.bounds.size.height)];
        _refreshHeaderView.delegate = self;
        [self.tableView addSubview:_refreshHeaderView];
        
    }
    
    [_refreshHeaderView refreshLastUpdatedDate];
    
    NSMutableArray * listRadio = [[NSMutableArray alloc]init];
     NSMutableArray * listRadio2 = [[NSMutableArray alloc]init];
    NSArray * list = [[NSArray alloc]initWithObjects:@"选项一选项一选项一1",@"选项选项一2",@"选项3一3",@"选项4一4",@"选项5一5",@"选项一6",@"选项7一7", nil];
    CGRect   lastRect = CGRectZero;
    
    for (int i= 0; i<list.count; i++) {
        NSString *text = [list objectAtIndex:i];
        CGSize constraint = CGSizeMake(MAXFLOAT, 40.0f);
        CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:14.00] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
        RadioBox * radioBox = [[RadioBox alloc]initWithFrame:CGRectMake(20+lastRect.origin.x+lastRect.size.width, 10, size.width+10, 30)];
        radioBox.text = [list objectAtIndex:i];
        radioBox.index = i;
        radioBox.textColor = [UIColor whiteColor];
        radioBox.onTintColor = [UIColor orangeColor];
        radioBox.tintColor= [UIColor clearColor];
        
        radioBox.value = @{@"name":@"xx"};
        
        lastRect = radioBox.frame;
        [listRadio addObject:radioBox];
        [listRadio2 addObject:radioBox];
    }
    
    UIView * view1 =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 1024, 50)];
    RadioGroup * radioGroup1 = [[RadioGroup alloc] initWithFrame:CGRectMake(0, 0, 1024, 50) WithControl:listRadio];
    radioGroup1.backgroundColor = [UIColor whiteColor];
    radioGroup1.textFont = [UIFont systemFontOfSize:14.0];
    radioGroup1.selectValue = 2;
    radioGroup1.delegate = self;
    [view1 addSubview:radioGroup1];
    RadioGroup *radioGroup2 = [[RadioGroup alloc] initWithFrame:CGRectMake(0, 50, 1024, 50) WithControl:listRadio2];
    radioGroup2.backgroundColor = [UIColor whiteColor];
    radioGroup2.textFont = [UIFont systemFontOfSize:14.0];
    radioGroup2.selectValue = 2;
    radioGroup2.delegate = self;
    RadioGroup *radioGroup3 = [[RadioGroup alloc] initWithFrame:CGRectMake(0, 100, 1024, 50) WithControl:listRadio2];
    radioGroup3.backgroundColor = [UIColor whiteColor];
    radioGroup3.textFont = [UIFont systemFontOfSize:14.0];
    radioGroup3.selectValue = 2;
    radioGroup3.delegate = self;

    
//    mFilterView = [[[NSBundle mainBundle]loadNibNamed:@"SHFilterView" owner:nil options:nil] objectAtIndex:0];
    mFilterView = [[SHFilterView alloc]initWithFrame:self.view.bounds];
    [mFilterView addSubview:view1];
    [mFilterView addSubview:radioGroup2];
    [mFilterView addSubview:radioGroup3];
    mFilterView.imgArrow = imgArrow;
//    mList =  [[[NSArray alloc]initWithObjects:@"1",@"1",@"1",@"4",@"5",@"6",@"2",@"3",@"5",@"6",@"3",@"2",@"1",@"6",@"3",@"2",@"1",@"3",@"2" ,nil]mutableCopy];
    
    
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
    if(indexPath.row >= mList.count || mList.count == 0 ){
        return 44;
    }else{
         return ((mList.count-1)/5+1)*315;
    }
   
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}
-(UITableViewCell*) tableView:(UITableView *)tableView dequeueReusableStandardCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHImgVertiaclViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"table_img_vertical_cell"];
    if(cell == nil){
        cell = (SHImgVertiaclViewCell*)[[[NSBundle mainBundle]loadNibNamed:@"SHImgVertiaclViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    cell.list = [mList mutableCopy];
    cell.navController = self.navController;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  筛选

- (IBAction)btnShowSearchOntouch:(UIButton *)sender {
     [mFilterView showIn:self.view :CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height-44)];
   
}

- (IBAction)btnSelectMainOntouch:(UIButton *)sender {
    [mFilterView close];
    switch (sender.tag ) {
        case 0:
            mList =  [[[NSArray alloc]initWithObjects:@"2",@"2",@"3",@"4",@"5",@"6",@"2",@"3",@"5",@"6",@"3",@"2",@"1",@"7",@"3",@"2",@"1",@"3",@"2" ,nil]mutableCopy];
            break;
        case 1:
            mList =  [[[NSArray alloc]initWithObjects:@"6",@"5",@"6",@"4",@"2",@"1",@"5",@"3",@"4",@"2",@"1",nil]mutableCopy];
            break;
        case 2:
            mList =  [[[NSArray alloc]initWithObjects:@"2",@"3",@"2",@"4" ,nil]mutableCopy];
            break;
            
        default:
            break;
    }
     [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    
    
}
#pragma request
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
    post.URL = URL_FOR(@"getalljobfairs");
    [post.postArgs setValue:[NSString stringWithFormat:@"%d",pageSize] forKeyPath:@"pagesize"];
    [post.postArgs setValue:[NSString stringWithFormat:@"%d",pagenum] forKeyPath:@"pagenum"];
    post.delegate = self;
    [post start];
    pagenum++;
}
- (void)taskDidFinished:(SHTask*) task
{
    [self dismissWaitDialog];
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    
    mResult = [[task result] mutableCopy];
    NSArray * list = [task.result valueForKeyPath:@"JobList"];
    if([[mResult objectForKey:@"TotalPage"]intValue] < pagenum){
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
- (void)taskDidFailed:(SHTask *)task
{
    [self dismissWaitDialog];
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    [task.respinfo show];
}
@end
