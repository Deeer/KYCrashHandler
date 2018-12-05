//
//  UIApplication+FindRepairViewController.m
//  CrashDemo
//
//  Created by apple on 2018/12/5.
//  Copyright © 2018 apple. All rights reserved.
//

#import "UIApplication+FindRepairViewController.h"
#import "KYCrashRepairViewController.h"
#import "KYClassFinder.h"

@implementation UIApplication (FindRepairViewController)

+ (KYCrashRepairViewController *)findRepairViewController {
    Class class = [findSubClass([KYCrashRepairViewController class]) firstObject];
    NSAssert(class, @"❌ 请继承 KYCrashRepairViewController 以实现修复功能");
    KYCrashRepairViewController *vc = [[class alloc] init];
    return vc;
}

@end
