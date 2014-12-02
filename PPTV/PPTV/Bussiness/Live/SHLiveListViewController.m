//
//  SHLiveListViewController.m
//  PPTV
//
//  Created by yebaohua on 14/12/1.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHLiveListViewController.h"
#import "SHDrameMoviceViewCell.h"

@interface SHLiveListViewController ()

@end

@implementation SHLiveListViewController
@synthesize  list = _list;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundColor = [SHSkin.instance colorOfStyle:@"ColorBase"];
    
    
}
-(void) setList:(NSMutableArray *)list_
{
    _list = list_;
    _list = [[[NSArray alloc]initWithObjects:@"c1" ,@"c2",@"c3" ,@"c4",@"c2" ,@"c2",@"c1" ,@"c1",@"c4" ,@"c1" ,nil]mutableCopy ];
    
    [self.tableView reloadData];
    
}

-(float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _list.count;
}
-(SHTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHDrameMoviceViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"table_drame_movice_cell"];
    if(cell == nil){
        cell = (SHDrameMoviceViewCell*)[[[NSBundle mainBundle]loadNibNamed:@"SHDrameMoviceViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    cell.imgDetail.image = [UIImage imageNamed:[_list objectAtIndex:indexPath.row]];
    cell.labTitle.text = @"浙江卫视";
    cell.labContent.text = @"16:18 倚天屠龙记";
    cell.backgroundColor = [UIColor clearColor];
    cell.selected = YES;
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
