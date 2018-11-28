//
//  UIApplication+KYCrashHandler.m
//  CrashDemo
//
//  Created by apple on 2018/11/28.
//  Copyright © 2018 apple. All rights reserved.
//

#import "UIApplication+KYCrashHandler.h"
#import "Aspects.h"
@implementation UIApplication (KYCrashHandler)

+ (void)load {
    [UIApplication  aspect_hookSelector:@selector(setDelegate:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo){
        NSLog(@"instance : %@",aspectInfo.instance);
        NSLog(@"params %@",aspectInfo.arguments);
        id instance = [aspectInfo.instance delegate];
        
        [instance aspect_hookSelector:@selector(application:didFinishLaunchingWithOptions:) withOptions:AspectPositionInstead usingBlock:^(id<AspectInfo> aspectInfo){
            [aspectInfo.originalInvocation invoke];
            NSLog(@"1----params %@",aspectInfo.arguments);
            
        } error:NULL];
        
        
        
        [instance aspect_hookSelector:@selector(applicationWillTerminate:) withOptions:AspectPositionInstead usingBlock:^(id<AspectInfo> aspectInfo){
            NSLog(@"2----params %@",aspectInfo.arguments);
        } error:NULL];
        
    } error:NULL];
}

@end
