//
//  RAYSlideLockView.h
//  SlideLock-mast
//
//  Created by Emily on 2017/1/30.
//  Copyright © 2017年 Ray. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RAYSlideLockViewDelegate <NSObject>
@optional
/**
 * 当滑动结束会调用该方法
 * @parameter password 滑动密码
 */
- (void)didGetPassword:(NSString *)password;

@end

@interface RAYSlideLockView : UIView
/// 代理对象
@property (nonatomic, weak) id<RAYSlideLockViewDelegate> delegate;
/// 显示滑动路径 默认为YES
@property (nonatomic, assign) BOOL showSlidePath;

/**
 * 初始化方法
 */
+ (instancetype)slideLockWithFrame:(CGRect)frame;

/**
 * 将滑动过的点和路径设为红色以警告,过1秒后自动调用restoreItem方法
 */
- (void)alert;
/**
 * 清除滑动过的点
 */
- (void)restoreItem;

@end
