//
//  ViewController.m
//  CrashDemo
//
//  Created by apple on 2018/11/14.
//  Copyright © 2018 apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc] init];
    [btn addTarget:self action:@selector(popAction) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"试一下" forState:UIControlStateNormal];
    btn.frame = CGRectMake(100, 100, 100, 100);
    btn.center = self.view.center;
    [self.view addSubview:btn];
}

- (void)popAction {
    [[[NSMutableArray alloc] init] addObject:nil];
}


@end
