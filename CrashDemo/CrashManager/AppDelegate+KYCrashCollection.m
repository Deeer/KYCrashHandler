//
//  AppDelegate+KYCrashCollection.m
//  CrashDemo
//
//  Created by apple on 2018/11/15.
//  Copyright © 2018 apple. All rights reserved.
//

#import "AppDelegate+KYCrashCollection.h"
#import <objc/runtime.h>
#import "KYTimeRecorder.h"
#import "KYCrashBusinessHandler.h"
#import "KYCrashLocalStorage.h"
@implementation AppDelegate (KYCrashCollection)
#pragma mark - lifeCyele
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 进行方法替换
        [self swizzleOriginMethod:@selector(application:didFinishLaunchingWithOptions:)
               WithExchangeMethod:@selector(swizzled_application:didFinishLaunchingWithOptions:)];
        [self swizzleOriginMethod:@selector(applicationWillTerminate:)
               WithExchangeMethod:@selector(swizzled_applicationWillTerminate:)];
    });
}

#pragma mark - logical
- (BOOL)swizzled_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    // 记录启动时间
    [KYTimeRecorder recordTimeWithType:KYTimeRecordTypeLauncher];
    
    // 本地存在crash文件
    if (1 || [KYCrashLocalStorage existCrashFiles]) {
        /******************闪退处理**********************/

        // 进入闪退判断逻辑
        if (1 || [KYTimeRecorder isInContinuousTerminateStatus]) {
            
            // 进行修复工作
            [[KYCrashBusinessHandler shareInstance] showRepairWithWindow:self.window completion:^{
                // 调用原始方法
                [self swizzled_application:application didFinishLaunchingWithOptions:launchOptions];
            }];
            
        } else {
            
            /*****************日志部分********************/
            [[KYCrashBusinessHandler shareInstance] uploadContentWithCompletion:^(BOOL isSuccess, NSError * _Nonnull error) {
                
            }];
            
            // 调用原始方法
            [self swizzled_application:application didFinishLaunchingWithOptions:launchOptions];
        }
    } else {
        // 调用原始方法
        return [self swizzled_application:application didFinishLaunchingWithOptions:launchOptions];
    }
    return YES;
}

- (void)swizzled_applicationWillTerminate:(UIApplication *)application {
    
    // 记录终止时间
    [KYTimeRecorder recordTimeWithType:KYTimeRecordTypeTerminate];
    // 调用原生方法
    [self swizzled_applicationWillTerminate:application];
}


#pragma mark - base

// swizzled
+ (void)swizzleOriginMethod:(SEL)originSelector WithExchangeMethod:(SEL)swizzledSelector {
    Class class = [super class];
    
    Method orginalMethod = class_getInstanceMethod(class, originSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL isAdded = class_addMethod(class,
                                   originSelector,
                                   method_getImplementation(swizzledMethod),
                                   method_getTypeEncoding(swizzledMethod));
    if (isAdded) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(orginalMethod),
                            method_getTypeEncoding(orginalMethod));
    } else {
        method_exchangeImplementations(orginalMethod, swizzledMethod);
    }
}

@end
