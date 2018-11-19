//
//  KYTimeRecorder.h
//  CrashDemo
//
//  Created by apple on 2018/11/15.
//  Copyright © 2018 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
// 记录crash时间/启动时间/Terminate时间

// laucnher - Terminal - launcher - Terminal
// launcher - crash - launcher - crash
// launcher - crash - launcher - termial
// laucnher - Termial - launcher - crash


/*
 时间记录格式
 [
 @{@"laucnherTime" : value}
 @{@"crashTime" : value}
 @{@"Terminal" : value}
 ]
*/

typedef NS_ENUM(NSInteger, KYTimeRecordType) {
    KYTimeRecordTypeCrash = 0, // crash
    KYTimeRecordTypeTerminate, // terminate
    KYTimeRecordTypeLauncher   // launcher
};

@interface KYTimeRecorder : NSObject

/**
 根据类型记录事件事件
 
 */
+ (void)recordTimeWithType:(KYTimeRecordType)type;


/**
 获取所有的记录数据
 */
+ (NSMutableArray *)getAllEventsRecordes;


/**
 是否处于连续闪退状态
 */
+ (BOOL)isInContinuousTerminateStatus;
@end

NS_ASSUME_NONNULL_END
