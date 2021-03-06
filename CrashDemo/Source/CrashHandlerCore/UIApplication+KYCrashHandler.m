//
//  UIApplication+KYCrashHandler.m
//  CrashDemo
//
//  Created by apple on 2018/11/28.
//  Copyright © 2018 apple. All rights reserved.
//

#import "UIApplication+KYCrashHandler.h"
#import "Aspects.h"
#import "KYTimeRecorder.h"
#import "KYCrashBusinessHandler.h"
#import "KYCrashLocalStorage.h"
#import "KYCrashRepairViewController.h"
#import "UIApplication+FindRepairViewController.h"
#import "KYSignalHandler.h"
@implementation UIApplication (KYCrashHandler)

+ (void)load {
    [UIApplication  aspect_hookSelector:@selector(setDelegate:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo){
        
        id instance = [aspectInfo.instance delegate];
        
        [instance aspect_hookSelector:@selector(application:didFinishLaunchingWithOptions:) withOptions:AspectPositionInstead usingBlock:^(id<AspectInfo> aspectInfo){
            // 注册崩溃日志收集函数
            NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
            // 注册信号量监听
            [KYSignalHandler registSignaleHandler];
            // 记录启动时间
            [KYTimeRecorder recordTimeWithType:KYTimeRecordTypeLauncher];
            // TODO: 之前做些什么
            // 处理闪退问题
            // 本地存在crash文件
            if ([KYCrashLocalStorage existCrashFiles]) {
                
                // 进入闪退判断逻辑  && 继承并实现修复界面
                if ([self findRepairViewController] && // 存在修复界面
                    [KYTimeRecorder isInContinuousTerminateStatus] ) { // 符合连续崩溃条件
                    
                        // 为修复界面提供window用以显示
                        KYCrashRepairViewController *repairViewController = [self findRepairViewController];;
                        UINavigationController *naVc= [[UINavigationController alloc] initWithRootViewController:repairViewController];
                        UIWindow *window = [[UIApplication sharedApplication] delegate].window;
                        window.rootViewController = naVc;
                        [window makeKeyAndVisible];
                
                        // 执行修复回调
                        [repairViewController didFinishRepairWithCompletion:^{
                          [aspectInfo.originalInvocation invoke];
                        }];
                    
                } else {
                    // 调用原始方法
                    [aspectInfo.originalInvocation invoke];
                }
                
            } else {
                // 调用原始方法
               [aspectInfo.originalInvocation invoke];
            }
            
        } error:NULL];
        
        // hook
        [instance aspect_hookSelector:@selector(applicationWillTerminate:) withOptions:AspectPositionInstead usingBlock:^(id<AspectInfo> aspectInfo){
            // 记录终止时间
            [KYTimeRecorder recordTimeWithType:KYTimeRecordTypeTerminate];
            // 调用原始方法
            [aspectInfo.originalInvocation invoke];
            
        } error:NULL];
        
    } error:NULL];
}

@end
