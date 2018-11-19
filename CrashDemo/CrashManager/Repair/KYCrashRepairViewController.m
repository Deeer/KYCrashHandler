//
//  KYCrashRepairViewController.m
//  CrashDemo
//
//  Created by apple on 2018/11/19.
//  Copyright © 2018 apple. All rights reserved.
//

#import "KYCrashRepairViewController.h"

@interface KYCrashRepairViewController ()

@property(nonatomic, copy)  finishedRepairCallback finishedRepairBlock;

@end

@implementation KYCrashRepairViewController

// emmm,感觉这样的处理方式不是很好...
- (void)getFinshRepairWithCallback:(finishedRepairCallback)block {
    self.finishedRepairBlock = block;
}




- (void)didFinishRepair {
    !self.finishedRepairBlock ? : self.finishedRepairBlock();
}


@end
