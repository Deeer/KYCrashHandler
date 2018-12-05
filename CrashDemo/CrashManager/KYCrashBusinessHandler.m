//
//  KYCrashBusinessHandler.m
//  CrashDemo
//
//  Created by apple on 2018/11/16.
//  Copyright © 2018 apple. All rights reserved.
//

#import "KYCrashBusinessHandler.h"
#import "KYCrashLogUploadOperation.h"
#import "KYCrashLocalStorage.h"

#import <objc/runtime.h>
#import "KYCrashUploader.h"
#import "KYCrashRepairViewController.h"

static inline NSArray * findSubClass(Class certainClass) {
    
    int numOfSubclasses = 0;
    Class *classes = NULL;
    // 获取所有已注册的类
    numOfSubclasses = objc_getClassList(NULL, 0);
    
    if (numOfSubclasses <= 0) {
        return [NSMutableArray array];
    }
    
    classes = (Class *)malloc(sizeof(Class) * numOfSubclasses);
    objc_getClassList(classes, numOfSubclasses);
    NSArray *classArray = @[];
    for (int i = 0; i < numOfSubclasses; i++) {
        if (certainClass == class_getSuperclass(classes[i])) {
            classArray = @[classes[i]];
            break;
        }
    }
    
    free(classes);
    return classArray;
}

@interface KYCrashBusinessHandler()

@property(nonatomic, strong) KYCrashUploader *uploader;

@property(nonatomic, strong) KYCrashRepairViewController *repairViewController;

@end

@implementation KYCrashBusinessHandler

+ (KYCrashBusinessHandler *)shareInstance {
    static dispatch_once_t onceToken;
    __block KYCrashBusinessHandler *handler;
    dispatch_once(&onceToken, ^{
        handler = [[KYCrashBusinessHandler alloc] init];
    });
    return handler;
}

- (BOOL)exsitRepairViewController {
    return (BOOL)self.repairViewController;
}

- (BOOL)exsitUploader {
    return (BOOL)self.uploader;
}

#pragma mark - logical content
- (void)uploadContentWithCompletion:(void(^)(BOOL isSuccess, NSError * _Nonnull error))completion {
    NSAssert(!self.uploader, @"未设置上传对象");
    NSData *data = [KYCrashLocalStorage readCrashLogContextFromLocalData];
    [self.uploader uploadCrashLog:data withCompletion:^(BOOL isSuccess, NSError * _Nonnull error) {
        // 清理本地日志数据
        [KYCrashLocalStorage clearCrashFile];
        // 回调上一级对象做进一步处理
        !completion ? : completion(isSuccess, error);
    }];
}

#pragma mark - options

- (void)showRepairInterfaceWithWindow:(UIWindow *)window completion:(void(^)(void))completion {
    if (self.repairViewController) {
        // 设置修复界面
        UINavigationController *naVc= [[UINavigationController alloc] initWithRootViewController:self.repairViewController];
        window.rootViewController = naVc;
        self.repairViewController.hidesBottomBarWhenPushed = YES;
        [window makeKeyAndVisible];
        // 传入回调
        [self.repairViewController didFinishRepairWithCompletion:completion];
    }
}

#pragma mark - setterAndGetter

- (KYCrashRepairViewController *)currentRepairViewController {
    return self.repairViewController;
}

- (KYCrashRepairViewController *)repairViewController {
    if (!_repairViewController) {
        Class class = [findSubClass([KYCrashRepairViewController class]) firstObject];
        NSAssert(class, @"❌ 请继承 KYCrashRepairViewController 以实现修复功能");
        _repairViewController = [[class alloc] init];
    }
    return _repairViewController;
}

- (KYCrashUploader *)uploader {
    if (!_uploader) {
        Class class = [findSubClass([KYCrashUploader class]) firstObject];
        NSAssert(class, @"❌ 请继承 KYCrashUploader 以实现日志上传功能");
        _uploader = [[class alloc] init];
    }
    return _uploader;
}
@end
