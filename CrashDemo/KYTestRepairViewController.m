//
//  KYTestRepairViewController.m
//  CrashDemo
//
//  Created by apple on 2018/12/5.
//  Copyright © 2018 apple. All rights reserved.
//

#import "KYTestRepairViewController.h"

@interface KYTestRepairViewController ()

@property(nonatomic, strong) UIButton *tryBtn;

@property(nonatomic, copy) finishedRepairCallback myBlock;

@end

@implementation KYTestRepairViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    self.navigationController.navigationBar.hidden = YES;
    [self.view addSubview:self.tryBtn];
    self.tryBtn.frame = CGRectMake(0, 0, 100, 60);
    self.tryBtn.center = self.view.center;
    
}

- (void)didFinishRepairWithCompletion:(finishedRepairCallback)block {
    // 做一些修复工作

    // 完成之后进行跳转
    self.myBlock = block;
}

#pragma mark - eventRespond
- (void)doneAction {
    
    // 完成之后进行跳转
    !self.myBlock ? : self.myBlock();
}

#pragma mark - setterAndGetter
- (UIButton *)tryBtn {
    if (!_tryBtn) {
        _tryBtn = [[UIButton alloc] init];
        [_tryBtn setTitle:@"修复完成" forState:UIControlStateNormal];
        [_tryBtn setBackgroundColor:[UIColor blueColor]];
        [_tryBtn addTarget:self action:@selector(doneAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tryBtn;
}

@end
