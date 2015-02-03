//
//  SHRecordViewController.m
//  PPTV
//
//  Created by yebaohua on 14/12/13.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHRecordViewController.h"
#import "SHRecordCell.h"

@interface SHRecordViewController ()

@end

@implementation SHRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"播放记录";
    [SHStatisticalData requestDmalog:self.title];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" target:self action:@selector(btnEdit)];
    self.view.backgroundColor = [SHSkin.instance colorOfStyle:@"ColorBackGroundRightView"];
    self.tableView.backgroundColor = [UIColor clearColor];
    // date:2013-12-12 duration:12334 currentPos:xx title;xx id:xxx
    NSData * data  = [[NSUserDefaults standardUserDefaults] valueForKey:RECORD_LIST];
    if (data) {
        mList = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    mArraySelect = [[NSMutableArray alloc]init];
    [self createSection];
    
    
}
-(void) btnEdit
{
    mArraySelect = [[NSMutableArray alloc]init];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" target:self action:@selector(btnEdit)];
    CGContextRef context=UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.4f];
    mViewDelete.hidden = NO;
    CGRect rect = self.tableView.frame;
    rect.size.height-=50;
    self.tableView.frame = rect;
    [self.tableView reloadData];
    [UIView commitAnimations];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return  mSection.allKeys.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return  10;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return  [[mSection objectForKey:@"today"] count]+1;
    }else if (section == 1){
        return [[mSection objectForKey:@"yesterday"] count]+1;
    }else{
        return [[mSection objectForKey:@"early"] count]+1;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row ==0){
        return 30;
    }
    return 50;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SHRecordCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"table_record_cell"];
    if(cell == nil){
        cell = (SHRecordCell*)[[[NSBundle mainBundle]loadNibNamed:@"SHRecordCell" owner:nil options:nil] objectAtIndex:0];
    }
    if(indexPath.section == 0){
        if (indexPath.row == 0) {
            SHTableViewGeneralCell * cell = [tableView dequeueReusableGeneralCell];
            cell.labTitle.text = @"        今天";
            cell.labTitle.userstyle = @"labminlight";
            cell.backgroundColor =  [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
            cell.accessoryType = UITableViewCellAccessoryNone;
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
        }else{
            NSDictionary * dic = [[mSection objectForKey:@"today"] objectAtIndex:indexPath.row-1];
            cell.labTitle.text = [dic objectForKey:@"title"];
            cell.labContent.text = [self timeToHumanString:[[dic objectForKey:@"currentPos"]longValue] total:[[dic objectForKey:@"duration"]longValue] ];
            if (!mViewDelete.hidden) {
                cell.btnSelect.hidden = NO;
            }else{
                cell.btnSelect.hidden = YES;
            }
            [cell.btnSelect addTarget:self action:@selector(btnCollectSelect:) forControlEvents:UIControlEventTouchUpInside];
            cell.btnSelect.tag = indexPath.row;
            if([mArraySelect containsObject:dic]){
                [cell.btnSelect setBackgroundImage:[UIImage imageNamed:@"btn_collect_list_select.png"] forState:UIControlStateNormal];
            }else{
                [cell.btnSelect setBackgroundImage:[UIImage imageNamed:@"btn_collect_list_normal.png"] forState:UIControlStateNormal];
            }
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            SHTableViewGeneralCell * cell = [tableView dequeueReusableGeneralCell];
            cell.labTitle.text = @"        昨天";
            cell.labTitle.userstyle = @"labminlight";
            cell.backgroundColor =  [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
            cell.accessoryType = UITableViewCellAccessoryNone;
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return  cell;
        }else{
            NSDictionary * dic = [[mSection objectForKey:@"yesterday"] objectAtIndex:indexPath.row-1];
            cell.labTitle.text = [dic objectForKey:@"title"];
            
            cell.labContent.text = [self timeToHumanString:[[dic objectForKey:@"currentPos"]longValue] total:[[dic objectForKey:@"duration"]longValue] ];
            if (!mViewDelete.hidden) {
                cell.btnSelect.hidden = NO;
            }else{
                cell.btnSelect.hidden = YES;
            }
            [cell.btnSelect addTarget:self action:@selector(btnCollectSelect2:) forControlEvents:UIControlEventTouchUpInside];
            cell.btnSelect.tag = indexPath.row;
            if([mArraySelect containsObject:dic]){
                [cell.btnSelect setBackgroundImage:[UIImage imageNamed:@"btn_collect_list_select.png"] forState:UIControlStateNormal];
            }else{
                [cell.btnSelect setBackgroundImage:[UIImage imageNamed:@"btn_collect_list_normal.png"] forState:UIControlStateNormal];
            }
        }
    }else{
        if (indexPath.row == 0) {
            SHTableViewGeneralCell * cell = [tableView dequeueReusableGeneralCell];
            cell.labTitle.text = @"        更早";
            cell.labTitle.userstyle = @"labminlight";
            cell.backgroundColor =  [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
            cell.accessoryType = UITableViewCellAccessoryNone;
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return  cell;
        }else{
            NSDictionary * dic = [[mSection objectForKey:@"early"] objectAtIndex:indexPath.row-1];
            cell.labTitle.text = [dic objectForKey:@"title"];
            
            cell.labContent.text = [self timeToHumanString:[[dic objectForKey:@"currentPos"]longValue] total:[[dic objectForKey:@"duration"]longValue] ];
            if (!mViewDelete.hidden) {
                cell.btnSelect.hidden = NO;
            }else{
                cell.btnSelect.hidden = YES;
            }
            [cell.btnSelect addTarget:self action:@selector(btnCollectSelect3:) forControlEvents:UIControlEventTouchUpInside];
            cell.btnSelect.tag = indexPath.row;
            if([mArraySelect containsObject:dic]){
                [cell.btnSelect setBackgroundImage:[UIImage imageNamed:@"btn_collect_list_select.png"] forState:UIControlStateNormal];
            }else{
                [cell.btnSelect setBackgroundImage:[UIImage imageNamed:@"btn_collect_list_normal.png"] forState:UIControlStateNormal];
            }
        }
    }
    
    
    cell.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row ==0) {
        return NO;
    }
    return YES;
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {// 删除
    NSDictionary * dicDelete ;
    if (indexPath.section == 0) {
        dicDelete = [[mSection objectForKey:@"today"] objectAtIndex:indexPath.row-1];
    }else if (indexPath.section == 1){
        dicDelete = [[mSection objectForKey:@"yesterday"]objectAtIndex:indexPath.row-1];
    }else{
        dicDelete =[[mSection objectForKey:@"early"]objectAtIndex:indexPath.row-1];
    }
    [Utility removeObject:mList forKey:@"id" forValue:[dicDelete objectForKey:@"id"]];
   [self createSection];

    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:mList];
    [[NSUserDefaults standardUserDefaults ] setValue:data forKey:RECORD_LIST];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < 1) {
        return ;
    }
    NSDictionary * dic ;
    if (indexPath.section == 0) {
        dic = [[mSection objectForKey:@"today"] objectAtIndex:indexPath.row-1];
    }else if (indexPath.section == 1){
        dic = [[mSection objectForKey:@"yesterday"]objectAtIndex:indexPath.row-1];
    }else{
        dic =[[mSection objectForKey:@"early"]objectAtIndex:indexPath.row-1];
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(recordViewControllerDidSelect:videoInfo:)]){
        [self.delegate recordViewControllerDidSelect:self videoInfo:dic];
    }
}

-(void) btnCollectSelect:(UIButton *)sender
{
    NSIndexPath *te=[NSIndexPath indexPathForRow:sender.tag inSection:0];
    NSDictionary * dicDelete = [[mSection objectForKey:@"today"] objectAtIndex:sender.tag-1];
    if([mArraySelect containsObject:dicDelete]){
        [mArraySelect removeObject:dicDelete];
        
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:te,nil] withRowAnimation:UITableViewRowAnimationNone];
    }else{
        [mArraySelect addObject:dicDelete];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:te,nil] withRowAnimation:UITableViewRowAnimationNone];
    }
}
-(void) btnCollectSelect2:(UIButton *)sender
{
    NSIndexPath *te=[NSIndexPath indexPathForRow:sender.tag inSection:1];
    NSDictionary * dicDelete = [[mSection objectForKey:@"yesterday"] objectAtIndex:sender.tag-1];
    if([mArraySelect containsObject:dicDelete]){
        [mArraySelect removeObject:dicDelete];
        
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:te,nil] withRowAnimation:UITableViewRowAnimationNone];
    }else{
        [mArraySelect addObject:dicDelete];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:te,nil] withRowAnimation:UITableViewRowAnimationNone];
    }
}
-(void) btnCollectSelect3:(UIButton *)sender
{
    NSIndexPath *te=[NSIndexPath indexPathForRow:sender.tag inSection:3];
    NSDictionary * dicDelete = [[mSection objectForKey:@"early"] objectAtIndex:sender.tag-1];
    if([mArraySelect containsObject:dicDelete]){
        [mArraySelect removeObject:dicDelete];
        
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:te,nil] withRowAnimation:UITableViewRowAnimationNone];
    }else{
        [mArraySelect addObject:dicDelete];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:te,nil] withRowAnimation:UITableViewRowAnimationNone];
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cornerRadius = 5.f;
    if([tableView numberOfRowsInSection:indexPath.section] == 1)
    {
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        //        maskLayer.frame = cell.bounds;
        maskLayer.path = maskPath.CGPath;
        cell.layer.mask = maskLayer;
        
    }else if (indexPath.row == 0)
    {   //最顶端的Cell
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        //        maskLayer.frame = cell.bounds;
        maskLayer.path = maskPath.CGPath;
        cell.layer.mask = maskLayer;
    }
    else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1)
    {   //最底端的Cell
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius )];
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        
        maskLayer.path = maskPath.CGPath;
        cell.layer.mask = maskLayer;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)btnDeleteOntouch:(id)sender {
    [mList removeObjectsInArray:mArraySelect];
    [self createSection];
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:mList];
    [[NSUserDefaults standardUserDefaults ] setValue:data forKey:RECORD_LIST];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (IBAction)btnClearAllOntouch:(id)sender {
    [mList removeAllObjects];
    [self createSection];
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:mList];
    [[NSUserDefaults standardUserDefaults ] setValue:data forKey:RECORD_LIST];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}

- (IBAction)btnCancaleOntouch:(id)sender {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" target:self action:@selector(btnEdit)];
    CGContextRef context=UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.4f];
    mViewDelete.hidden = YES;
    CGRect rect = self.tableView.frame;
    rect.size.height+=50;
    self.tableView.frame = rect;
    [self.tableView reloadData];
    [UIView commitAnimations];
}
-(void) createSection
{
    mSection = [[NSMutableDictionary alloc]init];
    NSString * today = [NSDate stringFromDate:[NSDate date] withFormat:@"yyyy-MM-dd"];
    NSString * yesterday = [NSDate stringFromDate:[[NSDate date]addDay:-1 ] withFormat:@"yyyy-MM-dd"];
    
    for (NSDictionary * dic in mList) {
        if([[dic objectForKey:@"date"] caseInsensitiveCompare:today] == NSOrderedSame) {//今天
            NSMutableArray * array = [mSection objectForKey:@"today"];
            if (!array) {
                array  =[[NSMutableArray alloc]init];
                [mSection setValue:array forKey:@"today"];
            }
            [array addObject:dic];
            
        }else if([[dic objectForKey:@"date"] caseInsensitiveCompare:yesterday] == NSOrderedSame){//昨天
            NSMutableArray * array = [mSection objectForKey:@"yesterday"];
            if (!array) {
                array  =[[NSMutableArray alloc]init];
                [mSection setValue:array forKey:@"yesterday"];
            }
            [array addObject:dic];
            
        }else{// 更早
            NSMutableArray * array = [mSection objectForKey:@"early"];
            if (!array) {
                array  =[[NSMutableArray alloc]init];
                [mSection setValue:array forKey:@"early"];
            }
            [array addObject:dic];
        }
    }
    [self.tableView reloadData];
}
-(NSString *)timeToHumanString:(unsigned long)ms  total:(unsigned long)total
{
    unsigned long seconds, h, m, s;
    char buff[128] = { 0 };
    NSString *nsRet = nil;
    
    seconds = ms / 1000;
    h = seconds / 3600;
    m = (seconds - h * 3600) / 60;
    s = seconds - h * 3600 - m * 60;
    snprintf(buff, sizeof(buff), "%02ld:%02ld:%02ld", h, m, s);
    nsRet = [[NSString alloc] initWithCString:buff
                                     encoding:NSUTF8StringEncoding];
    
    if(ms>0 && total-ms<3000){
        return [NSString stringWithFormat:@"已看完"];
    }else if(h>0){
        return [NSString stringWithFormat:@"观看至%ld小时%ld分钟",h,m];
    }else if(h == 0 && m > 2){
        return [NSString stringWithFormat:@"观看至%ld分钟",m];
    }
    return @"观看不足1分钟";
}
@end
