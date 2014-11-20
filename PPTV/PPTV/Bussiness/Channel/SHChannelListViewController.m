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
    mFilterView = [[[NSBundle mainBundle]loadNibNamed:@"SHFilterView" owner:nil options:nil] objectAtIndex:0];;
}
-(float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ((10-1)/5+1)*315;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}
-(SHTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHImgVertiaclViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"table_img_vertical_cell"];
    if(cell == nil){
        cell = (SHImgVertiaclViewCell*)[[[NSBundle mainBundle]loadNibNamed:@"SHImgVertiaclViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    cell.navController = self.navController;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)btnShowSearchOntouch:(UIButton *)sender {
     [mFilterView showIn:self.view :CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
}
@end
