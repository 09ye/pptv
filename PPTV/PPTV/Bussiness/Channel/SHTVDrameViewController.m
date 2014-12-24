//
//  SHTVDrameViewController.m
//  PPTV
//
//  Created by yebaohua on 14/12/1.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTVDrameViewController.h"
#import "SHDrameMoviceViewCell.h"

@interface SHTVDrameViewController ()

@end

@implementation SHTVDrameViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor];//[SHSkin.instance colorOfStyle:@"ColorBase"]
    
  
}
-(void) refresh:(NSInteger)videoID
{
    selctID = videoID;
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"Pad/iteminfo");
    [post.postArgs setValue:[NSNumber numberWithInt:videoID] forKey:@"id"];
    post.delegate = self;
    [post start:^(SHTask *task) {

        mList = [[task result]mutableCopy];
        [self.tableView reloadData];

    } taskWillTry:^(SHTask *task) {
        
    } taskDidFailed:^(SHTask *task) {
        [task.respinfo show];
    }];
}
-(void) viewWillAppear:(BOOL)animated
{
//    [super viewWillAppear:YES];
}

-(float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return mList.count;
}
-(SHTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHDrameMoviceViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"table_drame_movice_cell"];
    if(cell == nil){
        cell = (SHDrameMoviceViewCell*)[[[NSBundle mainBundle]loadNibNamed:@"SHDrameMoviceViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    NSDictionary * dic = [mList objectAtIndex:indexPath.row];
    [cell.imgDetail setUrl:[dic objectForKey:@"pic"]];
    cell.labTitle.text = [dic objectForKey:@"title"];
    cell.labContent.text = [dic objectForKey:@"focus"];
    cell.backgroundColor = [UIColor clearColor];
    if ([[dic objectForKey:@"id"]integerValue] == selctID) {

            [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    }


    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(drameDidSelect:info:)]) {
        [self.delegate drameDidSelect:self info:[mList objectAtIndex:indexPath.row]];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) setIsDownload:(BOOL)isDownload_
{
    if (isDownload_) {
        CGContextRef context=UIGraphicsGetCurrentContext();
        [UIView beginAnimations:nil context:context];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.4f];
//        mViewDownload.hidden = NO;
//        mlabTitleDown.hidden = NO;
//        CGRect rect = self.tableView.frame;
//        rect.size.height-=50;
//        self.tableView.frame = rect;
//        [self.tableView reloadData];
//        [UIView commitAnimations];
        
        [UIView animateWithDuration:0.5 animations:^{
            
            CGRect rect = self.tableView.frame;
            rect.origin.y = 34;
            rect.size.height-=74;
            
            self.tableView.frame = rect;
            [self.tableView reloadData];
            
        } completion:^(BOOL finished) {
            mViewDownload.hidden = NO;
            mlabTitleDown.hidden = NO;
            
        }];
        
    }else{
        CGContextRef context=UIGraphicsGetCurrentContext();
        [UIView beginAnimations:nil context:context];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//        [UIView setAnimationDuration:0.4f];
       
//        [UIView commitAnimations];
    
        [UIView animateWithDuration:0.5 animations:^{
            
            CGRect rect = self.tableView.frame;
            rect.size.height+=74;
            rect.origin.y = 0;
            self.tableView.frame = rect;
            [self.tableView reloadData];
            
        } completion:^(BOOL finished) {
             mViewDownload.hidden = YES;
             mlabTitleDown.hidden = YES;

        }];
    }
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
