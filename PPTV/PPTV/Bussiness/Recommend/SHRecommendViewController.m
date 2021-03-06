//
//  SHRecommendViewController.m
//  PPTV
//
//  Created by yebaohua on 14/11/16.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHRecommendViewController.h"
#import "SHBestAdCell.h"
#import "SHImgVertiaclViewCell.h"
#import "SHRecomendFirstCell.h"
#import "SHRecomendSecondTitleCell.h"
#import "SHImgHorizaonalViewCell.h"

@interface SHRecommendViewController ()


@end

@implementation SHRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString * hiddeDay =  [NSDate stringFromDate:[NSDate date] withFormat:@"yyyy-MM-dd"];
    if ([hiddeDay caseInsensitiveCompare:@"2015-05-10"] == NSOrderedAscending) {
        isHiddenLive = YES;
    }
    
    self.tableView.backgroundColor = [UIColor clearColor];
    app=(AppDelegate*)[UIApplication sharedApplication].delegate;
    UIView * viewTitleBar = [app.viewController hideSearchView:NO];
    viewTitleBar.alpha = 0.9;
    
    [self reloadRequest:YES];
    if (_refreshHeaderView == nil) {
        _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0-self.tableView.bounds.size.height, self.tableView.frame.size.width, self.tableView.bounds.size.height)];
        _refreshHeaderView.delegate = self;
        [self.tableView addSubview:_refreshHeaderView];
        
    }
    
    [_refreshHeaderView refreshLastUpdatedDate];
    
    mTimerLive = [NSTimer scheduledTimerWithTimeInterval:60*10 target:self selector:@selector(reloadLiveRequest) userInfo:nil repeats:YES];
    
    
}

-(void)reloadRequest:(BOOL) cache
{
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"Pad/home");
    if (cache) {
        post.cachetype  = CacheTypeTimes;
    }
    post.delegate = self;
    [post start:^(SHTask *t) {
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];

        if(![[[t result] class] isSubclassOfClass:[NSNull class]]){
            mResult = [[t result]mutableCopy];
 
        }
        imagesArray = [mResult objectForKey:@"slide_area"];

        [self.tableView reloadData];
    } taskWillTry:^(SHTask *t) {
        
    } taskDidFailed:^(SHTask *t) {
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
        [t.respinfo show];

    }];
    

    [self reloadLiveRequest];
}
-(void)reloadLiveRequest
{
    SHPostTaskM * post1 = [[SHPostTaskM alloc]init];
    post1.URL = URL_FOR(@"Pad/indexlive");
    post1.delegate = self;
    [post1 start:^(SHTask *t) {
        
        mListLive = [[t result]mutableCopy];
        NSIndexPath *te=[NSIndexPath indexPathForRow:1 inSection:0];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:te,nil] withRowAnimation:UITableViewRowAnimationNone];
        
    } taskWillTry:^(SHTask *t) {
        
    } taskDidFailed:^(SHTask *t) {
        
    }];
    
}
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
    [self reloadRequest:NO];
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
//    static float currentPostion = 0;
//    static float lastPosition = 0;
//    currentPostion = scrollView.contentOffset.y ;
//    if (currentPostion - lastPosition > 10) { //向上滑动屏幕时，隐藏标签栏
//      
//        [app hideTarBarSHDelegate:YES];
//    }
//    else if (lastPosition - currentPostion > 5)//当标签栏隐藏时，向下滑动屏幕时，显示标签栏,
//    {
//        [app hideTarBarSHDelegate:NO];
//    }
//    lastPosition = currentPostion;
//    if(scrollView.contentSize.height-scrollView.contentOffset.y <= scrollView.frame.size.height){// 底部
//        [app hideTarBarSHDelegate:YES];
//    }
//   [app.viewController hideSearchView:NO];
    
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //    [_pageController setCurrentPage:_page];
   
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.row == 0) {
        if (isHiddenLive) {
            return  0;
        }
        return BEST_SCROLLVIEW_WIDTH;
    }else if(indexPath.row == 1){// 直播
        if (isHiddenLive) {
            return  0;
        }
        return 355;
    }else if(indexPath.row == 2 || indexPath.row == 4 || indexPath.row == 6 || indexPath.row == 8){
        if(isHiddenLive && (indexPath.row == 8)){//微电影
            return 0;
        }
        return 175;
    }else if(indexPath.row == 3 || indexPath.row == 5 || indexPath.row == 7 || indexPath.row == 9){
        if(isHiddenLive && (indexPath.row == 9)){//微电影
            return 0;
        }
        return 2*315;
    }else{
        if(isHiddenLive && (indexPath.row == 11)){//综艺
            return 0;
        }
        return 2*175;
    }

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return 12;
}

-(SHTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        SHBestAdCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"table_bestad_cell"];
        if(cell == nil){
            cell = (SHBestAdCell*)[[[NSBundle mainBundle]loadNibNamed:@"SHBestAdCell" owner:nil options:nil] objectAtIndex:0];
        }
    
        if(imagesArray.count>0){
            [cell.contentView insertSubview:[self showScrollView:imagesArray WithAnimation:YES] atIndex:0];
        }else{
            UIImageView * defaultImg  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 1024, BEST_SCROLLVIEW_WIDTH)];
            defaultImg.image = [UIImage imageNamed:@"default2048x600"];
            [cell.contentView addSubview:defaultImg];
        }

        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (isHiddenLive) {
            cell.hidden = YES;
        }
        return cell;
        
    }else if (indexPath.row == 1){

        SHRecomendFirstCell * cell = [[[NSBundle mainBundle]loadNibNamed:@"SHRecomendFirstCell" owner:nil options:nil] objectAtIndex:0];
        
        cell.detail = [mResult mutableCopy];
        cell.listLive = mListLive;
        cell.navController = self.navController;
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (isHiddenLive) {
            cell.hidden = YES;
        }
        return cell;
        
    }else if (indexPath.row == 2){//动漫

        SHRecomendSecondTitleCell * cell = (SHRecomendSecondTitleCell*)[[[NSBundle mainBundle]loadNibNamed:@"SHRecomendSecondTitleCell" owner:nil options:nil] objectAtIndex:0];
        
        if (isHiddenLive) {
            cell.tabIndex = 1;
        }else{
            cell.tabIndex = 2;
        }
        
        cell.btnBg.backgroundColor = [UIColor colorWithRed:237/255.0 green:144/255.0 blue:41/255.0 alpha:1];
        
        NSMutableArray * array = [mResult objectForKey:@"cartoon_rec"];
        cell.detailArray = [array mutableCopy];
        if(array.count>1){
            [cell.imgBig1 setUrl:[[array objectAtIndex:0]objectForKey:@"pic"]];
            [cell.imgBig2 setUrl:[[array objectAtIndex:1]objectForKey:@"pic"]];
        }
        
        cell.labContentLogo.text = [NSString stringWithFormat:@"共%d部",[[mResult objectForKey:@"cartoon_count"]intValue]];
        
        cell.imgLogo.image = [UIImage imageNamed:@"ic_home_animation"];
        cell.labNameLogo.text = @"动漫";
        cell.navController = self.navController;
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }else if (indexPath.row == 3){

        SHImgVertiaclViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"table_img_vertical_cell"];
        if(cell == nil){
            cell = (SHImgVertiaclViewCell*)[[[NSBundle mainBundle]loadNibNamed:@"SHImgVertiaclViewCell" owner:nil options:nil] objectAtIndex:0];
        }
        cell.list = [[mResult objectForKey:@"cartoon_index"]mutableCopy];
        cell.navController = self.navController;
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 4){//电视

        SHRecomendSecondTitleCell * cell = cell = [self.tableView dequeueReusableCellWithIdentifier:@"table_recommend_second_title_cell"];
        if(cell == nil){
            cell = (SHRecomendSecondTitleCell*)[[[NSBundle mainBundle]loadNibNamed:@"SHRecomendSecondTitleCell" owner:nil options:nil] objectAtIndex:0];
        }
        if (isHiddenLive) {
            cell.tabIndex = 2;
        }else{
            cell.tabIndex = 3;
        }
        cell.btnBg.backgroundColor = [UIColor colorWithRed:160/255.0 green:177/255.0 blue:1/255.0 alpha:1];
        NSMutableArray * array = [mResult objectForKey:@"tele_rec"];
        cell.detailArray = [array mutableCopy];
        if(array.count>1){
            [cell.imgBig1 setUrl:[[array objectAtIndex:0]objectForKey:@"pic"]];
            [cell.imgBig2 setUrl:[[array objectAtIndex:1]objectForKey:@"pic"]];
        }
        
        cell.labContentLogo.text = [NSString stringWithFormat:@"共%d部",[[mResult objectForKey:@"tele_count"]intValue]];
        
        cell.imgLogo.image = [UIImage imageNamed:@"ic_home_tv"];
        cell.labNameLogo.text = @"电视剧";
        cell.navController = self.navController;
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if (indexPath.row == 5){

        SHImgVertiaclViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"table_img_vertical_cell"];
        if(cell == nil){
            cell = (SHImgVertiaclViewCell*)[[[NSBundle mainBundle]loadNibNamed:@"SHImgVertiaclViewCell" owner:nil options:nil] objectAtIndex:0];
        }
        cell.list = [[mResult objectForKey:@"tele_index"]mutableCopy];
        cell.navController = self.navController;
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 6){

        SHRecomendSecondTitleCell * cell = cell = [self.tableView dequeueReusableCellWithIdentifier:@"table_recommend_second_title_cell"];
        if(cell == nil){
            cell = (SHRecomendSecondTitleCell*)[[[NSBundle mainBundle]loadNibNamed:@"SHRecomendSecondTitleCell" owner:nil options:nil] objectAtIndex:0];
        }
        if (isHiddenLive) {
            cell.tabIndex = 3;
        }else{
            cell.tabIndex = 4;
        }
        cell.btnBg.backgroundColor = [UIColor colorWithRed:0/255.0 green:166/255.0 blue:241/255.0 alpha:1];
        NSMutableArray * array = [mResult objectForKey:@"movie_rec"];
        cell.detailArray = [array mutableCopy];
        if(array.count>1){
            [cell.imgBig1 setUrl:[[array objectAtIndex:0]objectForKey:@"pic"]];
            [cell.imgBig2 setUrl:[[array objectAtIndex:1]objectForKey:@"pic"]];
        }
        
        cell.labContentLogo.text = [NSString stringWithFormat:@"共%d部",[[mResult objectForKey:@"movie_count"]intValue]];
        
        cell.imgLogo.image = [UIImage imageNamed:@"ic_home_movice"];
        cell.labNameLogo.text = @"电影";
        cell.navController = self.navController;
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if (indexPath.row == 7){

        SHImgVertiaclViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"table_img_vertical_cell"];
        if(cell == nil){
            cell = (SHImgVertiaclViewCell*)[[[NSBundle mainBundle]loadNibNamed:@"SHImgVertiaclViewCell" owner:nil options:nil] objectAtIndex:0];
        }
        cell.list = [[mResult objectForKey:@"movie_index"]mutableCopy];
        cell.navController = self.navController;
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if (indexPath.row == 8){// 微电影
        
        SHRecomendSecondTitleCell * cell  = [self.tableView dequeueReusableCellWithIdentifier:@"table_recommend_second_title_cell"];
        if(cell == nil){
            cell = [[[NSBundle mainBundle]loadNibNamed:@"SHRecomendSecondTitleCell" owner:nil options:nil] objectAtIndex:0];
        }
        cell.tabIndex = 5;
        cell.btnBg.backgroundColor = [UIColor colorWithRed:1/255.0 green:195/255.0 blue:169/255.0 alpha:1];
        NSMutableArray * array = [mResult objectForKey:@"micro_rec"];
        cell.detailArray = [array mutableCopy];
        if(array.count>1){
            [cell.imgBig1 setUrl:[[array objectAtIndex:0]objectForKey:@"pic"]];
            [cell.imgBig2 setUrl:[[array objectAtIndex:1]objectForKey:@"pic"]];
        }
        
        cell.labContentLogo.text = [NSString stringWithFormat:@"共%d部",[[mResult objectForKey:@"micro_count"]intValue]];
        
        cell.imgLogo.image = [UIImage imageNamed:@"ic_home_movice_micro"];
        cell.labNameLogo.text = @"微电影";
        cell.navController = self.navController;
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (isHiddenLive) {
            cell.hidden = YES;
        }
        return cell;
        
    }else if (indexPath.row == 9){
        SHImgVertiaclViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"table_img_vertical_cell"];
        if(cell == nil){
            cell = (SHImgVertiaclViewCell*)[[[NSBundle mainBundle]loadNibNamed:@"SHImgVertiaclViewCell" owner:nil options:nil] objectAtIndex:0];
        }
        cell.list = [[mResult objectForKey:@"micro_index"]mutableCopy];
        cell.navController = self.navController;
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (isHiddenLive) {
            cell.hidden = YES;
        }
        return cell;
    }else if (indexPath.row == 10){//综艺
        SHImgHorizaonalViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"table_img_horizaonal_cell"];
        if(cell == nil){
            cell = (SHImgHorizaonalViewCell*)[[[NSBundle mainBundle]loadNibNamed:@"SHImgHorizaonalViewCell" owner:nil options:nil] objectAtIndex:0];
        }
        cell.isHiddenLive = isHiddenLive;// 隐藏点击跳转
        cell.navController = self.navController;
        cell.type = 1;
        cell.detail = [mResult mutableCopy];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{//纪录片
        SHImgHorizaonalViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"table_img_horizaonal_cell"];
        if(cell == nil){
            cell = (SHImgHorizaonalViewCell*)[[[NSBundle mainBundle]loadNibNamed:@"SHImgHorizaonalViewCell" owner:nil options:nil] objectAtIndex:0];
        }
        cell.navController = self.navController;
        cell.type = 2;
        cell.detail = [mResult mutableCopy];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (isHiddenLive) {
            cell.hidden = YES;
        }
        return cell;
    }
   
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
}
-(BestScrollView  *)showScrollView:(NSMutableArray *)arr  WithAnimation:(BOOL)animation{
    
    
    imagesCount=[arr  count];
    
    imagesArray=[NSMutableArray arrayWithArray:arr];
    csView=nil;
    
    if (!csView) {
        csView = [[BestScrollView alloc] initWithFrame:CGRectMake(0, 0, 1024, BEST_SCROLLVIEW_WIDTH)];
    }
    csView.animationTimer= YES;
    csView.imageArray=imagesArray;
    [csView showImageArray:imagesArray withAnimation:YES];
    csView.tag=99;
    csView.layer.cornerRadius= 2;
    csView.layer.masksToBounds  = NO;
    csView.delegate = self;
    csView.datasource = self;
    
    UISwipeGestureRecognizer* recognizer;
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    recognizer.delegate = self;
    recognizer.direction = UISwipeGestureRecognizerDirectionLeft| UISwipeGestureRecognizerDirectionRight;

    [csView addGestureRecognizer:recognizer];

    return  csView;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    // TODO 做些过滤
//    UISwipeGestureRecognizer* recognizer =   (UISwipeGestureRecognizer*)gestureRecognizer;
//    if(recognizer.direction == (UISwipeGestureRecognizerDirectionLeft| UISwipeGestureRecognizerDirectionRight)){
//              }
  
//    [app.viewController hideSearchView:YES];

    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}
- (void)handleSwipeFrom:(UISwipeGestureRecognizer*)recognizer {
    // 触发手勢事件后，在这里作些事情
    
    // 底下是刪除手势的方法
    //    [self.view removeGestureRecognizer:recognizer];
    NSLog(@"======================");
}
#pragma  mark BestView Delegate Data=source

- (NSInteger)numberOfPages
{
    csView.pageControl.numberOfPages=imagesCount;
    
    return imagesCount;
}

- (UIView *)pageAtIndex:(NSInteger)index
{
    SHImageView  *imageView=[[SHImageView alloc]  initWithFrame: CGRectMake(0, 0, 1024, BEST_SCROLLVIEW_WIDTH)];
    [imageView setUrl:[[imagesArray objectAtIndex:index] objectForKey:@"pic"]];
    
    return imageView;
}

- (void)didClickPage:(BestScrollView *)csView atIndex:(NSInteger)index
{
    
    // 进入大图
    NSDictionary * dic = [imagesArray objectAtIndex:index];
   // 1.3 点播  2 直播  4浏览器
    SHIntent *intent = [[SHIntent alloc]init];
    if([[dic objectForKey:@"type"]intValue] == 4){
        intent.target = @"WebViewController";
        
    }else if([[dic objectForKey:@"type"]intValue] == 2){
        intent.target = @"SHLiveViewController";
    }else{
        intent.target = @"SHTVDetailViewController";
    }
    [intent.args setValue:dic forKeyPath:@"detailInfo"];
    intent.container = self.navController;
    [[UIApplication sharedApplication]open:intent];
}
@end
