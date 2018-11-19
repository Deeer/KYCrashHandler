//
//  KYTimeRecorder.m
//  CrashDemo
//
//  Created by apple on 2018/11/15.
//  Copyright © 2018 apple. All rights reserved.
//

#import "KYTimeRecorder.h"
#import <QuartzCore/QuartzCore.h>

static NSString *KY_CRASHTIMEIDENTIFIER  = @"KY_CrashTimeIdentifier";
static NSString *KY_LAUNCHERTIMEIDENTIFIER = @"KY_LaucnherTimeIdentifier";
static NSString *KY_TERMINATETIMEIDENTIFIER = @"KY_TermiateTimeIdentifier";

static NSString *KY_TimeRecord = @"TimeRecordKey";

double KY_CRASH_TIME = 5.0;

@implementation KYTimeRecorder

static inline NSString * CRASHCONDITION() {
    return [NSString stringWithFormat:@"%@%@%@%@%@",
            KY_LAUNCHERTIMEIDENTIFIER,
            KY_CRASHTIMEIDENTIFIER,
            KY_LAUNCHERTIMEIDENTIFIER,
            KY_CRASHTIMEIDENTIFIER,
            KY_LAUNCHERTIMEIDENTIFIER];
}

/**
 根据类型记录事件事件
 */
+ (void)recordTimeWithType:(KYTimeRecordType)type {
    
    CFTimeInterval time = CACurrentMediaTime();
    NSString *identifier;
    switch (type) {
        case KYTimeRecordTypeTerminate:
            identifier = KY_TERMINATETIMEIDENTIFIER;
            break;
        case KYTimeRecordTypeCrash:
            identifier = KY_CRASHTIMEIDENTIFIER;
            break;
        case KYTimeRecordTypeLauncher:
            identifier = KY_LAUNCHERTIMEIDENTIFIER;
            break;
        default:
            break;
    }
    NSDictionary *eventDict = @{identifier :  @(time)};
    [self addRecordEventWithDict:eventDict];
}

+ (NSMutableArray *)getAllEventsRecordes {
   NSArray * records = [[NSUserDefaults standardUserDefaults] valueForKey:KY_TimeRecord];
    return  [records mutableCopy] ? : [NSMutableArray new];
}

// 是否处于连续闪退状态
// 进入样本分析
+ (BOOL)isInContinuousTerminateStatus {
    NSArray * records = [self getAllEventsRecordes];
    // 当分析数据不足时,不进入分析逻辑
    if (records.count <= 5) {
        return NO;
    }
    
    // ------------------------------------------------
    // - launcher  - [crash] - launcher - [terminal] - launcher
    // - launcher  - [terminal] - launcher - [terminal] - launcher
    // - launcher  - [terminal] - launcher - [crash] - launcher
    // - launcher - [crash] - launcher - [crash] - launcher
    // ------------------------------------------------
    // 条件分析
    NSString * conditionStr ;
    for (NSDictionary *dict in records) {
        NSString *key = [[dict allKeys] firstObject];
        conditionStr = [NSString stringWithFormat:@"%@%@",conditionStr,key];
    }
    
    // 状态分析
    if (![conditionStr isEqualToString:CRASHCONDITION()]) {
        return NO;
    }
    
    
    // 时间分析
    // 前两次崩溃时间都是在五秒内的
    double firstCrashDelatTime = [self getValueWithIndex:1] - [self getValueWithIndex:0];
    double secondCrashDelatTime = [self getValueWithIndex:3] - [self getValueWithIndex:2];
    if (firstCrashDelatTime <= KY_CRASH_TIME && secondCrashDelatTime <= KY_CRASH_TIME) {
        return YES;
    }
    
    return NO;
}

#pragma mark - base

+ (double)getValueWithIndex:(NSInteger)index {
    NSArray * records = [self getAllEventsRecordes];
    return [[[records[index] values] firstObject] doubleValue];
}

+ (void)addRecordEventWithDict:(NSDictionary*)eventDict {
    NSMutableArray * records = [self getAllEventsRecordes];
    [records addObject:eventDict];
    
    // 仅记录最新的五个
    if (records.count > 5) {
        records = [[records subarrayWithRange:NSMakeRange(1, 5)] mutableCopy];
        [[NSUserDefaults standardUserDefaults] setValue:records forKey:KY_TimeRecord];
    }
}

@end
