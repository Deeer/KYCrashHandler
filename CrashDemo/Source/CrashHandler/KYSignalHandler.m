//
//  KYSignalHandler.m
//  CrashDemo
//
//  Created by Dee on 2019/1/5.
//  Copyright © 2019 apple. All rights reserved.
//

#import "KYSignalHandler.h"


void handleSignal(int signal) {
    [KYSignalHandler performSelector:@selector(hadnelException:) withObject:nil afterDelay:0];
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

+ (void)hadnelException:(NSException *)exception {
    // TODO: 如果有需要尝试在这里做一些其他工作


    // 采用默认方式处理
    signal(SIGABRT, SIG_DFL);
    signal(SIGILL, SIG_DFL);
    signal(SIGSEGV, SIG_DFL);
    signal(SIGFPE, SIG_DFL);
    signal(SIGBUS, SIG_DFL);
    signal(SIGPIPE, SIG_DFL);
}

@end
