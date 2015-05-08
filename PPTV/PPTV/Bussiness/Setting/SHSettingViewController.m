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
{

    NSString *appUrl;
}

@end

@implementation SHSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.view.backgroundColor = [SHSkin.instance colorOfStyle:@"ColorBackGroundRightView"];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.layer.cornerRadius= 5;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configUpdate:) name:CORE_NOTIFICATION_CONFIG_STATUS_CHANGED object:nil];
    [SHStatisticalData requestDmalog:self.title];
   
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
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
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
            cell.imgChoose.image = [UIImage imageNamed:@"ic_select.png"];
        }else{
            cell.labTitle.text = @"提醒一次";
            cell.imgChoose.hidden = ![[NSUserDefaults standardUserDefaults] boolForKey:@"one_notic"];
            cell.viewLine.hidden = YES;
            cell.imgChoose.image = [UIImage imageNamed:@"ic_select.png"];
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
            cell.labTitle.text = @"清除缓存";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }else if (indexPath.row == 1){
            cell.labTitle.text = @"检查版本更新";
            cell.labContent.text = [NSString stringWithFormat:@"当前版本V%@",SHEntironment.instance.version.description];
            cell.labContent.hidden = NO;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            
        }else if (indexPath.row == 2){
            cell.viewLine.hidden = YES;
            cell.labTitle.text = @"为我打分";
            cell.imgChoose.hidden = NO;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }else if (indexPath.row == 3){
            cell.labTitle.text = @"意见反馈";
            cell.imgChoose.hidden = NO;
        }else if (indexPath.row == 4){
            cell.labTitle.text = @"关于我们";
            cell.imgChoose.hidden = NO;
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
            [self showAlertDialog:@"删除之后可能会降低流畅度,请三思啊" button:@"取消" otherButton:@"清除" tag:10000];
        }else if (indexPath.row ==1){
            [SHConfigManager.instance refresh];
//            SHPostTask * post = [[SHPostTask alloc]init];
//            post.URL = URL_UPDATE_APP;
//            [post start:^(SHTask *task) {
//                NSDictionary * dic = [task.result mutableCopy];
//                NSArray * array  = [dic objectForKey:@"results"];
//                if (array.count > 0) {
//                    NSDictionary * result = [array objectAtIndex:0];
//                    NSString *newVersion = [result objectForKey:@"version"];
//                    appUrl = [result objectForKey:@"trackViewUrl"];
//                    NSString *localVersion =[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
//                    if ([newVersion floatValue] > [localVersion floatValue]) {
//                        [self showAlertDialog:@"检查到版本更新" button:@"现在升级" otherButton:@"下次再说" tag:10001];
//                    }else{
//                        [self showAlertDialog:@"当前已为最新版本"];
//
//                    }
//                }else{
//                    [self showAlertDialog:@"当前已为最新版本"];
//
//                }
//                
//            } taskWillTry:^(SHTask *task) {
//                
//            } taskDidFailed:^(SHTask *task) {
//                
//            }];
        }else if (indexPath.row ==2){
            
            NSString *str = [NSString stringWithFormat:
                             @"https://itunes.apple.com/cn/app/hua-shutv-wang/id979565161?mt=8&uo=4"];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 10000) {
        if(buttonIndex == 0){
            dispatch_async(
                           
                           dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                           , ^{
                               
                               NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
                               
                               
                               NSFileManager*  filemgr =[NSFileManager defaultManager];
                               NSArray *files = [filemgr subpathsAtPath:cachPath];
                               
                               NSLog(@"files :%d",[files count]);
                               float cacheSize = 0;
                               
                               for (NSString *p in files) {
                                   
                                   NSError *error;
                                   
                                   NSString *path = [cachPath stringByAppendingPathComponent:p];
                                   
                                   if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                                       long long size = [[filemgr attributesOfItemAtPath:[NSString stringWithFormat:@"%@/%@",cachPath,p] error:nil] fileSize];
                                       if(size){
                                           cacheSize = cacheSize + size;
                                       }
                                       
                                       [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                                       
                                       
                                   }
                                   
                               }
                               
                               [self performSelectorOnMainThread:@selector(clearCacheSuccess:) withObject:[NSString stringWithFormat:@"为您节省%0.1fM空间",(cacheSize/1024.0/1024.0)] waitUntilDone:YES];});
        }else if (buttonIndex == 1){

        }

    }else if (alertView.tag == 10001){
         if(buttonIndex == 0){
             [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appUrl]];
         }
    }
    
    
}
-(void) clearCacheSuccess:(NSString *) message
{
    [self showAlertDialog:message];
}
@end
