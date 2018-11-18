//
//  KYCrashLocalStorage.h
//  CrashDemo
//
//  Created by apple on 2018/11/15.
//  Copyright © 2018 apple. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN
// 本地化存储管理
@interface KYCrashLocalStorage : NSObject

/**
 保存崩溃信息到本地文件

 @param exceptionInfoDict 崩溃信息,其中已包含错误日志
 @return 是否写入成功
 */
+ (BOOL)saveCrashLogLocallyWithDict:(NSDictionary *)exceptionInfoDict;


/**
 从本地文件中读取数据

 @return 文件中的二进制数据
 */
+ (NSData * _Nullable )readCrashLogContextFromLocalData;


/**
 删除文件夹下的所有文件

 @return 是否删除成功
 */
+ (BOOL)clearCrashFile;


/**
 判断特定路径下是否存在特定的文件or文件夹

 @param path 路径
 @return 是否存在
 */
+ (BOOL)existFileAtPath:(NSString *)path;
@end

NS_ASSUME_NONNULL_END
