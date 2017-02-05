//
//  RAYSlideLockSmallView.h
//  SlideLock-mast
//
//  Created by Emily on 2017/1/30.
//  Copyright © 2017年 Ray. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RAYSlideLockSmallView : UIView

/**
 * 初始化方法
 */
+ (instancetype)slideLockSmallWithFrame:(CGRect)frame;

/**
 * 显示滑动过的Item
 * @parameter password 滑动密码
 */
- (void)showTipWithPassword:(NSString *)password;

@end
