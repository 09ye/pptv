//
//  SHSearchListViewController.m
//  PPTV
//
//  Created by Ye Baohua on 15/1/10.
//  Copyright (c) 2015年 yebaohua. All rights reserved.
//

#import "SHSearchListViewController.h"
#import "SHImgVertiaclViewCell.h"
#import "SHImgHorizaonalViewCell.h"

@interface SHSearchListViewController ()
{
    NSDictionary * mResultMovice;
    NSDictionary * mResultShort;
    NSMutableArray * mArrayRecord;
    UIScrollView * mViewMoviceSection;
    NSArray * mArrayMoviceSection;
    NSArray * mListMovice;
    NSMutableArray * mListMoviceSelect;
    NSMutableArray * arrayBtnCate;
    
    int assettype;// 资产类别 电影 筛选
    int sort;// 排序 ( 1, 更新时间; 2, 点击量 )
    int pagenum;
    bool isShowMore;// 查看更多
    bool isShowMocie;
    bool isShowShort;
    
}

@end

@implementation SHSearchListViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    mSearch.text = [self.intent.args objectForKey:@"keyword"];
    [mSearch resignFirstResponder];

//    mSearch.text = @"武";

    mArrayRecord  =[[[NSUserDefaults standardUserDefaults] valueForKey:SEARCH_LIST]mutableCopy];
    if (!mArrayRecord) {
        mArrayRecord = [[NSMutableArray alloc]init];
    }
    mListMoviceSelect = [[NSMutableArray alloc]init];
    arrayBtnCate = [[NSMutableArray alloc]init];
    mViewMoviceSection = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 1024, 44)];
    mViewMoviceSection.showsHorizontalScrollIndicator = NO;
    mViewMoviceSection.showsVerticalScrollIndicator = NO;
    mViewMoviceSection.backgroundColor = [SHSkin.instance colorOfStyle:@"ColorBaseBackGround"];
    mViewSection2.backgroundColor = [SHSkin.instance colorOfStyle:@"ColorBaseBackGround"];
    mCellSeeMore.backgroundColor = [SHSkin.instance colorOfStyle:@"ColorLine"];

    
    pagenum = 1;
    mIsEnd = NO;
    sort = 1;
    isShowMore = YES;
    isShowMocie = NO;
    isShowShort = NO;
    [self requestMovice];
    [self requestShort];
    
    
    
}
-(void)requestMovice
{
    if (![mSearch.text isEqualToString:@""]) {
        SHPostTaskM * postKeyWord = [[SHPostTaskM alloc]init];
        postKeyWord.URL = URL_FOR(@"Pad/searchtopdata");
        [postKeyWord.postArgs setValue:mSearch.text forKey:@"k"];
        [postKeyWord.postArgs setValue:SHEntironment.instance.version.description forKey:@"version"];
        postKeyWord.delegate = self;
        [postKeyWord start:^(SHTask *t) {
            
            mResultMovice = [[t result]mutableCopy];
            mArrayMoviceSection = [mResultMovice objectForKey:@"total"];
            mListMovice = [mResultMovice objectForKey:@"list"];
            mListMoviceSelect = [mListMovice mutableCopy];
            if (mListMovice.count >0) {
                isShowMocie = YES;
                if([mListMovice count]>5)
                {
                    isShowMore = NO;
                }else{
                    isShowMore = YES;
                }
                
                [self createMoviceView];
                [self.tableView reloadData];
            }else{
                isShowMocie = NO;
            }
            
        } taskWillTry:^(SHTask *t) {
            
        } taskDidFailed:^(SHTask *t) {
            
            isShowMocie = NO;
            isShowMore = YES;
        }];
    }
    
}
-(void)requestShort
{
    if (![mSearch.text isEqualToString:@""]) {
        pagenum = 1;
        mIsEnd = NO;
        [mList removeAllObjects];
        [self loadNext];
    }
}
- (void)loadNext
{
    if (![mSearch.text isEqualToString:@""]) {
        SHPostTaskM * postKeyWord = [[SHPostTaskM alloc]init];
        postKeyWord.URL = URL_FOR(@"Pad/searchdata");
        [postKeyWord.postArgs setValue:SHEntironment.instance.version.description forKey:@"version"];
        [postKeyWord.postArgs setValue:mSearch.text forKey:@"k"];
        [postKeyWord.postArgs setValue:[NSString stringWithFormat:@"%d",LIST_PAGE_SIZE] forKeyPath:@"limit"];
        [postKeyWord.postArgs setValue:[NSString stringWithFormat:@"%d",pagenum] forKeyPath:@"p"];
        [postKeyWord.postArgs setValue:[NSNumber numberWithInt:sort] forKey:@"sort"];
        postKeyWord.delegate = self;
        [postKeyWord start:^(SHTask *t) {
            
            mResultShort = [[t result]mutableCopy];
            [mbtnResultShort setTitle:[NSString stringWithFormat:@"共找到%@个结果",[mResultShort objectForKey:@"count"]] forState:UIControlStateNormal];
            NSArray * list = [mResultShort valueForKeyPath:@"list"];
            if([[mResultShort objectForKey:@"total"]intValue] < pagenum){
                mIsEnd = YES;
            }
            if(list.count > 0){
                if(mList == NULL){
                    mList = [[NSMutableArray alloc] init];
                }
                [mList addObjectsFromArray:list];
                
            }
            if(mList.count>0){
                isShowShort = YES;
                 [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
            }else {
                isShowShort = NO;
            }
            
            
        } taskWillTry:^(SHTask *t) {
            
        } taskDidFailed:^(SHTask *t) {
            mIsEnd = YES;
            isShowShort = NO;
            [self.tableView reloadData];
        }];
        
        pagenum++;
    }
    
}
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return  2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section== 0 &&isShowMocie) {
        return 44;
    }else if (section == 1 && isShowShort) {
        return 44;
    }
    return 0;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return mViewMoviceSection;
    }
    return mViewSection2;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (!isShowMore && section == 0) {
        return 2;
    }else if (section == 1){
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
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && isShowMocie) {
        if (indexPath.row == 0) {
            if (mListMoviceSelect.count == 0) {
                return 0;
            }
            if (isShowMore) {
                return ((mListMoviceSelect.count -1)/5+1)*304+15;
            }else{
                return 315;
            }
            
        }else{
            return  44;
        }
        
    }else if (indexPath.section == 1 && isShowShort){
        if(indexPath.row >= 1 || mList.count == 0 ){
            return 44;
        }else{
            return ((mList.count-1)/5+1)*164+15;
        }
    }
    return  44;
}
-(UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            SHImgVertiaclViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"table_img_vertical_cell"];
            if(cell == nil){
                cell = (SHImgVertiaclViewCell*)[[[NSBundle mainBundle]loadNibNamed:@"SHImgVertiaclViewCell" owner:nil options:nil] objectAtIndex:0];
            }
            cell.list = [mListMoviceSelect mutableCopy];
            cell.navController = self.navigationController;
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else {
            mCellSeeMore.selectionStyle = UITableViewCellSelectionStyleNone;
            return mCellSeeMore;
        }
        
    }else if (indexPath.section == 1){
        
        if((indexPath.row ==1 || mList.count == 0)){
            SHNoneViewCell * cell;
            if(mIsEnd){
                cell = [self dequeueReusableNoneViewCell];
                cell.labContent.text = @"抱歉，没有找到相关的结果";
            }else{
                cell = [self.tableView dequeueReusableLoadingCell];
                cell.backgroundColor = [UIColor redColor];
                [self loadNext];
            }
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            return [self tableView:tableView dequeueReusableStandardCellForRowAtIndexPath:indexPath];
        }
        
        

    }
    return nil ;
    
}
-(UITableViewCell*) tableView:(UITableView *)tableView dequeueReusableStandardCellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    SHImgHorizaonalViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"table_img_horizaonal_cell"];
    if(cell == nil){
        cell = (SHImgHorizaonalViewCell*)[[[NSBundle mainBundle]loadNibNamed:@"SHImgHorizaonalViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    cell.navController = self.navigationController;
    cell.type = 0;
    cell.list = [mList mutableCopy];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
-(void) createMoviceView
{
    for (UIView* view in mViewMoviceSection.subviews) {
        [view removeFromSuperview];
    }
    mViewMoviceSection.alpha = 1;
    CGRect   lastRect = CGRectZero;
    for (int i = 0; i<mArrayMoviceSection.count; i++) {
        NSDictionary * dic = [mArrayMoviceSection objectAtIndex:i];
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(30+lastRect.origin.x+lastRect.size.width, 10, 10, 30)];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button setTitle:[NSString stringWithFormat:@"%@(%@)",[dic objectForKey:@"name"],[dic objectForKey:@"count"]] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        button.titleLabel.font =[UIFont systemFontOfSize:15 ];
        button.tag = [[dic objectForKey:@"id"]intValue];
        [button sizeToFit];
        [button addTarget:self action:@selector(btnMoviceSelect:) forControlEvents:UIControlEventTouchUpInside];
        lastRect = button.frame;
        [mViewMoviceSection addSubview:button];
        [arrayBtnCate addObject:button];
        if (i==0) {
            [button setTitleColor:[SHSkin.instance colorOfStyle:@"ColorTextOrg"] forState:UIControlStateNormal];
        }
    }
    mViewMoviceSection.contentSize = CGSizeMake(lastRect.origin.x+lastRect.size.width+10,0);
    
    
}
// 本地筛选 电影
-(void) btnMoviceSelect:(UIButton*) sender
{
    for (UIButton * button in arrayBtnCate) {
        if (button == sender) {
            [button setTitleColor:[SHSkin.instance colorOfStyle:@"ColorTextOrg"] forState:UIControlStateNormal];
        }else{
            
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
    }
    assettype = sender.tag;
    mListMoviceSelect = [[NSMutableArray alloc]init];

    for (NSDictionary * dic in mListMovice) {
        if ([[dic objectForKey:@"assettype"]intValue] == sender.tag || assettype == 0) {
            [mListMoviceSelect addObject:dic];
        }
    }
    isShowMore = YES;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    

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
- (IBAction)btnGoBack:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)btnSelectMainOntouch:(UIButton *)sender {
    sort = sender.tag;//排序 ( 1, 更新时间; 2, 点击量 )
    [self requestShort];
    
    
}

- (IBAction)btnSeeMoreOntouch:(id)sender {
    isShowMore = YES;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
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
