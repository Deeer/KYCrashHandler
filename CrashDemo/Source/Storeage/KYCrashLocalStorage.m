//
//  KYCrashLocalStorage.m
//  CrashDemo
//
//  Created by apple on 2018/11/15.
//  Copyright © 2018 apple. All rights reserved.
//

#import "KYCrashLocalStorage.h"
#import "NSDate+TimeTool.h"
@implementation KYCrashLocalStorage


#pragma mark - save
/**
 保存崩溃信息
 
 @param exceptionInfoDict 崩溃信息内容
 @return 是否写入成功
 */
+ (BOOL)saveCrashLogLocallyWithDict:(NSDictionary *)exceptionInfoDict {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *crashFileDirectory = [self crashFileDirectoryPath];
    //
    BOOL isSuccess = [fileManager createDirectoryAtPath:crashFileDirectory
                            withIntermediateDirectories:YES
                                             attributes:nil
                                                  error:nil];
    NSAssert(isSuccess, @"文件夹创建失败");
    if (isSuccess) {
        NSString *currentTime = [NSDate currentTimeFormatString];
        BOOL isSaved = [exceptionInfoDict writeToFile:[self filePathWithTime:currentTime] atomically:YES];
        NSAssert(isSaved, @"crash文件保存失败");
        return isSaved;
    }
    
    return NO;
}


#pragma mark - read
/**
 从本地文件中读取数据
 
 @return 文件中的二进制数据
 */
+ (NSData *)readCrashLogContextFromLocalData {
    NSString *crashFileDirctory = [self crashFileDirectoryPath];
    NSFileManager *manager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *array = [manager contentsOfDirectoryAtPath:crashFileDirctory error:&error];
    NSAssert(error, @"文件读取失败");
    if (array.count == 0) {
        return nil;
    }
    
    NSString *name = [array firstObject];
    NSString *filePath = [crashFileDirctory stringByAppendingPathComponent:name];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    return  data;
}

#pragma mark - delete

/**
 删除文件夹下的所有文件
 
 @return 是否删除成功
 */
+ (BOOL)clearCrashFile {
    NSString *crashFileDirectory = [self crashFileDirectoryPath];
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![self existFileAtPath:crashFileDirectory]) {
        return YES;
    }
    
    NSArray *contents = [manager contentsOfDirectoryAtPath:crashFileDirectory error:NULL];
    if (contents.count == 0) {
        return YES;
    }
    
    NSEnumerator *enums = [contents objectEnumerator];
    NSString *filename;
    BOOL success = YES;
    while (filename = [enums nextObject]) {
        if(![manager removeItemAtPath:[crashFileDirectory stringByAppendingPathComponent:filename] error:NULL]) {
            success = NO;
            break;
        }
    }
    return success;
}


+ (BOOL)existCrashFiles {
    return [self existFileAtPath: [self crashFileDirectoryPath]];
}

+ (BOOL)existFileAtPath:(NSString *)path {
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL exist =  [manager fileExistsAtPath:path];
    return exist;
}



#pragma mark - privateMethod
/**
 创建文件路径
 */
+ (NSString *)filePathWithTime:(NSString *)time {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *fileName = [NSString stringWithFormat:@"%@_%@Crashlog.plist", time, infoDictionary[@"CFBundleName"]];
    NSString *filePath = [[self crashFileDirectoryPath] stringByAppendingPathComponent:fileName];
    return filePath;
}

/**
 创建文件夹路径
 */
+ (NSString *)crashFileDirectoryPath {
    NSString *cachesDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *crashFileDirectoryPath = [cachesDirectoryPath stringByAppendingPathComponent:@"CrashLogs"];
    return crashFileDirectoryPath;
}

@end
