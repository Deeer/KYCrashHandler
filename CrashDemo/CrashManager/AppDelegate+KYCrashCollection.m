//
//  AppDelegate+KYCrashCollection.m
//  CrashDemo
//
//  Created by apple on 2018/11/15.
//  Copyright © 2018 apple. All rights reserved.
//

#import "AppDelegate+KYCrashCollection.h"
#import <objc/runtime.h>

#import "KYCrashBusinessHandler.h"
@implementation AppDelegate (KYCrashCollection)

#pragma mark - lifeCyele

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 进行方法替换
        [self swizzleOriginMethod:@selector(applicationDidFinishLaunching:)
               WithExchangeMethod:@selector(swizzled_application:didFinishLaunchingWithOptions:)];
        [self swizzleOriginMethod:@selector(applicationWillTerminate:)
               WithExchangeMethod:@selector(swizzleOriginMethod:WithExchangeMethod:)];
    });
}

#pragma mark - privateMethod

- (BOOL)swizzled_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    
    // 本地存在crash文件
    if (1) {
        // TODO: 处理连续崩溃逻辑: 若本地存在crash 文件 进入的 连续闪退判段逻辑
        if (1) { // TODO:符合连续闪退
                 // TODO:进入修复流程 -- 显示页面 or 直接修复
            
        }

        
        [[KYCrashBusinessHandler shareInstance] uploadContentWithCompletion:^(BOOL isSuccess, NSError * _Nonnull error) {
            // 我也不知道这里可以做什么...
        }];
        
    } else {
        // 调用原生方法
        [self swizzled_application:application didFinishLaunchingWithOptions:launchOptions];
    }
    return YES;
}

- (void)swizzled_applicationWillTerminate:(UIApplication *)application {
    
    // TODO: 记录崩溃冲突时间
    
    // TODO: 调用原生方法
    [self swizzled_applicationWillTerminate:application];
}


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
