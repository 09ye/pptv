//
//  Utility.m
//  RT5030S
//
//  Created by yebaohua on 14-9-29.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "Utility.h"

@implementation Utility

+ (NSData *)createPostData:(NSDictionary*) params
{
    NSString *postString=@"";
    for(NSString *key in [params allKeys])
    {
        NSString *value=[params objectForKey:key];
        postString=[postString stringByAppendingFormat:@"%@=%@&",key,value];
    }
    if([postString length]>1)
    {
        postString=[postString substringToIndex:[postString length]-1];
    }
    SHLog(@"%@",postString);
    NSData * data = [postString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return data;
}
+(NSArray *)weekDayWithDate:(NSDate *)date{
    
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *weekDayComponents = [gregorian components:NSWeekdayCalendarUnit fromDate:date];
    NSInteger mDay = [weekDayComponents weekday];
    NSArray *week=@[@0,@""];
    switch (mDay) {
        case 0:{
            week=@[@6,@"周日"];
            break;
        }
        case 1:{
            week=@[@6,@"周日"];
            break;
        }
        case 2:{
            week=@[@0,@"周一"];
            break;
        }
        case 3:{
            week=@[@1,@"周二"];
            break;
        }
        case 4:{
            week=@[@2,@"周三"];
            break;
        }
        case 5:{
            week=@[@3,@"周四"];
            break;
        }
        case 6:{
            week=@[@4,@"周五"];
            break;
        }
        case 7:{
            week=@[@5,@"周六"];
            break;
        }
        default:{
            break;
        }
    };
    return week;
}

@end
