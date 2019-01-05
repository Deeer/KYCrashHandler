//
//  KYSignalHandler.h
//  CrashDemo
//
//  Created by Dee on 2019/1/5.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KYSignalHandler : NSObject

/**
 注册相应监听
 */
+ (void)registSignaleHandler;

/**
 处理exception
 */
+ (void)hadnelException:(NSException *)exception;
@end

NS_ASSUME_NONNULL_END
