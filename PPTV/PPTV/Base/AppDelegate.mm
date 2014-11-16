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

    
    
    // 新浪微博
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:APPID_Sina];
    
    [WXApi  registerApp:APPID_WeoXin];
    //需要注意的是，SendMessageToWXReq的scene成员，如果scene填WXSceneSession，那么消息会发送至微信的会话内。如果scene填WXSceneTimeline，那么消息会发送至朋友圈。如果scene填WXSceneFavorite,那么消息会发送到“我的收藏”中。scene默认值为WXSceneSession。
    _scene = WXSceneTimeline;
    _mapManager = [[BMKMapManager alloc]init];
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    _geocodesearch = [[BMKGeoCodeSearch alloc]init];
    _geocodesearch.delegate = self;
    
    BOOL ret = [_mapManager start:@"XUhLsGNq9Ch1HfTgZH8LFZs8"  generalDelegate:self];// ybh ky
//zambon key  RNuxCab28lK3wgb3jGhsrpa3
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    [super application:application didFinishLaunchingWithOptions:launchOptions];
    [_locService startUserLocationService];
    
    
    [ShareSDK registerApp:@"24732465ea3a"];     //参数为ShareSDK官网中添加应用后得到的AppKey
    
    
    [ShareSDK connectSinaWeiboWithAppKey:APPID_Sina
                               appSecret:APPID_KEY_Sina
                             redirectUri:Sina_RedirectURI];
    //添加腾讯微博应用 注册网址 http://dev.t.qq.com
    //    [ShareSDK connectTencentWeiboWithAppKey:@"801307650"
    //                                  appSecret:@"ae36f4ee3946e1cbb98d6965b0b2ff5c"
    //                                redirectUri:@"http://www.sharesdk.cn"
    //                                   wbApiCls:[WeiboApi class]];
    //    [ShareSDK connectQZoneWithAppKey:APPID_QQ appSecret:APPID_KEY_QQ];
    //    [ShareSDK connectQQWithAppId:APPID_QQ qqApiCls:[QQApi class]];
    //    [ShareSDK connectWeChatFavWithAppId:APPID_QQ wechatCls:[WXApi class]];
    //    [ShareSDK connectWeChatSessionWithAppId:APPID_QQ wechatCls:[WXApi class]];
    //    [ShareSDK connectWeChatTimelineWithAppId:APPID_QQ wechatCls:[WXApi class]];
    
    
    /**
     连接微信应用以使用相关功能，此应用需要引用WeChatConnection.framework和微信官方SDK
     http://open.weixin.qq.com上注册应用，并将相关信息填写以下字段
     **/
    [ShareSDK connectWeChatWithAppId:@"wx4868b35061f87885" wechatCls:[WXApi class]];
    /**
     连接QQ应用以使用相关功能，此应用需要引用QQConnection.framework和QQApi.framework库
     http://mobile.qq.com/api/上注册应用，并将相关信息填写到以下字段
     **/
    //旧版中申请的AppId（如：QQxxxxxx类型），可以通过下面方法进行初始化
    //   [ShareSDK connectQQWithAppId:@"QQ075BCD15" qqApiCls:[QQApi class]];
    
    [ShareSDK connectQQWithQZoneAppKey:@"100371282"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configUpdate:) name:CORE_NOTIFICATION_CONFIG_STATUS_CHANGED object:nil];
    [SHConfigManager instance];
//    [SHConfigManager instance].URL = URL_FOR(@"get_config");
    
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
    [SHConfigManager.instance refresh];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    if(__isupdate == NO){
        [SHConfigManager.instance refresh];
        __isupdate = YES;
    }
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

-  (void) taskDidFinished:(SHTask *)task
{
    if (task.tag == 0) {
        
        
        NSData *data=(NSData *)task.result;
        //    NSString *str=[[NSString  alloc  ]initWithData:data encoding:4];
        //
        NSError  *error=nil;
        NSDictionary * netreutrn = nil;
        
        NSLog(@"000000+＝＝》%@",netreutrn);
        
        if(data != nil){
            netreutrn  = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingOptions)NSJSONWritingPrettyPrinted error:&error];
        }
        if (netreutrn) {
            [[NSNotificationCenter defaultCenter]  postNotificationName: NOTIFY_SinaAuthon_Success object:netreutrn];
            
        }
    }
    
}

- (void) taskDidFailed:(SHTask *)task
{
    
}

@end
