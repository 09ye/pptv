//
//  config.h
//  Zambon
//
//  Created by sheely on 13-9-23.
//  Copyright (c) 2013年 zywang. All rights reserved.
//

#import "Vitamio.h"
#import "Core.h"
#import "common.h"
#import "SHAppDelegate.h"


#define URL_HEADER @ "http://zambon-test.mobilitychina.com:8093"


#define URL_BATA @ "http://zambon-test.mobilitychina.com:8093"

#define URL_DEVELOPER @ "http://zambon-test.mobilitychina.com:8093"

#define URL_UPDATE @"http://zambon-update1.mobilitychina.com:8095/get_config"

#define URL_FOR(a) [NSString stringWithFormat:@"%@/%@",URL_HEADER,a]

#define DEVICE_TOKEN @"DeviceTokenStringKEY"






#define RECT_RIGHTSHOW CGRectMake(87, 23, 930, 730)
#define RECT_RIGHTNAVIGATION CGRectMake(0, 0, 930, 44)
#define RECT_RIGHTLIST CGRectMake(0, 44, 240, 678)
#define RECT_RIGHTCONTENT CGRectMake(240, 0, 687  , 730)
#define RECT_RIGHTCONTENT2 CGRectMake(667, 23, 350  , 730)
#define CELL_GENERAL_HEIGHT 110
#define CELL_GENERAL_HEIGHT2 80
#define CELL_GENERAL_HEIGHT3 44
#define CELL_SECTION_HEADER_GENERAL_HEIGHT 38
#define RECT_MAIN_LANDSCAPE_RIGHT CGRectMake(-20, 0, 768, 1004)
#define RECT_MAIN_LANDSCAPE_LEFT CGRectMake(20, 0, 768, 1004)

#define USER_CENTER_LOGINNAME @"user_center_loginname"
#define USER_CENTER_PASSWORD @"user_center_password"

//notification
#define NOTIFICATION_LOGIN_SUCCESSFUL @"notification_login_successful"
#define NOTIFY_SinaAuthon_Success     @"SinaAuthonSuccess"



#define IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define RETAIN ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define IPHONE4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

