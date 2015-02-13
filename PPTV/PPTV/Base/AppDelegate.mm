//
//  AppDelegate.m
//  crowdfunding-arcturus
//
//  Created by WSheely on 14-4-8.
//  Copyright (c) 2014年 WSheely. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WeiboApi.h"
#import "ASIHTTPRequest.h"
#import "SHDownloadCollectionViewCell.h"



@implementation AppDelegate
@synthesize myAddressResult;
@synthesize locationDistrict;
@synthesize wbtoken;
static bool __isupdate = NO;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    //    [SHAnalyzeFactory setAnalyExtension:[[SHAnalyzeFactoryExtension1 alloc]init]];
#ifdef DEBUG
    [SHTask pull:URL_HEADER newUrl:URL_DEVELOPER];
#endif
    // Override point for customization after application launch.
    
    
    //
    //    // 新浪微博
    //    [WeiboSDK enableDebugMode:YES];
    //    [WeiboSDK registerApp:APPID_Sina];
    //
    //    [WXApi  registerApp:APPID_WeoXin];
    //    //需要注意的是，SendMessageToWXReq的scene成员，如果scene填WXSceneSession，那么消息会发送至微信的会话内。如果scene填WXSceneTimeline，那么消息会发送至朋友圈。如果scene填WXSceneFavorite,那么消息会发送到“我的收藏”中。scene默认值为WXSceneSession。
    //    _scene = WXSceneTimeline;
    //    _mapManager = [[BMKMapManager alloc]init];
    //    _locService = [[BMKLocationService alloc]init];
    //    _locService.delegate = self;
    //    _geocodesearch = [[BMKGeoCodeSearch alloc]init];
    //    _geocodesearch.delegate = self;
    //
    //    BOOL ret = [_mapManager start:@"XUhLsGNq9Ch1HfTgZH8LFZs8"  generalDelegate:self];// ybh ky
    ////zambon key  RNuxCab28lK3wgb3jGhsrpa3
    //    if (!ret) {
    //        NSLog(@"manager start failed!");
    //    }
    [super application:application didFinishLaunchingWithOptions:launchOptions];
    //    [_locService startUserLocationService];
    //
    //
    //    [ShareSDK registerApp:@"24732465ea3a"];     //参数为ShareSDK官网中添加应用后得到的AppKey
    //
    //
    //    [ShareSDK connectSinaWeiboWithAppKey:APPID_Sina
    //                               appSecret:APPID_KEY_Sina
    //                             redirectUri:Sina_RedirectURI];
    //
    //    [ShareSDK connectQQWithQZoneAppKey:@"100371282"
    //                     qqApiInterfaceCls:[QQApiInterface class]
    //                       tencentOAuthCls:[TencentOAuth class]];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configUpdate:) name:CORE_NOTIFICATION_CONFIG_STATUS_CHANGED object:nil];
    [SHConfigManager instance];
    //    [SHConfigManager instance].URL = URL_FOR(@"get_config");
    
    //    [self loadCachesfiles];
    
    [self loadCacheList];
    return YES;
}
- (void)configUpdate:(NSObject*)sender
{
    [SHConfigManager.instance show];
}
- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    //   NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    self.myLocation =  userLocation;
    
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude};
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag)
    {
        
        [_locService stopUserLocationService];
        
        
    }
    
}
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    
}
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    
    if (error == 0) {
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        item.coordinate = result.location;
        item.title = result.address;
        
        NSLog(@"reuslt==%@",result);
        myAddressResult = result;
        NSString * provice = result.addressDetail.province;
        NSString * city = result.addressDetail.city;
        NSString * district = result.addressDetail.district;
        
        //        NSString* titleStr;
        //        NSString* showmeg;
        //
        //        titleStr = @"反向地理编码";
        //        showmeg = [NSString stringWithFormat:@"%@\n%@\n%@\n%@",item.title,provice,city,district];
        //        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:titleStr message:showmeg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
        //        [myAlertView show];
        
        //	定位时非直辖市传值到市，如：江苏苏州市；直辖市传值到区，如：上海上海市闸北区 // provicne  上海 江苏
        
        
    }
}


- (void)didFailToLocateUserWithError:(NSError *)error
{
}
- (void)onGetNetworkState:(int)iError
{
}

- (void)onGetPermissionState:(int)iError
{
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
//    [SHConfigManager.instance refresh];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//    if(__isupdate == NO){
//        [SHConfigManager.instance refresh];
//        __isupdate = YES;
//    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    NSLog(@"absoluteString ==>%@  ==%@", [url absoluteString],[url host]);
    // return [WeiboSDK handleOpenURL:url delegate:self];
    if ([[url host] isEqualToString:@"response"]) {
        // 微博
        return [ WeiboSDK  handleOpenURL:url delegate:nil];
    }
    else{
        
    }
    //    return [ShareSDK handleOpenURL:url
    //                        wxDelegate:self];
    
    //return   [WXApi  handleOpenURL:url delegate:self];
    //return [TencentOAuth HandleOpenURL:url];
    // return [ WeiboSDK  handleOpenURL:url delegate:nil];
    return YES;
}

#pragma  mark  qq sina  回调方法=================================

#pragma  mark  lqh77 add


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    //  NSLog(@"   qq 00000000 %@ %@",[url host] ,sourceApplication  );
    NSLog(@"absoluteString ==>%@  host==%@  sourceApplication=%@", [url absoluteString],[url host],sourceApplication );
    
    if([url.scheme rangeOfString:@"zyj"].length > 0){
        [[UIApplication sharedApplication] openURL2:url];
        return YES;
        
    }else if ([sourceApplication  isEqualToString:@"com.tencent.mipadqq"] || [sourceApplication  isEqualToString:@"com.tencent.mqq"]) {
        return [TencentOAuth HandleOpenURL:url];
    }else   if ([sourceApplication  isEqualToString:@"com.sina.weibo"] &&[[url host] isEqualToString:@"response"]) {// 微博登陆
        
        return [ WeiboSDK  handleOpenURL:url delegate:self];
    }
    else if([sourceApplication  isEqualToString:@"com.tencent.xin"]){
        
        BOOL isSuc = [WXApi handleOpenURL:url delegate:self];
        
        NSLog(@"url %@ isSuc %d",url,isSuc == YES ? 1 : 0);
        return  isSuc;
    }
    //    return [ShareSDK handleOpenURL:url
    //                 sourceApplication:sourceApplication
    //                        annotation:annotation
    //                        wxDelegate:self];
    return   [WXApi  handleOpenURL:url delegate:self];
}

#pragma  mark  =============================================
#pragma  mark  微信 委托方法

-(void) changeScene:(NSInteger)a_scene
{
    //_scene = a_scene;
    
    if (a_scene==0) {
        
        _scene=WXSceneSession;
        
    }else if (a_scene==1){
        _scene=WXSceneTimeline;
    }
    else if (a_scene==2){
        _scene=WXSceneFavorite;
        
    }
}

- (void) sendTextContent:(NSString *)shareStr
{
    __autoreleasing SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.text = shareStr;
    req.bText = YES;
    req.scene = _scene;
    [WXApi sendReq:req];
}



-(void) onReq:(BaseReq*)req
{
    if([req isKindOfClass:[GetMessageFromWXReq class]])
    {
        // 微信请求App提供内容， 需要app提供内容后使用sendRsp返回
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App提供内容"];
        NSString *strMsg = @"微信请求App提供内容，App要调用sendResp:GetMessageFromWXResp返回给微信";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 1000;
        [alert show];
        
    }
    else if([req isKindOfClass:[ShowMessageFromWXReq class]])
    {
        ShowMessageFromWXReq* temp = (ShowMessageFromWXReq*)req;
        WXMediaMessage *msg = temp.message;
        
        //显示微信传过来的内容
        WXAppExtendObject *obj = msg.mediaObject;
        
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App显示内容"];
        NSString *strMsg = [NSString stringWithFormat:@"标题：%@ \n内容：%@ \n附带信息：%@ \n缩略图:%u bytes\n\n", msg.title, msg.description, obj.extInfo, msg.thumbData.length];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    else if([req isKindOfClass:[LaunchFromWXReq class]])
    {
        //从微信启动App
        NSString *strTitle = [NSString stringWithFormat:@"从微信启动"];
        NSString *strMsg = @"这是从微信启动的消息";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
}

-(void) onResp:(BaseResp*)resp
{
    //    if([resp isKindOfClass:[SendMessageToWXResp class]])
    //    {
    //
    //        NSString *strMsg = [NSString  stringWithFormat:@"发送成功!"];
    //
    //
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strMsg message:nil delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
    //        [alert show];
    //
    //    }
}

#pragma  mark ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
#pragma  mark  微博  委托方法

-(void)sendLoginSina:(UIViewController *)vc{
    
    WBAuthorizeRequest *sina_request = [WBAuthorizeRequest request];
    sina_request.redirectURI = Sina_RedirectURI;
    //request.shouldOpenWeiboAppInstallPageIfNotInstalled=YES;
    sina_request.scope = @"all";
    sina_request.userInfo = @{@"com.weibo": @"SHLoginViewController",
                              @"Other_Info_1": [NSNumber numberWithInt:123],
                              @"Other_Info_2": @[@"obj1", @"obj2"],
                              @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:sina_request];
    
    
    
}

#pragma mark - WeiboSDK delegate

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        wbtoken = [(WBAuthorizeResponse *)response accessToken];
        
        NSString * userId = [(WBAuthorizeResponse * )response userID];
        
        [[NSUserDefaults standardUserDefaults] setObject:wbtoken forKey:@"token"];
        [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"openId"];
        [[NSUserDefaults standardUserDefaults] setObject:@"3" forKey:@"login_type"];
        // 获取用户资料  头像昵称
        NSString *url=[NSString stringWithFormat:@"https://api.weibo.com/2/users/show.json?access_token=%@&uid=%@",wbtoken,userId];
        
        NSLog(@"000+++>%@",url);
        if (wbtoken&&userId) {
            
            SHHttpTask * get = [[SHHttpTask   alloc ]  init ];
            [get setURL:url];
            get.delegate = self;
            get.tag = 0;
            [get start];
        }
    }
}

//-  (void) taskDidFinished:(SHTask *)task
//{
//    if (task.tag == 0) {
//
//
//        NSData *data=(NSData *)task.result;
//        //    NSString *str=[[NSString  alloc  ]initWithData:data encoding:4];
//        //
//        NSError  *error=nil;
//        NSDictionary * netreutrn = nil;
//
//        NSLog(@"000000+＝＝》%@",netreutrn);
//
//        if(data != nil){
//            netreutrn  = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingOptions)NSJSONWritingPrettyPrinted error:&error];
//        }
//        if (netreutrn) {
//            [[NSNotificationCenter defaultCenter]  postNotificationName: NOTIFY_SinaAuthon_Success object:netreutrn];
//
//        }
//    }
//
//}
//
//- (void) taskDidFailed:(SHTask *)task
//{
//
//}
#pragma  download
-(void)beginRequest:(int )videoId hdType:(int)hdType isCollection:(BOOL)isCollection isBeginDown:(BOOL)isBeginDown
{
    ////    如果不存在则创建临时存储目录
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:[SHFileManager getTargetFloderPath]])
    {
        [fileManager createDirectoryAtPath:[SHFileManager getTargetFloderPath] withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if (!self.requestlist) {
        self.requestlist = [[NSMutableArray alloc]init];
    }
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"Pad/download");
    [post.postArgs setValue:[NSNumber numberWithInt:videoId] forKey:@"id"];
    post.delegate = self;
    [post start:^(SHTask *task) {
        NSArray * array  = [[task result]mutableCopy];
        if (array.count<1) {
            return ;
        }
        NSMutableDictionary * dic = [array objectAtIndex:0];
        
        if([fileManager fileExistsAtPath:[[SHFileManager getTargetFloderPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",[dic objectForKey:@"id"]]]])//存在已经下好的MP4
        {
            return;
        }
        NSDictionary *urls = [dic objectForKey:@"list"];
        NSString *key  =[NSString stringWithFormat:@"hd%d",hdType];
        NSString * url = [urls objectForKey:key];
        
        if (!url || [url isEqualToString:@""]) {
            if (![[urls objectForKey:@"hd0"] isEqualToString:@""]) {
                url = [urls objectForKey:@"hd0"];
            }else  if (![[urls objectForKey:@"hd1"] isEqualToString:@""]) {
                url = [urls objectForKey:@"hd1"];
            }else  if (![[urls objectForKey:@"hd2"] isEqualToString:@""]) {
                url = [urls objectForKey:@"hd2"];
            }else{
                UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"对不起，未找到相应的下载资源" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
                [myAlertView show];
                return;
            }
            
        }
        url = [Utility encodeVideoUrl:url];
        
        [dic setValue:[[SHFileManager getTargetFloderPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]]] forKey:@"path"];// 没有格式
        [dic setValue:[NSNumber numberWithInt:emDownloading] forKey:@"state"];
        [dic setValue:[NSNumber numberWithInt:hdType] forKey:@"hdType"];
        [dic setValue:[NSNumber numberWithBool:isCollection] forKey:@"isCollection"];
        ASIHTTPRequest *request=[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
        request.delegate=self;
        [request setDownloadDestinationPath:[[SHFileManager getTargetFloderPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",[dic objectForKey:@"id"]]]];
        [request setTemporaryFileDownloadPath:[[SHFileManager getTargetFloderPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.temp",[dic objectForKey:@"id"]]]];
        //    [request setDownloadProgressDelegate:self];
        //    [request setDownloadProgressDelegate:downCell.progress];//设置进度条的代理,这里由于下载是在AppDelegate里进行的全局下载，所以没有使用自带的进度条委托，这里自己设置了一个委托，用于更新UI
        [request setAllowResumeForFileDownloads:YES];//支持断点续传
        [request setTimeOutSeconds:120];
        [request setNumberOfTimesToRetryOnTimeout:3];
        [request setUserInfo:[NSDictionary dictionaryWithObject:dic forKey:@"file"]];//设置上下文的文件基本信息
        [request startAsynchronous];
        if (isBeginDown) {
            UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"成功添加至离线观看" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
            [myAlertView show];
            [self.cachesInfolist addObject:dic];
        }
        [self.requestlist addObject:request];
        
    } taskWillTry:^(SHTask *task) {
        
    } taskDidFailed:^(SHTask *task) {
        
    }];
    
    //    文件开始下载时，把id;文件名;图片url;文件URL
    
    //    NSString *fileName=[[fileInfo objectForKey:@"id"] stringByAppendingFormat:@";%@;%@;%@;",[fileInfo objectForKey:@"title"],[fileInfo objectForKey:@"pic"],[fileInfo objectForKey:@"url"]];
    
    //    [fileInfo setValue:@"http://padload-cnc.wasu.cn/pcsan08/mams/vod/201409/29/16/201409291618156309b21cbd8_4e58bd54.mp4" forKey:@"url"];
    
    
}
-(void) loadCacheList
{
    NSData * data  = [[NSUserDefaults standardUserDefaults] valueForKey:DOWNLOAD_INFO_LIST];// 下载文件信息
    if (data) {
        self.cachesInfolist = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    if (!self.cachesInfolist) {
        self.cachesInfolist  = [[NSMutableArray alloc]init];
    }
    NSFileManager *fileManager=[NSFileManager defaultManager];
    
    for (int i = 0; i<self.cachesInfolist.count; i++) {
        NSMutableDictionary * dic = [self.cachesInfolist objectAtIndex:i];
        
        if([fileManager fileExistsAtPath:[NSString stringWithFormat:@"%@.temp",[dic objectForKey:@"path"]]]){
            [self beginRequest:[[dic objectForKey:@"id"]intValue] hdType:[[dic objectForKey:@"hdType"]intValue] isCollection:[[dic objectForKey:@"isCollection"]boolValue]  isBeginDown:NO];
            
            
        }
        if([fileManager fileExistsAtPath:[NSString stringWithFormat:@"%@.mp4",[dic objectForKey:@"path"]]]){
            [dic setValue:[NSNumber numberWithInt:emDownLoaded] forKey:@"state"];
        }else{
            [self.cachesInfolist removeObject:dic];
        }
        
    }
    
}
#pragma ASIHttpRequest回调委托

//出错了，如果是等待超时，则继续下载
-(void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error=[request error];
    NSLog(@"ASIHttpRequest出错了!%@",error);
    
}

-(void)requestStarted:(ASIHTTPRequest *)request
{
    NSLog(@"开始了!");
}
- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders {
    
    NSLog(@"didReceiveResponseHeaders-%@",[responseHeaders valueForKey:@"Content-Length"]);
    NSLog(@"收到回复了！");
    NSMutableDictionary *fileInfo=[request.userInfo objectForKey:@"file"];
    [fileInfo setValue:[SHFileManager getFileSizeString:[[request responseHeaders] objectForKey:@"Content-Length"]] forKey:@"fileSize"];
    
    
    
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:self.cachesInfolist];
    [[NSUserDefaults standardUserDefaults ] setValue:data forKey:DOWNLOAD_INFO_LIST];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
}

-(void)setProgress:(float)newProgress
{
    NSLog(@"setProgress-%f",newProgress);
}
@end
