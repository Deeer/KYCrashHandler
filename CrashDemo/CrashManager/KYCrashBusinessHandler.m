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
@interface KYCrashBusinessHandler()

@property(nonatomic, strong) NSObject <KYCrashLogUploadOperation>*uploader;

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
    // TODO: 单独时间log类
    //
}

- (void)addCustionContent:(NSString *)content {
    // 设置每个crash文件中的自定义内容
    _customContent = content;
}



@end
