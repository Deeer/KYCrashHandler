//
//  KYCrashBusinessHandler.h
//  CrashDemo
//
//  Created by apple on 2018/11/16.
//  Copyright © 2018 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KYExceptionHandler.h"
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN
@class KYCrashRepairViewController;
@interface KYCrashBusinessHandler : NSObject

+ (KYCrashBusinessHandler *)shareInstance;

/**
 是否存在上传器
 */
- (BOOL)exsitUploader;

#pragma mark - crash部分
/**
 上传方式的

 @param completion 回调
 */
- (void)uploadContentWithCompletion:(void(^)(BOOL isSuccess, NSError * _Nonnull error))completion;

@end

NS_ASSUME_NONNULL_END
