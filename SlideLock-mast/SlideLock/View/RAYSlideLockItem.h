//
//  RAYSlideLockItem.h
//  SlideLock-mast
//
//  Created by Emily on 2017/1/30.
//  Copyright © 2017年 Ray. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RAYSliderLockHeader.h"

typedef NS_ENUM(NSUInteger, RAYSlideLockItemState) {
    RAYSlideLockItemStateNormal,
    RAYSlideLockItemStateSelectd,
    RAYSlideLockItemStateError,
};

@interface RAYSlideLockItem : UIView
/// Item的状态
@property (nonatomic, assign) RAYSlideLockItemState state;

/**
 * 初始化方法
 */
+ (instancetype)itemWithFrame:(CGRect)frame;

@end
