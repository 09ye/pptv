//
//  SHSettingViewController.m
//  PPTV
//
//  Created by yebaohua on 14/12/19.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHSettingViewController.h"
#import "SHSettingCell.h"

@interface SHSettingViewController ()

@end

@implementation SHSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.view.backgroundColor = [SHSkin.instance colorOfStyle:@"ColorBackGroundRightView"];
    self.tableView.backgroundColor = [UIColor clearColor];
     self.tableView.layer.cornerRadius= 5;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configUpdate:) name:CORE_NOTIFICATION_CONFIG_STATUS_CHANGED object:nil];
}


- (void)configUpdate:(NSObject*)sender
{
    if(![SHConfigManager.instance show]){
        [self showAlertDialog:@"当前已为最新版本"];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 10;
}
- (int) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
   
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 320, 44)];
    label.textAlignment = NSTextAlignmentLeft;
    label.backgroundColor = [SHSkin.instance colorOfStyle:@"ColorBackGroundRightView"];
    return label;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }else if (section == 1){
        return 2;
    }else if(section == 2){
        return 5;
    }
    return 1;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 30;
        }else{
            return 50;
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            return 30;
        }else{
            return 50;
        }
    }else if(indexPath.section == 2){
        return 50;
    }
    return 50;;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    SHSettingCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"table_setting_cell"];
    if(cell == nil){
        cell = (SHSettingCell*)[[[NSBundle mainBundle]loadNibNamed:@"SHSettingCell" owner:nil options:nil] objectAtIndex:0];
    }
    if (indexPath.section == 0) {
        if(indexPath.row == 0){
            cell.labTitle.text = @"非wifi网络播放提醒";
            cell.labTitle.userstyle = @"labminlight";
            cell.userInteractionEnabled = NO;
        }else if (indexPath.row == 1){
            cell.labTitle.text = @"每次提醒";
            cell.imgChoose.hidden = [[NSUserDefaults standardUserDefaults] boolForKey:@"one_notic"];
            cell.imgChoose.image = [UIImage imageNamed:@"logo"];
        }else{
            cell.labTitle.text = @"提醒一次";
            cell.imgChoose.hidden = ![[NSUserDefaults standardUserDefaults] boolForKey:@"one_notic"];
            cell.viewLine.hidden = YES;
            cell.imgChoose.image = [UIImage imageNamed:@"logo"];
        }

    }else if (indexPath.section == 1){
        if(indexPath.row == 0){
            cell.labTitle.text = @"接受新消息通知";
            cell.labTitle.userstyle = @"labminlight";
            cell.labContent.text = @"已关闭";
            cell.labContent.hidden = NO;
            cell.userInteractionEnabled = NO;
        }else if (indexPath.row == 1){
            cell.labTitle.text = @"请在您的设备\"设置-通知-华数TV\"中更改";
             cell.viewLine.hidden = YES;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }

    }else if(indexPath.section == 2){
        if(indexPath.row == 0){
            cell.labTitle.text = @"清除图片缓存";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }else if (indexPath.row == 1){
            cell.labTitle.text = @"检查版本更新";
            cell.labContent.text = [NSString stringWithFormat:@"当前版本V%@",SHEntironment.instance.version.description];
            cell.labContent.hidden = NO;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }else if (indexPath.row == 2){
            cell.labTitle.text = @"为我打分";
            cell.imgChoose.hidden = NO;
            


        }else if (indexPath.row == 3){
            cell.labTitle.text = @"意见反馈";
            cell.imgChoose.hidden = NO;
        }else if (indexPath.row == 4){
            cell.labTitle.text = @"关于我们";
            cell.imgChoose.hidden = NO;
            cell.viewLine.hidden = YES;
        }

    }


    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"one_notic"];
        }else if(indexPath.row == 2){
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"one_notic"];
        }
        [self.tableView reloadData];
    }else if (indexPath.section ==2){
        if (indexPath.row == 0) {
            
        }else if (indexPath.row ==1){
            [SHConfigManager.instance refresh];
        }else if (indexPath.row ==2){
            NSString *str = [NSString stringWithFormat:
                             @"https://itunes.apple.com/cn/app/offer/id914425168?mt=8"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }else if (indexPath.row ==3){
            SHIntent * intent  =[[SHIntent alloc]init];
            intent.target = @"SHFeedbackViewController";
            intent.container  = self.navigationController;
            [[UIApplication sharedApplication]open:intent];
        }else if (indexPath.row ==4){
            SHIntent * intent  =[[SHIntent alloc]init];
            intent.target = @"SHAboutViewController";
            intent.container  = self.navigationController;
          [[UIApplication sharedApplication]open:intent];
        }
    }
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
