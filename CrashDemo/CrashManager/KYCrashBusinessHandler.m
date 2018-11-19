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
+ (void)openLog:(BOOL)isopen {
    // TODO: 单独log类
    //
}

- (void)addCustionContent:(NSString *)content {
    // 设置每个crash文件中的自定义内容
    _customContent = content;
}

- (void)showRepairWithWindow:(UIWindow *)window completion:(void(^)(void))completion {
    // 是否自定义界面的
    if (self.repairViewController) {
        // 回调交给自类去做去
        [self.repairViewController getFinshRepairWithCallback:completion];
        window.rootViewController = self.repairViewController;
        [window makeKeyAndVisible];
    } else {
        // 显示默认的弹窗效果
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = [UIColor purpleColor];
        window.rootViewController = vc;
        [window makeKeyAndVisible];
        [vc presentViewController:[self showAlertWtihCompletion:completion] animated:YES completion:nil];
    }
}

- (UIAlertController *)showAlertWtihCompletion:(void(^)(void))completion {
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"修复" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completion();
    }];
    [alertVc addAction:cancleAction];
    [alertVc addAction:confirmAction];
    return alertVc;
}


#pragma mark - setterAndGetter

- (KYCrashRepairViewController *)repairViewController {
    if (!_repairViewController) {
        Class class = [findSubClass([KYCrashRepairViewController class]) firstObject];
        if (!class) {
            return nil;
        }
        _repairViewController = [[class alloc] init];
    }
    return _repairViewController;
}

- (KYCrashUploader *)uploader {
    if (!_uploader) {
        Class class = [findSubClass([KYCrashUploader class]) firstObject];
        
        NSAssert(class, @"请继承 KYCrashUploader 以实现日志上传功能");
        
        _uploader = [[class alloc] init];
    }
    return _uploader;
}
@end
