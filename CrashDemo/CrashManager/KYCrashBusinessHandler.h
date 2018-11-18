//
//  KYCrashBusinessHandler.h
//  CrashDemo
//
//  Created by apple on 2018/11/16.
//  Copyright © 2018 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KYExceptionHandler.h"
NS_ASSUME_NONNULL_BEGIN

@interface KYCrashBusinessHandler : NSObject

@property(nonatomic, readonly ,copy) NSString *customContent;

+ (KYCrashBusinessHandler *)shareInstance;

/**
 是否开启日志输出

 @param isopen 是否开启日志输出
 */
+ (void)openLog:(BOOL)isopen;

#pragma mark - 修复部分



#pragma mark - crash部分

/**
 设置自定义内容
 
 @param content 内容信息
 */
- (void)addCustionContent:(NSString *)content;

/**
 上传方式的

 @param completion 回调
 */
- (void)uploadContentWithCompletion:(void(^)(BOOL isSuccess, NSError * _Nonnull error))completion;
@end

NS_ASSUME_NONNULL_END
