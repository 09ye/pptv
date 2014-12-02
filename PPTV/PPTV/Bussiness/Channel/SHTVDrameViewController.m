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
    _list = [[[NSArray alloc]initWithObjects:@"movice3" ,@"movice2",@"movice1" ,@"movice2",@"movice3" ,@"movice2",@"movice1" ,@"movice3",@"movice1" ,@"movice2" ,nil]mutableCopy ];
  
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
