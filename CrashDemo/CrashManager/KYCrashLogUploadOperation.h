//
//  KYCrashLogUploadOperation.h
//  CrashDemo
//
//  Created by apple on 2018/11/15.
//  Copyright © 2018 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol KYCrashLogUploadOperation <NSObject>

/**
 上传方法抽取

 @param data 上传的crash数据
 @param completion 回调
 */
- (void)uploadCrashLog:(NSData * _Nullable )data
        withCompletion:( nullable void(^)(BOOL isSuccess, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
