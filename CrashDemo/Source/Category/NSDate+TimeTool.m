//
//  NSDate+TimeTool.m
//  CrashDemo
//
//  Created by apple on 2018/11/15.
//  Copyright © 2018 apple. All rights reserved.
//

#import "NSDate+TimeTool.h"

@implementation NSDate (TimeTool)

///当前时间格式字符串
+ (NSString *)currentTimeFormatString {
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];//设定时间格式
    NSString *time = [dateFormatter stringFromDate:currentDate];//将时间转化成字符串
    
    return time;
}


@end
