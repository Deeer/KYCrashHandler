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

@class KYCrashRepairViewController;
typedef NS_ENUM(NSInteger, KYRepairInterfaceType) {
    KYRepairInterfaceDefaultAlert,
    KYRepairInterfaceCustomViewController
};

NS_ASSUME_NONNULL_BEGIN

@interface KYCrashBusinessHandler : NSObject


@property(nonatomic, readonly ,copy) NSString *customContent;

+ (KYCrashBusinessHandler *)shareInstance;


/**
 是否存在上传器
 */
- (BOOL)exsitUploader;
/**
 是否存在修复界面
 */
- (BOOL)exsitRepairViewController;

/**
 是否开启日志输出

 @param isopen 是否开启日志输出
 */
+ (void)openLog:(BOOL)isopen;

#pragma mark - 修复部分

/**
 展示自定义界面
 
 */
- (void)showRepairInterfaceWithWindow:(UIWindow *)widnow completion:(nonnull void(^)(void))completion;

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
