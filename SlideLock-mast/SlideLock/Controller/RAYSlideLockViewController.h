//
//  RAYSlideLockViewController.h
//  SlideLock-mast
//
//  Created by Emily on 2017/1/30.
//  Copyright © 2017年 Ray. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RAYSliderLockHeader.h"

/**
 * 滑动的类型
 * RAYSlideLockInit  设置密码
 * RAYSlideLockCheck 校对密码
 * RAYSlideLockReset 重置密码
 */
typedef NS_ENUM(NSUInteger, RAYSlideLockType) {
    RAYSlideLockInit,
    RAYSlideLockCheck,
    RAYSlideLockReset,
};

@interface RAYSlideLockViewController : UIViewController
@property (nonatomic, assign) RAYSlideLockType slideLockType;
@property (nonatomic, assign) BOOL showSlidePath;

@end
