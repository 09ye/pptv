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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    
}
-(void) setList:(NSMutableArray *)list_
{
    _list = list_;
    _list = [[[NSArray alloc]initWithObjects:@"c1" ,@"c2",@"c3" ,@"c4",@"c2" ,@"c2",@"c1" ,@"c1",@"c4" ,@"c1" ,nil]mutableCopy ];
    
    [self.tableView reloadData];
    
}

-(float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
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
    cell.labTitle.text = @"浙江卫视";
    if (indexPath.row ==2) {
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
