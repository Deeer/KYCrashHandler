//
//  KYExtraInfoPlugin.m
//  CrashDemo
//
//  Created by Dee on 2019/1/10.
//  Copyright © 2019 apple. All rights reserved.
//

#import "KYExtraInfoPlugin.h"

#define KYMethodNotImplemented() \
@throw [NSException exceptionWithName:NSInternalInconsistencyException \
reason:[NSString stringWithFormat:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)] \
userInfo:nil]

@implementation KYExtraInfoPlugin


- (NSDictionary *)generateExtraInfo {
    KYMethodNotImplemented();
}

@end
