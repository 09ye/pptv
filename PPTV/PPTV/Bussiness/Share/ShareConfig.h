//
//  ShareConfig.h
//  crowdfunding-arcturus
//
//  Created by lqh77 on 14-4-29.
//  Copyright (c) 2014年 WSheely. All rights reserved.
//

#import <TencentOpenAPI/sdkdef.h>
#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/TencentOAuthObject.h>
//tencentMessage
#import <TencentOpenAPI/TencentMessageObject.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentApiInterface.h>

// sina
#import "WeiboSDK.h"

// weixin
#import "WXApi.h"

#define  APPID         @"871732787"// 应用程序ID


//  qq  config
/*   必须的框架 http://sinaweibosdk.github.io/weibo_ios_sdk/index.html
   Security.framework”,“libiconv.dylib”，“SystemConfiguration.framework”，“CoreGraphics.Framework”、“libsqlite3.dylib”、“CoreTelephony.framework”、“libstdc++.dylib”、“libz.dylib”。
 
 访问登录用户的基础资料 	get_simple_userinfo
 微博 	访问登录用户的腾讯微博资料 	get_info 	已激活
 登录用户分享内容到腾讯微博 	add_t del_t add_pic_t get_repost_list 	已激活
 获得登录用户的微博好友信息 	get_other_info get_fanslist get_idollist add_idol del_idol 	已激活
 * add Share.
 
- (void)onClickAddShare {
	_labelTitle.text = @"开始分享";
    
    TCAddShareDic *params = [TCAddShareDic dictionary];
    params.paramTitle = @"腾讯内部addShare接口测试";
    params.paramComment = @"风云乔帮主";
    params.paramSummary =  @"乔布斯被认为是计算机与娱乐业界的标志性人物，同时人们也把他视作麦金塔计算机、iPod、iTunes、iPad、iPhone等知名数字产品的缔造者，这些风靡全球亿万人的电子产品，深刻地改变了现代通讯、娱乐乃至生活的方式。";
    params.paramImages = @"http://img1.gtimg.com/tech/pics/hv1/95/153/847/55115285.jpg";
    params.paramUrl = @"http://www.qq.com";
	
	if(![_tencentOAuth addShareWithParams:params]){
        [self showInvalidTokenOrOpenIDMessage];
    }
}
 */
//http://wiki.connect.qq.com/ios%E5%BC%80%E5%8F%91%E8%A7%86%E9%A2%91%E6%95%99%E7%A8%8B
#define  APPID_QQ            @"1103405567"//101072114
#define  APPID_KEY_QQ        @"Xq98voVzKY8bStPO"


// sina  config
/*   必须的框架 Security.framework”,“libiconv.dylib”，“SystemConfiguration.framework”，“CoreGraphics.Framework”、“libsqlite3.dylib”、“CoreTelephony.framework”、“libstdc++.dylib”、“libz.dylib”。
 */

#define  APPID_Sina          @"3677032229"
#define  APPID_KEY_Sina      @"b0f69e5b4c74c26a6c154fe712f4f3fb"
//注意:IOS 应用推荐使用默认授权回调页!地址为: https://api.weibo.com/oauth2/default.html
#define  Sina_RedirectURI    @"http://www.baidu.com"

//#define  APPID_WeoXin         @"wxf293133716ec75b6"
//#define  APPID_KEY_WeiXin     @"582c0b7f0e0f9ed980b61e404010497b"

//wxd5e5e9fd7f5b6fe6
#define  APPID_WeoXin         @"wxd5e5e9fd7f5b6fe6"

#define  APPID_KEY_WeiXin     @"ea28cac5d72f2c4b6b22fb6e202bb082"

#define  WeiXin_RedirectURI   @"http://www.zyj.com"


#define IOS7 [[[UIDevice currentDevice] systemVersion]floatValue]>=7








//
//
//
//
///**
// * 因用户未授予相应权限而需要执行增量授权。在用户调用某个api接口时，如果服务器返回操作未被授权，则触发该回调协议接口，由第三方决定是否跳转到增量授权页面，让用户重新授权。
// * \param tencentOAuth 登录授权对象。
// * \param permissions 需增量授权的权限列表。
// * \return 是否仍然回调返回原始的api请求结果。
// * \note 不实现该协议接口则默认为不开启增量授权流程。若需要增量授权请调用\ref TencentOAuth#incrAuthWithPermissions: \n注意：增量授权时用户可能会修改登录的帐号
// */
//- (BOOL)tencentNeedPerformIncrAuth:(TencentOAuth *)tencentOAuth withPermissions:(NSArray *)permissions{
//    
//    return  NO;
//    
//}
//
///**
// * [该逻辑未实现]因token失效而需要执行重新登录授权。在用户调用某个api接口时，如果服务器返回token失效，则触发该回调协议接口，由第三方决定是否跳转到登录授权页面，让用户重新授权。
// * \param tencentOAuth 登录授权对象。
// * \return 是否仍然回调返回原始的api请求结果。
// * \note 不实现该协议接口则默认为不开启重新登录授权流程。若需要重新登录授权请调用\ref TencentOAuth#reauthorizeWithPermissions: \n注意：重新登录授权时用户可能会修改登录的帐号
// */
//- (BOOL)tencentNeedPerformReAuth:(TencentOAuth *)tencentOAuth{
//    
//    return  NO;
//    
//}
//
///**
// * 用户通过增量授权流程重新授权登录，token及有效期限等信息已被更新。
// * \param tencentOAuth token及有效期限等信息更新后的授权实例对象
// * \note 第三方应用需更新已保存的token及有效期限等信息。
// */
//- (void)tencentDidUpdate:(TencentOAuth *)tencentOAuth{
//    
//    NSLog(@"tencentDidUpdate  %@",tencentOAuth);
//    
//    
//}
//
///**
// * 用户增量授权过程中因取消或网络问题导致授权失败
// * \param reason 授权失败原因，具体失败原因参见sdkdef.h文件中\ref UpdateFailType
// */
//- (void)tencentFailedUpdate:(UpdateFailType)reason{
//}
//
///**
// * 获取用户个人信息回调
// * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
// * \remarks 正确返回示例: \snippet example/getUserInfoResponse.exp success
// *          错误返回示例: \snippet example/getUserInfoResponse.exp fail
// */
////- (void)getUserInfoResponse:(APIResponse*) response{
////
////    NSLog(@"tencentDidUpdate  %@",response);
////}
//
///**
// * 获取用户QZone相册列表回调
// * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
// * \remarks 正确返回示例: \snippet example/getListAlbumResponse.exp success
// *          错误返回示例: \snippet example/getListAlbumResponse.exp fail
// */
//- (void)getListAlbumResponse:(APIResponse*) response{
//}
//
///**
// * 获取用户QZone相片列表
// * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
// * \remarks 正确返回示例: \snippet example/getListPhotoResponse.exp success
// *          错误返回示例: \snippet example/getListPhotoResponse.exp fail
// */
//- (void)getListPhotoResponse:(APIResponse*) response{
//}
//
///**
// * 检查是否是QZone某个用户的粉丝回调
// * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
// * \remarks 正确返回示例: \snippet example/checkPageFansResponse.exp success
// *          错误返回示例: \snippet example/checkPageFansResponse.exp fail
// */
//- (void)checkPageFansResponse:(APIResponse*) response{
//}
//
///**
// * 分享到QZone回调
// * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
// * \remarks 正确返回示例: \snippet example/addShareResponse.exp success
// *          错误返回示例: \snippet example/addShareResponse.exp fail
// */
//- (void)addShareResponse:(APIResponse*) response{
//}
//
///**
// * 在QZone相册中创建一个新的相册回调
// * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
// * \remarks 正确返回示例: \snippet example/addAlbumResponse.exp success
// *          错误返回示例: \snippet example/addAlbumResponse.exp fail
// */
//- (void)addAlbumResponse:(APIResponse*) response{
//}
//
///**
// * 上传照片到QZone指定相册回调
// * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
// * \remarks 正确返回示例: \snippet example/uploadPicResponse.exp success
// *          错误返回示例: \snippet example/uploadPicResponse.exp fail
// */
//- (void)uploadPicResponse:(APIResponse*) response{
//}
//
///**
// * 在QZone中发表一条说说回调
// * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
// * \remarks 正确返回示例: \snippet example/addTopicResponse.exp success
// *          错误返回示例: \snippet example/addTopicResponse.exp fail
// */
//- (void)addTopicResponse:(APIResponse*) response{
//}
//
///**
// * 获取QQ会员信息回调
// * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
// * \remarks 正确返回示例: \snippet example/getVipInfoResponse.exp success
// *          错误返回示例: \snippet example/getVipInfoResponse.exp fail
// */
//- (void)getVipInfoResponse:(APIResponse*) response{
//    
//    
//}
//
///**
// * 获取QQ会员详细信息回调
// * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
// */
//- (void)getVipRichInfoResponse:(APIResponse*) response{
//}
//
///**
// * 获取微博好友名称输入提示回调
// * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
// * \remarks 正确返回示例: \snippet example/matchNickTipsResponse.exp success
// *          错误返回示例: \snippet example/matchNickTipsResponse.exp fail
// */
//- (void)matchNickTipsResponse:(APIResponse*) response{
//}
//
///**
// * 获取最近的微博好友回调
// * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
// * \remarks 正确返回示例: \snippet example/getIntimateFriendsResponse.exp success
// *          错误返回示例: \snippet example/getIntimateFriendsResponse.exp fail
// */
//- (void)getIntimateFriendsResponse:(APIResponse*) response{
//}
//
///**
// * 设置QQ头像回调
// * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
// * \remarks 正确返回示例: \snippet example/setUserHeadpicResponse.exp success
// *          错误返回示例: \snippet example/setUserHeadpicResponse.exp fail
// */
//- (void)setUserHeadpicResponse:(APIResponse*) response{
//}
//
///**
// * sendStory分享的回调（已废弃，使用responseDidReceived:forMessage:）
// * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
// */
//- (void)sendStoryResponse:(APIResponse*) response{
//}
///**
// * 社交API统一回调接口
// * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
// * \param message 响应的消息，目前支持‘SendStory’,‘AppInvitation’，‘AppChallenge’，‘AppGiftRequest’
// */
//- (void)responseDidReceived:(APIResponse*)response forMessage:(NSString *)message{
//    NSLog(@"通知第三方界面需要被关闭");
//    
//}
//
///**
// * post请求的上传进度
// * \param tencentOAuth 返回回调的tencentOAuth对象
// * \param bytesWritten 本次回调上传的数据字节数
// * \param totalBytesWritten 总共已经上传的字节数
// * \param totalBytesExpectedToWrite 总共需要上传的字节数
// * \param userData 用户自定义数据
// */
//- (void)tencentOAuth:(TencentOAuth *)tencentOAuth didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite userData:(id)userData{
//    
//    
//    NSLog(@"通知第三方界面需要被关闭");
//}
//
//
///**
// * 通知第三方界面需要被关闭
// * \param tencentOAuth 返回回调的tencentOAuth对象
// * \param viewController 需要关闭的viewController
// */
//- (void)tencentOAuth:(TencentOAuth *)tencentOAuth doCloseViewController:(UIViewController *)viewController{
//    
//    NSLog(@"通知第三方界面需要被关闭");
//    
//}









