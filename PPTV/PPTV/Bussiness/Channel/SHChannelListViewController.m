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
    mFilterView.imgArrow = imgArrow;
    mList =  [[[NSArray alloc]initWithObjects:@"1",@"1",@"1",@"4",@"5",@"6",@"2",@"3",@"5",@"6",@"3",@"2",@"1",@"6",@"3",@"2",@"1",@"3",@"2" ,nil]mutableCopy];
}
-(float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ((mList.count-1)/5+1)*315;
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
    cell.list = [mList mutableCopy];
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
     [mFilterView showIn:self.view :CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height-44)];
   
}

- (IBAction)btnSelectMainOntouch:(UIButton *)sender {
    [mFilterView close];
    switch (sender.tag ) {
        case 0:
            mList =  [[[NSArray alloc]initWithObjects:@"2",@"2",@"3",@"4",@"5",@"6",@"2",@"3",@"5",@"6",@"3",@"2",@"1",@"7",@"3",@"2",@"1",@"3",@"2" ,nil]mutableCopy];
            break;
        case 1:
            mList =  [[[NSArray alloc]initWithObjects:@"6",@"5",@"6",@"4",@"2",@"1",@"5",@"3",@"4",@"2",@"1",nil]mutableCopy];
            break;
        case 2:
            mList =  [[[NSArray alloc]initWithObjects:@"2",@"3",@"2",@"4" ,nil]mutableCopy];
            break;
            
        default:
            break;
    }
     [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    
    
}
@end
