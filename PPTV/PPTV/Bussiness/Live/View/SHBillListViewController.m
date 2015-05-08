//
//  SHBillListViewController.m
//  PPTV
//
//  Created by yebaohua on 14/12/15.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHBillListViewController.h"
#import "SHBillCell.h"

@interface SHBillListViewController ()

@end

@implementation SHBillListViewController
@synthesize list = _list;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    if(_list.count>0){
        mlabNodata.hidden = YES;
    }else{
        mlabNodata.hidden = NO;
    }
    
}
-(void) refreBill:(NSString *)date detail:(NSDictionary *)dic
{
    
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"Pad/livebill");
    [post.postArgs setValue:[dic objectForKey:@"id"] forKey:@"id"];
    [post.postArgs setValue:date forKey:@"date"];
    [post.postArgs setValue:SHEntironment.instance.version.description forKey:@"version"];
    post.delegate = self;
    [post start:^(SHTask *task) {
        NSDictionary * dic   =[[task result]mutableCopy];
        self.list = [dic objectForKey:@"list"];
        [self.tableView reloadData];
        
    } taskWillTry:^(SHTask *task) {
        
    } taskDidFailed:^(SHTask *task) {
        self.list = [[NSMutableArray alloc]init];
        [self.tableView reloadData];
        
    }];
}
-(void) setList:(NSMutableArray *)list_
{
    _list = list_;
    if(_list.count>0){
        mlabNodata.hidden = YES;
        
    }else{
        mlabNodata.hidden = NO;
    }
    [self.tableView reloadData];
    
    
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _list.count;
}
-(SHTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHBillCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"table_bill_cell"];
    if(cell == nil){
        cell = (SHBillCell*)[[[NSBundle mainBundle]loadNibNamed:@"SHBillCell" owner:nil options:nil] objectAtIndex:0];
    }
    NSDictionary * dic = [_list objectAtIndex:indexPath.row];
    NSDateFormatter *dataformart = [[NSDateFormatter alloc]init];
    [dataformart setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dataformart dateFromString:[dic objectForKey:@"starttime"]];
    NSDate *nextdate = [NSDate date];
    if (_list.count >indexPath.row +1) {
        nextdate = [dataformart dateFromString:[[_list objectAtIndex:indexPath.row+1] objectForKey:@"starttime"]];
    }
   
    NSString *dateString = [dataformart stringFromDate:[NSDate date]];
    [dataformart setDateFormat:@"HH:mm"];
    cell.labTitle.text = [NSString stringWithFormat:@"%@  %@",[dataformart stringFromDate:date],[dic objectForKey:@"title"]];
    if ([date timeIntervalSinceDate:[NSDate date]]<0.0  && [nextdate timeIntervalSinceDate:[NSDate date]]>0.0) {
        cell.labContent.hidden = NO;
        cell.backgroundColor = [SHSkin.instance colorOfStyle:@"ColorBaseBackGround"];

    }else{
        cell.labContent.hidden = YES;
        cell.backgroundColor = [UIColor clearColor];
    }
    
    cell.selected = YES;
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
