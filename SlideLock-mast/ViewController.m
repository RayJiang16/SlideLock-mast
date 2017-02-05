//
//  ViewController.m
//  SlideLock-mast
//
//  Created by Emily on 2017/1/30.
//  Copyright © 2017年 Ray. All rights reserved.
//

#import "ViewController.h"
#import "RAYSlideLockViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *btnText = @[@"设置密码", @"验证密码", @"重置密码"];
    for (SInt8 i = 0; i < 3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:btnText[i] forState:UIControlStateNormal];
        btn.frame = CGRectMake(100, 100+100*i, 100, 40);
        btn.tag = i;
        [btn addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)didClickButton:(UIButton *)sender {
    RAYSlideLockViewController *vc = [RAYSlideLockViewController new];
    vc.slideLockType = sender.tag;
    [self presentViewController:vc animated:YES completion:nil];
}

@end
