//
//  KYCrashRepairViewController.h
//  CrashDemo
//
//  Created by apple on 2018/11/19.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^finishedRepairCallback)(void);
NS_ASSUME_NONNULL_BEGIN

@interface KYCrashRepairViewController : UIViewController

/**
 获取的修复完成回掉
 */
- (void)getFinshRepairWithCallback:(finishedRepairCallback)block;

/**
 交给子类重写
 */
- (void)didFinishRepair NS_REQUIRES_SUPER;

@end

NS_ASSUME_NONNULL_END
