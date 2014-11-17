//
//  SHRecommendViewController.m
//  PPTV
//
//  Created by yebaohua on 14/11/16.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHRecommendViewController.h"
#import "SHBestAdCell.h"

@interface SHRecommendViewController ()

@end

@implementation SHRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    mListItme = [[NSArray alloc]initWithObjects:@"",@"精彩专题",@"今日热点",@"热播电影",@"同步剧场",@"小编推荐",@"精品推荐",nil];
    self.tableView.backgroundColor = [UIColor clearColor];
    SHPostTask * post = [[SHPostTaskM alloc]init];
    post.URL = @"http://mobile.9191offer.com/getguidepic";
    post.delegate = self;
    [post start:^(SHTask *t) {
        imagesArray = [[t result]mutableCopy];
        [self.tableView reloadData];
    } taskWillTry:^(SHTask *t) {
        
    } taskDidFailed:^(SHTask *t) {
        
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return CELL_GENERAL_HEIGHT3;
}
- (int) numberOfSectionsInTableView:(UITableView *)tableView
{
    return mListItme.count;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return  [[UIView alloc]init];
    }
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 320, 44)];
    label.userstyle = @"labmidmilk";
    label.text = [mListItme objectAtIndex:section];
    label.textAlignment = NSTextAlignmentLeft;
    return label;
}
-(float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.section == 0) {
        return 330;
    }
    return 50;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return 1;
}

-(SHTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHTableViewGeneralCell * cell = [self.tableView dequeueReusableGeneralCell];
    if (indexPath.section == 0) {
    
        SHBestAdCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"table_bestad_cell"];
        if(cell == nil){
            cell = (SHBestAdCell*)[[[NSBundle mainBundle]loadNibNamed:@"SHBestAdCell" owner:nil options:nil] objectAtIndex:0];
        }
//        imagesArray=[NSMutableArray arrayWithArray:mListItme];
        if(imagesArray.count>0){
            [cell.contentView insertSubview:[self showScrollView:imagesArray WithAnimation:YES] atIndex:0];
        }
        cell.backgroundColor = [UIColor clearColor];
        return cell;
        
    }
    cell.backgroundColor = [UIColor clearColor];
    return cell;
    
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
    
    return  csView;
}
#pragma  mark BestView Delegate Data=source

- (NSInteger)numberOfPages
{
    csView.pageControl.numberOfPages=imagesCount;
    
    return imagesCount;
}

- (UIView *)pageAtIndex:(NSInteger)index
{
    NSLog(@"%d",index);
    SHImageView  *imageView=[[SHImageView alloc]  initWithFrame: CGRectMake(0, 0, 1024, 330)];
    [imageView setUrl:[[imagesArray objectAtIndex:index] objectForKey:@"PicUrl"]];
    
    return imageView;
}

- (void)didClickPage:(BestScrollView *)csView atIndex:(NSInteger)index
{
    
    // 进入大图
    
    SHIntent *intent = [[SHIntent alloc]init];
    intent.target = @"WebViewController";
    [intent.args setValue:[[imagesArray objectAtIndex:index] objectForKey:@"LinkUrl"] forKeyPath:@"url"];
    [intent.args setValue:[[imagesArray objectAtIndex:index] objectForKey:@"Title"] forKeyPath:@"title"];
    intent.container = self.navigationController;
    [[UIApplication sharedApplication]open:intent];
}
@end
