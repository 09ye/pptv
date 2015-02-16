//
//  SHCollectViewController.m
//  PPTV
//
//  Created by yebaohua on 14/12/13.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHCollectViewController.h"
#import "SHCollectCell.h"

@interface SHCollectViewController ()

@end

@implementation SHCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收藏记录";
    [SHStatisticalData requestDmalog:self.title];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" target:self action:@selector(btnEdit)];
    self.view.backgroundColor = [SHSkin.instance colorOfStyle:@"ColorBackGroundRightView"];
    self.tableView.backgroundColor = [UIColor clearColor];
    NSData * data  = [[NSUserDefaults standardUserDefaults] valueForKey:COLLECT_LIST];
    if (data) {
        mList = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    
    mArraySelect = [[NSMutableArray alloc]init];
    
   
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mList.count+1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SHCollectCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"table_collect_cell"];
    if(cell == nil){
        cell = (SHCollectCell*)[[[NSBundle mainBundle]loadNibNamed:@"SHCollectCell" owner:nil options:nil] objectAtIndex:0];
    }
    if (indexPath.row == 0) {

        cell.labTitle.text =[NSString stringWithFormat:@"已有%d/50条收藏记录   ",mList.count];
        cell.labTitle.textAlignment = NSTextAlignmentCenter;
        cell.labTitle.userstyle = @"labmiddark";

    }else{
        NSDictionary * dic = [mList objectAtIndex:indexPath.row-1];
        cell.labTitle.text = [dic objectForKey:@"title"];
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
    
    [mList removeObjectAtIndex:indexPath.row-1];
    [self.tableView reloadData];
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:mList];
    [[NSUserDefaults standardUserDefaults ] setValue:data forKey:COLLECT_LIST];
    [[NSUserDefaults standardUserDefaults]synchronize];

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < 1) {
        return ;
    }
    NSDictionary * dic = [mList objectAtIndex:indexPath.row-1];
    if(self.delegate && [self.delegate respondsToSelector:@selector(collectViewControllerDidSelect:videoInfo:)]){
        [self.delegate collectViewControllerDidSelect:self videoInfo:dic];
    }
    
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cornerRadius = 5.f;
    if (indexPath.row == 0)
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

-(void) btnCollectSelect:(UIButton *)sender
{
     NSIndexPath *te=[NSIndexPath indexPathForRow:sender.tag inSection:0];
     NSDictionary * dic = [mList objectAtIndex:sender.tag-1];
    if([mArraySelect containsObject:dic]){
        [mArraySelect removeObject:dic];
       
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:te,nil] withRowAnimation:UITableViewRowAnimationNone];
    }else{
        [mArraySelect addObject:dic];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:te,nil] withRowAnimation:UITableViewRowAnimationNone];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)btnDeleteOntouch:(id)sender {
    [mList removeObjectsInArray:mArraySelect];
    [self.tableView reloadData];
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:mList];
    [[NSUserDefaults standardUserDefaults ] setValue:data forKey:COLLECT_LIST];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (IBAction)btnClearAllOntouch:(id)sender {
    [mList removeAllObjects];
    [self.tableView reloadData];
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:mList];
    [[NSUserDefaults standardUserDefaults ] setValue:data forKey:COLLECT_LIST];
    [[NSUserDefaults standardUserDefaults]synchronize];

}

- (IBAction)btnCancaleOntouch:(id)sender {
   [mArraySelect  removeAllObjects];
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
@end
