//
//  KYExceptionHandler.h
//  CrashDemo
//
//  Created by apple on 2018/11/15.
//  Copyright © 2018 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^exceptionHandlerCallback)(NSException *exception);

/**
 捕获崩溃
 */
void uncaughtExceptionHandler(NSException *exception);

NS_ASSUME_NONNULL_BEGIN
// 崩溃检测类
@interface KYExceptionHandler : NSObject
/**
 处理excption
 */
+ (void)handleException:(NSException *)exception;

@end

NS_ASSUME_NONNULL_END
