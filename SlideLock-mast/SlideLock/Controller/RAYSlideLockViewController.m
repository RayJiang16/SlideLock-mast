//
//  RAYSlideLockViewController.m
//  SlideLock-mast
//
//  Created by Emily on 2017/1/30.
//  Copyright © 2017年 Ray. All rights reserved.
//

#import "RAYSlideLockViewController.h"
#import "RAYSlideLockView.h"
#import "RAYSlideLockSmallView.h"
#import "RAYSlideLockModel.h"
#import "UIView+Extension.h"
#import "UIView+RAYShake.h"

@interface RAYSlideLockViewController () <RAYSlideLockViewDelegate>
@property (nonatomic, strong) RAYSlideLockView *lockView;
@property (nonatomic, strong) RAYSlideLockSmallView *tipView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) RAYSlideLockModel *model;

@end

@implementation RAYSlideLockViewController

#pragma mark - Init
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initView];
    _model = [RAYSlideLockModel new];
    _showSlidePath = YES;
    self.slideLockType = self.slideLockType;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initView {
    _lockView = [RAYSlideLockView slideLockWithFrame:CGRectMake(0, self.view.height-self.view.width-80, self.view.width, self.view.width)];
    _lockView.backgroundColor = [UIColor clearColor];
    _lockView.delegate = self;
    [self.view addSubview:_lockView];
    _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _lockView.y-20, self.view.width, 10)];
    _tipLabel.font = [UIFont systemFontOfSize:15];
    _tipLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_tipLabel];
    _tipView = [RAYSlideLockSmallView slideLockSmallWithFrame:CGRectMake(self.view.width*0.5-25, _tipLabel.y-60, 50, 50)];
    _tipView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tipView];
}

#pragma mark - View
/// 设置提示文本
- (void)setTipText:(NSString *)text isAlert:(BOOL)alert {
    self.tipLabel.text = text;
    self.tipLabel.textColor = alert ? [UIColor redColor] : [UIColor blackColor];
    !alert ?: [self.tipLabel shake];
}

/// 设置提示View的Hidden
- (void)setupTipViewHidden:(BOOL)hidden {
    self.tipView.hidden = hidden;
    self.tipLabel.y = hidden ? self.lockView.y-45 : self.lockView.y-20;
}

#pragma mark - Setter
- (void)setSlideLockType:(RAYSlideLockType)slideLockType {
    _slideLockType = slideLockType;
    switch (slideLockType) {
        case RAYSlideLockInit:
            [self setTipText:@"请绘制解锁图案" isAlert:NO];
            [self setupTipViewHidden:NO];
            break;
        case RAYSlideLockCheck :
            [self setTipText:@"请绘制解锁图案" isAlert:NO];
            [self setupTipViewHidden:YES];
            break;
        case RAYSlideLockReset:
            [self setTipText:@"请绘制原解锁图案" isAlert:NO];
            [self setupTipViewHidden:YES];
            break;
    }
}

- (void)setShowSlidePath:(BOOL)showSlidePath {
    _showSlidePath = showSlidePath;
    self.lockView.showSlidePath = showSlidePath;
}

#pragma mark - Delegate
#pragma mark <Lock View Delegate>
- (void)didGetPassword:(NSString *)password {
    if (self.slideLockType == RAYSlideLockInit) {
        [self.model settingPassword:password completeBlock:^(BOOL isSuccess, RAYSettingState state) {
            if (state == RAYSettingFirst) {
                [self setTipText:@"再次绘制解锁图案" isAlert:NO];
                [self.tipView showTipWithPassword:password];
                [self.lockView restoreItem];
            } else if (state == RAYSettingSecond && isSuccess) {
                [self setTipText:@"绘制解锁图案成功" isAlert:NO];
                [self.lockView restoreItem];
                [self dismissViewControllerAnimated:YES completion:nil];
            } else if (state == RAYSettingSecond && !isSuccess) {
                [self setTipText:@"与上次绘制不一致,请重新绘制" isAlert:YES];
                [self.lockView alert];
            }
        }];
    } else if (self.slideLockType == RAYSlideLockCheck || self.slideLockType == RAYSlideLockReset) {
        [self.model checkPassword:password completeBlock:^(BOOL isSuccess, RAYCheckState state) {
            if (state == RAYCheckExit) {
                [self setTipText:@"请先设置解锁图案" isAlert:NO];
                [self.lockView restoreItem];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    self.slideLockType = RAYSlideLockInit;
                });
            } else if (state == RAYCheckSuccess) {
                [self setTipText:@"解锁成功" isAlert:NO];
                [self.lockView restoreItem];
                // Reset分支-验证成功重设密码
                if (self.slideLockType == RAYSlideLockReset) {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        self.slideLockType = RAYSlideLockInit;
                    });
                } else {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
            } else if (state == RAYCheckFail) {
                [self setTipText:@"密码错误" isAlert:YES];
                [self.lockView alert];
            }
        }];
    }
}

@end
