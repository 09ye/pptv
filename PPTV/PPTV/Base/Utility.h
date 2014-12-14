//
//  Utility.h
//  RT5030S
//
//  Created by yebaohua on 14-9-29.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTools.h"

@interface Utility : SHTools
//post 请求参数 key=vlaue&key=value
+ (NSData *)createPostData:(NSDictionary*) params;
// data 是星期几 返回[0,周一]。。。
+(NSArray *)weekDayWithDate:(NSDate *)date;
@end
