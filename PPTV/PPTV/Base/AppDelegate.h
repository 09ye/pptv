//
//  AppDelegate.h
//  RT5030S
//
//  Created by yebaohua on 14-9-17.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "SHAppDelegate.h"
#import "ShareConfig.h"
#import <ShareSDK/ShareSDK.h>
#import "SHAnalyzeFactory.h"
#import "FileModel.h"
#import "SHFileManager.h"

//@interface SHAnalyzeFactoryExtension1 : SHAnalyzeFactoryExtension
//
//
//@end

@interface AppDelegate : SHAppDelegate<UIApplicationDelegate,BMKGeneralDelegate,WXApiDelegate,WeiboSDKDelegate,SHTaskDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,SHTaskDelegate>
{
    
    BMKMapManager* _mapManager;
    BMKLocationService * _locService;
    BMKGeoCodeSearch* _geocodesearch;
    // 微信
    enum WXScene _scene;
    // 微博
    NSString      *wbtoken;
    
    
    
}
@property (strong, nonatomic) NSString * wbtoken;
@property (nonatomic,assign) BMKUserLocation *myLocation;
@property (nonatomic,copy) BMKReverseGeoCodeResult* myAddressResult;
@property (nonatomic,strong) NSDictionary * locationDistrict;
#pragma mark - 微信
- (void)changeScene:(NSInteger)scene;
// weixin
- (void) sendTextContent:(NSString *)shareStr;

-(void)sendLoginSina:(UIViewController *)vc;


//@property(nonatomic,retain)NSMutableArray *finishedlist;//已下载完成的文件列表（文件对象）
//
//@property(nonatomic,retain)NSMutableArray *downinglist;//正在下载的文件列表(ASIHttpRequest对象)

@property(nonatomic,strong)NSMutableArray *requestlist;//caches 目录下得文件 .temp 和。MP4

@property(nonatomic,strong)NSMutableArray *cachesInfolist;//下载文件信息 id name pic url

-(void)beginRequest:(int )videoId hdType:(int)hdType isBeginDown:(BOOL)isBeginDown;




@end

