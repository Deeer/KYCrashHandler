//
//  KYExceptionHandler.m
//  CrashDemo
//
//  Created by apple on 2018/11/15.
//  Copyright © 2018 apple. All rights reserved.
//

#import "KYExceptionHandler.h"
#import "KYCrashLocalStorage.h"
#import "KYCrashBusinessHandler.h"
#import "KYTimeRecorder.h"

// 处理文件内容
void uncaughtExceptionHandler(NSException *exception) {
    
    NSArray *arr = [exception callStackSymbols];//当前调用栈信息
    NSString *reason = [exception reason];//崩溃原因
    NSString *name = [exception name];//异常类型
    NSLog(@"exception type: %@\n crash reason: %@\n userInfo:%@\n call stack info: %@\n", name, reason, arr, exception.userInfo);
    
    // 记录crash 事件
    [KYTimeRecorder recordTimeWithType:KYTimeRecordTypeCrash];
    // 收到exception 进行进一步处理
    [KYExceptionHandler handleException:exception];
}

// 希望在捕获的时候能处理其他东西
@interface KYExceptionHandler ()

@end

@implementation KYExceptionHandler

+ (void)handleException:(NSException *)exception {
    // 内容组织
    NSMutableDictionary *exceptionDict = [NSMutableDictionary dictionary];
    [exceptionDict setValue:exception.name forKey:@"name"];
    [exceptionDict setValue:exception.reason forKey:@"reason"];
    [exceptionDict setValue:exception.callStackSymbols forKey:@"callStackSymbols"];
    
    // 加入自定义部分
    KYCrashBusinessHandler *handler = [KYCrashBusinessHandler shareInstance];
    NSString *customConten = handler.customContent;
    if (customConten && customConten.length > 0) {
        [exceptionDict setValue:customConten forKey:@"customContent"];
    }
    
    // 写入本地文件中
    [KYCrashLocalStorage saveCrashLogLocallyWithDict:exceptionDict];
}

@end
