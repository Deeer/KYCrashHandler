//
//  KYSignalHandler.m
//  CrashDemo
//
//  Created by Dee on 2019/1/5.
//  Copyright © 2019 apple. All rights reserved.
//

#import "KYSignalHandler.h"
#include <libkern/OSAtomic.h>
#include <execinfo.h>
#import "KYExceptionHandler.h"


void handleSignal(int signal) {
    
    // getCurrentCallStack
    NSArray *callStack = [KYSignalHandler backtrace];
    NSMutableDictionary *userInfo =[NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:signal] forKey:@"signal"];
    [userInfo setObject:callStack forKey:@"callStackSymbols"];
    NSException *ex = [NSException exceptionWithName:@"SignalExceptionName" reason:[NSString stringWithFormat:@"Signal %d was raised.\n",signal] userInfo:userInfo];
    // 为了不阻塞线程
    dispatch_queue_t queue = dispatch_queue_create("KYCrashHandler.signal", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        // 异步处理exception
        [KYSignalHandler performSelector:@selector(handleException:) withObject:ex afterDelay:0];
        // 主动关闭
        exit(0);
    });
    
}

@implementation KYSignalHandler

+ (void)registSignaleHandler {
    // 注册信号监听，并进行相应处理
    signal(SIGABRT, handleSignal);
    signal(SIGILL, handleSignal);
    signal(SIGSEGV, handleSignal);
    signal(SIGFPE, handleSignal);
    signal(SIGBUS, handleSignal);
    signal(SIGPIPE, handleSignal);
}

// 处理异常用到的方法
+ (void)handleException:(NSException *)exception {
    
    // 将转化后的exception 直接交给exceptionHandler处理
    uncaughtExceptionHandler(exception);
}

// 获取函数堆栈信息
+ (NSArray *)backtrace {
    
    void* callstack[128];
    int frames = backtrace(callstack, 128);//用于获取当前线程的函数调用堆栈，返回实际获取的指针个数
    char **strs = backtrace_symbols(callstack, frames);//从backtrace函数获取的信息转化为一个字符串数组
    int i;
    NSMutableArray *backtrace = [NSMutableArray arrayWithCapacity:frames];
    for (i = 0;i < frames;i++)
    {
        [backtrace addObject:[NSString stringWithUTF8String:strs[i]]];
    }
    free(strs);
    return backtrace;
}


@end
