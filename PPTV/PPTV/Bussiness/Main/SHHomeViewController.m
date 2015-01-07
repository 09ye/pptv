//
//  SHHomeViewController.m
//  PPTV
//
//  Created by yebaohua on 14/11/16.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHHomeViewController.h"
#import "SHRecommendViewController.h"
#import "SHChannelListViewController.H"
#import "SHLiveViewController.h"
#import "SHCollectViewController.h"
#import "SHRecordViewController.h"
#import "SHSettingViewController.h"
#import "SHDownloadViewController.H"

@interface SHHomeViewController ()

@end

@implementation SHHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    mDictionary = [[NSMutableDictionary alloc]init];
    
    [self tabBar:self.tabbar didSelectItem:[[self.tabbar items] objectAtIndex:0]];
    self.tabbar.selectedItem = [self.tabbar.items objectAtIndex:0];
    self.tabbar.barTintColor = [[UIColor alloc]initWithRed:38/255 green:38/255 blue:38/255 alpha:1];
    self.tabbar.selectedImageTintColor = [SHSkin.instance colorOfStyle:@"ColorTextOrg"];
    
    arrayBtn = [[NSArray alloc]initWithObjects:btnOration,btnOriginal,btnEntertainment,btnLife,btnCar,btnSports,btnTravel,btnMicroShow, nil];
    mViewRight = [[[NSBundle mainBundle]loadNibNamed:@"SHShowRightView" owner:self options:nil]objectAtIndex:0];
    
    SHPostTaskM * postKeyWord = [[SHPostTaskM alloc]init];
    postKeyWord.URL = URL_FOR(@"Pad/keywordrecom");
    postKeyWord.delegate = self;
    [postKeyWord start:^(SHTask *t) {
        
        NSMutableArray * list = [[t result]mutableCopy];
        mSearch.placeholder = [[list objectAtIndex:arc4random()%list.count] objectForKey:@"name"];
        
    } taskWillTry:^(SHTask *t) {
        
    } taskDidFailed:^(SHTask *t) {
        
        
    }];

    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    [self tabBarDidSelect:item.tag];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) tabBarDidSelect:(int) tag
{
    if(mViewRight.isShow && (tag != 9 && tag !=10)){
        [mViewRight close];
    }
    if(mIsShow ){
        [self close];
        if(tag ==8){
            return;
        }
        
    }
    SHTableViewController * nacontroller;
    if(tag == 0){
        nacontroller =[ mDictionary valueForKey:@"SHRecommendViewController"];
        if(!nacontroller){
            SHRecommendViewController * viewcontroller = [[SHRecommendViewController alloc]init];
            nacontroller = viewcontroller;
            [mDictionary setValue:nacontroller forKey:@"SHRecommendViewController"];
        }
    }else if (tag == 1){
        nacontroller =[ mDictionary valueForKey:@"SHLiveViewController"];
        //        if(!nacontroller){
        SHLiveViewController * viewcontroller = [[SHLiveViewController alloc]init];
        nacontroller = viewcontroller;
        [mDictionary setValue:nacontroller forKey:@"SHLiveViewController"];
        //        }
    }else if (tag == 2){
        nacontroller =[ mDictionary valueForKey:@"SHChannelListViewController2"];
        if(!nacontroller){
            SHChannelListViewController * viewcontroller = [[SHChannelListViewController alloc]init];
            viewcontroller.type = @{@"name":@"动漫",@"id":@"19"};
            nacontroller = viewcontroller;
            [mDictionary setValue:nacontroller forKey:@"SHChannelListViewController2"];
        }
    }else if (tag == 3){
        nacontroller =[ mDictionary valueForKey:@"SHChannelListViewController3"];
        if(!nacontroller){
            SHChannelListViewController * viewcontroller = [[SHChannelListViewController alloc]init];
            nacontroller = viewcontroller;
            viewcontroller.type = @{@"name":@"电视剧",@"id":@"11"};
            [mDictionary setValue:nacontroller forKey:@"SHChannelListViewController3"];
        }
    }else if (tag == 4){
        nacontroller =[ mDictionary valueForKey:@"SHChannelListViewController4"];
        if(!nacontroller){
            SHChannelListViewController * viewcontroller = [[SHChannelListViewController alloc]init];
            nacontroller = viewcontroller;
            viewcontroller.type = @{@"name":@"电影",@"id":@"1"};
            [mDictionary setValue:nacontroller forKey:@"SHChannelListViewController4"];
        }
    }else if (tag == 5){
        nacontroller =[ mDictionary valueForKey:@"SHChannelListViewController5"];
        if(!nacontroller){
            SHChannelListViewController * viewcontroller = [[SHChannelListViewController alloc]init];
            nacontroller = viewcontroller;
            viewcontroller.type = @{@"name":@"微电影",@"id":@"96"};
            [mDictionary setValue:nacontroller forKey:@"SHChannelListViewController5"];
        }
    }else if (tag == 6){
        nacontroller =[ mDictionary valueForKey:@"SHChannelListViewController6"];
        if(!nacontroller){
            SHChannelListViewController * viewcontroller = [[SHChannelListViewController alloc]init];
            nacontroller = viewcontroller;
            viewcontroller.type = @{@"name":@"综艺",@"id":@"37"};
            [mDictionary setValue:nacontroller forKey:@"SHChannelListViewController6"];
        }
    }else if (tag == 7){
        nacontroller =[ mDictionary valueForKey:@"SHChannelListViewController7"];
        if(!nacontroller){
            SHChannelListViewController * viewcontroller = [[SHChannelListViewController alloc]init];
            viewcontroller.type = @{@"name":@"纪录片",@"id":@"86"};
            nacontroller = viewcontroller;
            [mDictionary setValue:nacontroller forKey:@"SHChannelListViewController7"];
        }
    }else if (tag == 8){// more
        [self changeMoreViewColor:lastMoreTag];
        [self showIn:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44)];
        return;
        
    }else if (tag == 9){
        SHCollectViewController * controller = [[SHCollectViewController alloc]init];
        controller.delegate = self;
        [mViewRight show:controller inView:self.view direction:Right];
        
        return;
    }else if (tag == 10){
        
        [mViewRight show:[[SHSettingViewController alloc]init] inView:self.view direction:Right];
        return;
    }else if (tag == 100){// 下载
        nacontroller =[ mDictionary valueForKey:@"SHDownloadViewController"];
        if(!nacontroller){
            SHDownloadViewController * viewcontroller = [[SHDownloadViewController alloc]init];
//            viewcontroller.type = @{@"name":@"纪录片",@"id":@"86"};
            nacontroller = viewcontroller;
            [mDictionary setValue:nacontroller forKey:@"SHDownloadViewController"];
        }
    }
    
    if(lastnacontroller != nacontroller){
        
        ((SHRecommendViewController*)nacontroller).navController = self.navigationController;
        nacontroller.view.backgroundColor =[UIColor clearColor];
        if(tag == 0){
            nacontroller.view.frame = self.view.bounds;
            mViewContain.hidden = YES;
            [self.view insertSubview:nacontroller.view atIndex:0];
        }else if(tag == 1){
            CGRect rect = mViewContain.frame;
            //            rect.size.height +=49;
            nacontroller.view.frame = rect;
            mViewContain.hidden = YES;
            [self.view addSubview:nacontroller.view];
            [self.view bringSubviewToFront:nacontroller.view];
        }else {
            nacontroller.view.frame = mViewContain.bounds;
            mViewContain.hidden = NO;
            [mViewContain addSubview:nacontroller.view];
        }
        
        
        [lastnacontroller.view removeFromSuperview];
        lastnacontroller = nacontroller;
        lastMoreTag = 0;
    }

}

- (IBAction)btnWatchRecordOntouch:(UIButton *)sender {
   SHRecordViewController * controller = [[SHRecordViewController alloc]init];
    controller.delegate = self;
    [mViewRight show:controller inView:self.view direction:Right];
}

- (IBAction)btnDownloadOntouch:(UIButton *)sender {
    [self tabBarDidSelect:100];

}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    SHIntent * intent = [[SHIntent alloc]init];
    intent.target = @"SHSearchViewController";
    [intent.args setValue:searchBar.placeholder forKey:@"keyword"];
    intent.container = self.navigationController;
    [[UIApplication sharedApplication]open:intent];
    return NO;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [mSearch resignFirstResponder];
    
}
#pragma  more show
- (void)showIn :(CGRect)rect
{
    if(!mIsShow){
        mIsShow = YES;
        mViewMore.frame = rect;
        mViewMore.alpha = 0;
        mViewMoreContent.frame = CGRectMake( mViewMoreContent.frame.origin.x, mViewMoreContent.frame.origin.y+ mViewMoreContent.frame.size.height, mViewMoreContent.frame.size.width, mViewMoreContent.frame.size.height);
        [self.view addSubview:mViewMore];
        [self.view bringSubviewToFront:mViewMore];
        
        [UIView animateWithDuration:0.5 animations:^{
            mViewMore.alpha = 1;
            mViewMoreContent.frame = CGRectMake( mViewMoreContent.frame.origin.x, 0, mViewMoreContent.frame.size.width, mViewMoreContent.frame.size.height);
            
        } completion:^(BOOL finished) {
            
        }];
    }else{
        [self close];
    }
}

- (void)close
{
    if(mIsShow){
        mIsShow = NO;
        [UIView animateWithDuration:0.5 animations:^{
            mViewMoreContent.frame = CGRectMake( mViewMoreContent.frame.origin.x, UIScreenHeight+50, mViewMoreContent.frame.size.width, mViewMoreContent.frame.size.height);
            mViewMore.alpha = 0;
            
        } completion:^(BOOL finished) {
            [mViewMore removeFromSuperview];
        }];
        
    }
}

- (IBAction)btnCloseOnTouch:(id)sender
{
    [self close];
}

- (IBAction)btnMoreOntouch:(UIButton *)sender {
    SHTableViewController * nacontroller;
    [self changeMoreViewColor:sender.tag];
    switch (sender.tag) {
        case 21:
            nacontroller =[ mDictionary valueForKey:@"SHChannelListViewController21"];
            if(!nacontroller){
                SHChannelListViewController * viewcontroller = [[SHChannelListViewController alloc]init];
                viewcontroller.type = @{@"name":@"资讯",@"id":@"22"};

                nacontroller = viewcontroller;
                [mDictionary setValue:nacontroller forKey:@"SHChannelListViewController21"];
            }
            
            break;
        case 22:{
            nacontroller =[ mDictionary valueForKey:@"SHChannelListViewController22"];
            if(!nacontroller){
                SHChannelListViewController * viewcontroller = [[SHChannelListViewController alloc]init];
                viewcontroller.type = @{@"name":@"原创",@"id":@"91"};

                nacontroller = viewcontroller;
                [mDictionary setValue:nacontroller forKey:@"SHChannelListViewController22"];
            }
      
            break;
        }
        case 23:{
            nacontroller =[ mDictionary valueForKey:@"SHChannelListViewController23"];
            if(!nacontroller){
                SHChannelListViewController * viewcontroller = [[SHChannelListViewController alloc]init];
                viewcontroller.type = @{@"name":@"娱乐",@"id":@"26"};
                nacontroller = viewcontroller;
                [mDictionary setValue:nacontroller forKey:@"SHChannelListViewController23"];
            }
         
            break;
        }
        case 24:{
            nacontroller =[ mDictionary valueForKey:@"SHChannelListViewController24"];
            if(!nacontroller){
                SHChannelListViewController * viewcontroller = [[SHChannelListViewController alloc]init];
                viewcontroller.type = @{@"name":@"生活",@"id":@"137"};
                nacontroller = viewcontroller;
                [mDictionary setValue:nacontroller forKey:@"SHChannelListViewController24"];
            }
           
            break;
        }
        case 25:{
            nacontroller =[ mDictionary valueForKey:@"SHChannelListViewController25"];
            if(!nacontroller){
                SHChannelListViewController * viewcontroller = [[SHChannelListViewController alloc]init];
                viewcontroller.type = @{@"name":@"汽车",@"id":@"102"};
                nacontroller = viewcontroller;
                [mDictionary setValue:nacontroller forKey:@"SHChannelListViewController25"];
            }
            
            break;
        }
        case 26:{
            nacontroller =[ mDictionary valueForKey:@"SHChannelListViewController26"];
            if(!nacontroller){
                SHChannelListViewController * viewcontroller = [[SHChannelListViewController alloc]init];
                viewcontroller.type = @{@"name":@"体育",@"id":@"32"};
                nacontroller = viewcontroller;
                [mDictionary setValue:nacontroller forKey:@"SHChannelListViewController26"];
            }
            
            break;
        }
        case 27:{
            nacontroller =[ mDictionary valueForKey:@"SHChannelListViewController27"];
            if(!nacontroller){
                SHChannelListViewController * viewcontroller = [[SHChannelListViewController alloc]init];
                viewcontroller.type = @{@"name":@"旅游",@"id":@"55"};
                nacontroller = viewcontroller;
                [mDictionary setValue:nacontroller forKey:@"SHChannelListViewController27"];
            }
            
            break;
        }
        case 28:{
            nacontroller =[ mDictionary valueForKey:@"SHChannelListViewController28"];
            if(!nacontroller){
                SHChannelListViewController * viewcontroller = [[SHChannelListViewController alloc]init];
                viewcontroller.type = @{@"name":@"微秀社区",@"id":@"60"};
                nacontroller = viewcontroller;
                [mDictionary setValue:nacontroller forKey:@"SHChannelListViewController28"];
            }
            
            break;
        }            
            
        default:
            break;
    }
    if(lastnacontroller != nacontroller){
        
        ((SHRecommendViewController*)nacontroller).navController = self.navigationController;
        nacontroller.view.backgroundColor =[UIColor clearColor];
        
        nacontroller.view.frame = mViewContain.bounds;
        mViewContain.hidden = NO;
        [mViewContain addSubview:nacontroller.view];
        
        
        
        [lastnacontroller.view removeFromSuperview];
        lastnacontroller = nacontroller;
        lastMoreTag = sender.tag;
    }
    
    [self close];
    
}
-(void) changeMoreViewColor:(int)selectTag
{
    for (UIButton * button in arrayBtn) {
        if (button.tag == selectTag) {
            [button setTitleColor:[SHSkin.instance colorOfStyle:@"ColorTextOrg"] forState:UIControlStateNormal];
            
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"ic_tab_select_%d",button.tag]] forState:UIControlStateNormal];
        }else{
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"ic_tab_normal_%d",button.tag]] forState:UIControlStateNormal];
        }
    }
    
}
#pragma  deleaget
-(void)collectViewControllerDidSelect:(SHCollectViewController *)controllerr videoInfo:(NSDictionary *)dic
{
    [mViewRight close];
    SHIntent * intent = [[SHIntent alloc ]init];
    if([[dic objectForKey:@"type"]intValue] == 2){
        intent.target = @"SHLiveViewController";
    }else{
        intent.target = @"SHTVDetailViewController";
    }
    
    [intent.args setValue:dic forKey:@"detailInfo"];
    intent.container = self.navigationController;
    [[UIApplication sharedApplication] open:intent];
}
-(void)recordViewControllerDidSelect:(SHRecordViewController *)controllerr videoInfo:(NSDictionary *)dic
{
    [mViewRight close];
    SHIntent * intent = [[SHIntent alloc ]init];
    intent.target = @"SHTVDetailViewController";
    [intent.args setValue:dic forKey:@"detailInfo"];
    intent.container = self.navigationController;
    [[UIApplication sharedApplication] open:intent];
}

@end
