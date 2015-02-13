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
+ (NSString *)createPostString:(NSDictionary*) params
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
    return postString;
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
+(BOOL)containsObject:(NSMutableArray *)array forKey:(NSString *)key forValue:(NSString *)value
{
    for (NSDictionary *dic in array) {
        if ([[NSString stringWithFormat:@"%@",[dic objectForKey:key]] isEqualToString:value]) {
            return YES;
            
        }
    }
    return  NO;
}
+(void)removeObject:(NSMutableArray *)array forKey:(NSString *)key forValue:(NSString *)value
{
    for (NSDictionary *dic in array) {
        if ([[dic objectForKey:key] isEqualToString:value] ) {
            [array  removeObject:dic];
            break;
        }
    }

}

+(NSString *)encodeVideoUrl:(NSString *) url
{
    return  [self encodeVideoUrl:url key:@"#&@^!&WaSu8&(6Lx"];
}
+(NSString *)encodeVideoUrl:(NSString *) url key:(NSString *)key
{
    int ckey_length = 4;
    key  = [[SHTools md5Encrypt:(![key isEqualToString:@""]?key:@"12345678")]lowercaseString];
    NSString * keya  = [[SHTools md5Encrypt:([key substringWithRange:NSMakeRange(0, 16)])]lowercaseString];
    NSString * keyb  = [[SHTools md5Encrypt:([key substringWithRange:NSMakeRange(16, 16)])]lowercaseString];
    NSString * keyc  = [url substringWithRange:NSMakeRange(0, ckey_length)];
    NSString * cryptkey = [NSString stringWithFormat:@"%@%@",keya,[[SHTools md5Encrypt:[NSString stringWithFormat:@"%@%@",keya,keyc]]lowercaseString]];
    int key_length =  cryptkey.length;
    url = [[NSString alloc]initWithData:[Base64 decode:[url substringFromIndex:ckey_length]] encoding:NSUTF8StringEncoding];
    int string_length = url.length;
    NSData *testData = [cryptkey dataUsingEncoding: NSUTF8StringEncoding];
    Byte *cryptkey2 = (Byte *)[testData bytes];
    NSMutableArray *mdkey = [[NSMutableArray alloc]init];
    NSMutableArray *box = [[NSMutableArray alloc]init];
    int i,j,k,tmp;
    for (int i = 0; i<128; i++) {
        [box addObject:[NSNumber numberWithInt:i]];
        [mdkey addObject:[NSNumber numberWithInt:(cryptkey2[i%key_length] & 0xFF)]];
    }
    for (j = i = 0; i<128; i++) {
        j = (j+ [[box objectAtIndex:i]intValue]+[[mdkey objectAtIndex:i]intValue])%128;
        tmp = [[box objectAtIndex:i]intValue];
        [box replaceObjectAtIndex:i withObject:[box objectAtIndex:j]];
        [box replaceObjectAtIndex:j withObject:[NSNumber numberWithInt:tmp]];
        
    }
    Byte *str3 = (Byte *)[[url dataUsingEncoding: NSUTF8StringEncoding] bytes];
    
    Byte result[string_length];
    for (k=j=i=0 ; i < string_length;i++) {
        k =  (k+1)%128;
        j = (j+ [[box objectAtIndex:k]intValue])%128;
        tmp  = [[box objectAtIndex:k]intValue];
        [box replaceObjectAtIndex:k withObject:[box objectAtIndex:j]];
        [box replaceObjectAtIndex:j withObject:[NSNumber numberWithInt:tmp]];
        int  powB = [[box objectAtIndex:(([[box objectAtIndex:k]intValue]+[[box objectAtIndex:j]intValue])%128)]intValue];
        result[i] = (Byte)str3[i]&0xff ^ powB;
    }
    
    NSData *adata = [[NSData alloc] initWithBytes:result length:string_length];
    NSString *aString = [[NSString alloc] initWithData:adata encoding:NSUTF8StringEncoding];
    NSString * result1  = aString;
    int string10 = [[result1 substringWithRange:NSMakeRange(0, 10)]intValue];
    int  time  = [[NSDate date]timeIntervalSince1970];
    NSString * string16 = [result1 substringWithRange:NSMakeRange(10, 16)];
    NSString * stringkey = [NSString stringWithFormat:@"%@%@",[result1 substringFromIndex:26] ,keyb];
    NSString * stringmd5  = [[SHTools md5Encrypt:stringkey]lowercaseString];
    NSString * string162 =  [stringmd5 substringWithRange:NSMakeRange(0, 16)];
    NSString * results  = @"" ;
    if((string10 == 0 || string10-time>0) && [string16 isEqualToString:string162]){
        results =  [result1 substringFromIndex:26];
    }
    NSLog(@"encodeVideoUrl===%@",results);
    return results;
}
@end
