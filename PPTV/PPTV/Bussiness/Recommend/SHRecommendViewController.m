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
    mListItme = [[NSArray alloc]initWithObjects:@"",@"精彩专题",@"今日热点",@"热播电影",@"同步剧场",@"小编推荐",@"精品推荐",nil];
    self.tableView.backgroundColor = [UIColor clearColor];
    app=(AppDelegate*)[UIApplication sharedApplication].delegate;
    UIView * viewTitleBar = [app.viewController hideSearchView:NO];
    viewTitleBar.alpha = 0.9;
    
    imagesArray = [[[NSArray alloc]initWithObjects:@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1", nil] mutableCopy];
    [self.tableView reloadData];
    
//    SHPostTask * post = [[SHPostTaskM alloc]init];
//    post.URL = @"http://mobile.9191offer.com/getguidepic";
//    post.delegate = self;
//    [post start:^(SHTask *t) {
//        imagesArray = [[t result]mutableCopy];
//       
//    } taskWillTry:^(SHTask *t) {
//        
//    } taskDidFailed:^(SHTask *t) {
//        
//    }];
    
    
  
}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if (section == 0) {
//        return 0;
//    }
//    return CELL_GENERAL_HEIGHT3;
//}
//- (int) numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return mListItme.count;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    if (section == 0) {
//        return  [[UIView alloc]init];
//    }
//    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 320, 44)];
//    label.userstyle = @"labmidmilk";
//    label.text = [mListItme objectAtIndex:section];
//    label.textAlignment = NSTextAlignmentLeft;
//    return label;
//}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    static float currentPostion = 0;
    static float lastPosition = 0;
    currentPostion = scrollView.contentOffset.y ;
    if (currentPostion - lastPosition > 10) { //向上滑动屏幕时，隐藏标签栏
      
        [app hideTarBarSHDelegate:YES];
    }
    else if (lastPosition - currentPostion > 5)//当标签栏隐藏时，向下滑动屏幕时，显示标签栏,
    {
        [app hideTarBarSHDelegate:NO];
    }
    lastPosition = currentPostion;
    if(scrollView.contentSize.height-scrollView.contentOffset.y <= scrollView.frame.size.height){// 底部
        [app hideTarBarSHDelegate:YES];
    }
   [app.viewController hideSearchView:NO];
    
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //    [_pageController setCurrentPage:_page];
   
}
-(float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.row == 0) {
        return 330;
    }else if(indexPath.row == 1){
        return 355;
    }else if(indexPath.row == 2 || indexPath.row == 4 || indexPath.row == 6 || indexPath.row == 8){
        return 175;
    }else if(indexPath.row == 3 || indexPath.row == 5 || indexPath.row == 7 || indexPath.row == 9){
        return 2*315;
    }else{
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
//        imagesArray=[NSMutableArray arrayWithArray:mListItme];
        if(imagesArray.count>0){
            [cell.contentView insertSubview:[self showScrollView:imagesArray WithAnimation:YES] atIndex:0];
        }

        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
      
        return cell;
        
    }else if (indexPath.row == 1){
        SHRecomendFirstCell * cell = cell = [self.tableView dequeueReusableCellWithIdentifier:@"table_recommend_first_cell"];
        if(cell == nil){
            cell = (SHRecomendFirstCell*)[[[NSBundle mainBundle]loadNibNamed:@"SHRecomendFirstCell" owner:nil options:nil] objectAtIndex:0];
        }
        cell.detail = [[NSMutableDictionary alloc]init];
        cell.navController = self.navController;
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if (indexPath.row == 2){//动漫
        
        SHRecomendSecondTitleCell * cell = cell = [self.tableView dequeueReusableCellWithIdentifier:@"table_recommend_second_title_cell"];
        if(cell == nil){
            cell = (SHRecomendSecondTitleCell*)[[[NSBundle mainBundle]loadNibNamed:@"SHRecomendSecondTitleCell" owner:nil options:nil] objectAtIndex:0];
        }
        cell.btnBg.backgroundColor = [UIColor colorWithRed:234/255.0 green:143/255.0 blue:50/255.0 alpha:1];
        cell.detail = [[NSMutableDictionary alloc]init];
        cell.imgLogo.image = [UIImage imageNamed:@"ic_home_animation"];
        cell.labNameLogo.text = @"动漫";
        cell.labContentLogo.text = @"共1234部";
        cell.navController = self.navController;
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if (indexPath.row == 3){
        SHImgVertiaclViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"table_img_vertical_cell"];
        if(cell == nil){
            cell = (SHImgVertiaclViewCell*)[[[NSBundle mainBundle]loadNibNamed:@"SHImgVertiaclViewCell" owner:nil options:nil] objectAtIndex:0];
        }
        cell.list = [[[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"3",@"7",@"2",@"1",nil]mutableCopy];
        cell.navController = self.navController;
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 4){//电视
        
        SHRecomendSecondTitleCell * cell = cell = [self.tableView dequeueReusableCellWithIdentifier:@"table_recommend_second_title_cell"];
        if(cell == nil){
            cell = (SHRecomendSecondTitleCell*)[[[NSBundle mainBundle]loadNibNamed:@"SHRecomendSecondTitleCell" owner:nil options:nil] objectAtIndex:0];
        }
         cell.detail = [[NSMutableDictionary alloc]init];
        cell.btnBg.backgroundColor = [UIColor colorWithRed:158/255.0 green:178/255.0 blue:35/255.0 alpha:1];
        cell.imgLogo.image = [UIImage imageNamed:@"ic_home_tv"];
        cell.labNameLogo.text = @"电视剧";
        cell.labContentLogo.text = @"共1234部";
        cell.navController = self.navController;
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if (indexPath.row == 5){
        SHImgVertiaclViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"table_img_vertical_cell"];
        if(cell == nil){
            cell = (SHImgVertiaclViewCell*)[[[NSBundle mainBundle]loadNibNamed:@"SHImgVertiaclViewCell" owner:nil options:nil] objectAtIndex:0];
        }
         cell.list = [[[NSArray alloc]initWithObjects:@"3",@"2",@"1",@"1",@"3",@"6",@"2",@"7",@"2",@"1",nil]mutableCopy];
        cell.navController = self.navController;
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 6){
        
        SHRecomendSecondTitleCell * cell = cell = [self.tableView dequeueReusableCellWithIdentifier:@"table_recommend_second_title_cell"];
        if(cell == nil){
            cell = (SHRecomendSecondTitleCell*)[[[NSBundle mainBundle]loadNibNamed:@"SHRecomendSecondTitleCell" owner:nil options:nil] objectAtIndex:0];
        }
         cell.detail = [[NSMutableDictionary alloc]init];
        cell.btnBg.backgroundColor = [UIColor colorWithRed:31/255.0 green:166/255.0 blue:212/255.0 alpha:1];
        cell.imgLogo.image = [UIImage imageNamed:@"ic_home_movice"];
        cell.labNameLogo.text = @"电影";
        cell.labContentLogo.text = @"共1234部";
        cell.navController = self.navController;
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if (indexPath.row == 7){
        SHImgVertiaclViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"table_img_vertical_cell"];
        if(cell == nil){
            cell = (SHImgVertiaclViewCell*)[[[NSBundle mainBundle]loadNibNamed:@"SHImgVertiaclViewCell" owner:nil options:nil] objectAtIndex:0];
        }
         cell.list = [[[NSArray alloc]initWithObjects:@"2",@"5",@"3",@"1",@"6",@"2",@"7",@"2",@"1",@"4",nil]mutableCopy];
        cell.navController = self.navController;
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if (indexPath.row == 8){// 微电影
        
        SHRecomendSecondTitleCell * cell = cell = [self.tableView dequeueReusableCellWithIdentifier:@"table_recommend_second_title_cell"];
        if(cell == nil){
            cell = (SHRecomendSecondTitleCell*)[[[NSBundle mainBundle]loadNibNamed:@"SHRecomendSecondTitleCell" owner:nil options:nil] objectAtIndex:0];
        }
         cell.detail = [[NSMutableDictionary alloc]init];
        cell.btnBg.backgroundColor = [UIColor colorWithRed:18/255.0 green:196/255.0 blue:170/255.0 alpha:1];
        cell.imgLogo.image = [UIImage imageNamed:@"ic_home_movice_micro"];
        cell.labNameLogo.text = @"微电影";
        cell.labContentLogo.text = @"共1234部";
        cell.navController = self.navController;
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if (indexPath.row == 9){
        SHImgVertiaclViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"table_img_vertical_cell"];
        if(cell == nil){
            cell = (SHImgVertiaclViewCell*)[[[NSBundle mainBundle]loadNibNamed:@"SHImgVertiaclViewCell" owner:nil options:nil] objectAtIndex:0];
        }
         cell.list = [[[NSArray alloc]initWithObjects:@"2",@"1",@"3",@"4",@"5",@"2",@"6",@"7",@"2",@"4",nil]mutableCopy];
        cell.navController = self.navController;
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 10){//综艺
        SHImgHorizaonalViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"table_img_horizaonal_cell"];
        if(cell == nil){
            cell = (SHImgHorizaonalViewCell*)[[[NSBundle mainBundle]loadNibNamed:@"SHImgHorizaonalViewCell" owner:nil options:nil] objectAtIndex:0];
        }
        
        cell.navController = self.navController;
        cell.type = 0;
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{//纪录片
        SHImgHorizaonalViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"table_img_horizaonal_cell"];
        if(cell == nil){
            cell = (SHImgHorizaonalViewCell*)[[[NSBundle mainBundle]loadNibNamed:@"SHImgHorizaonalViewCell" owner:nil options:nil] objectAtIndex:0];
        }
        cell.navController = self.navController;
        cell.type = 1;
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
        csView = [[BestScrollView alloc] initWithFrame:CGRectMake(0, 0, 1024, 330)];
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
  
    [app.viewController hideSearchView:YES];

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
    SHImageView  *imageView=[[SHImageView alloc]  initWithFrame: CGRectMake(0, 0, 1024, 330)];
//    [imageView setUrl:[[imagesArray objectAtIndex:index] objectForKey:@"PicUrl"]];
    imageView.image = [UIImage imageNamed:@"bg_ad1"];
    return imageView;
}

- (void)didClickPage:(BestScrollView *)csView atIndex:(NSInteger)index
{
    
    // 进入大图
    
    SHIntent *intent = [[SHIntent alloc]init];
    intent.target = @"WebViewController";
//    [intent.args setValue:[[imagesArray objectAtIndex:index] objectForKey:@"LinkUrl"] forKeyPath:@"url"];
//    [intent.args setValue:[[imagesArray objectAtIndex:index] objectForKey:@"Title"] forKeyPath:@"title"];
    [intent.args setValue:@"http://www.wasu.cn/"  forKeyPath:@"url"];
    [intent.args setValue:@"广告" forKeyPath:@"title"];
    intent.container = self.navController;
    [[UIApplication sharedApplication]open:intent];
}
@end
