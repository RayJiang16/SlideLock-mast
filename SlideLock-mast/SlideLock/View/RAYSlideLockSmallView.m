//
//  RAYSlideLockSmallView.m
//  SlideLock-mast
//
//  Created by Emily on 2017/1/30.
//  Copyright © 2017年 Ray. All rights reserved.
//

#import "RAYSlideLockSmallView.h"
#import "RAYSliderLockHeader.h"
#import "UIView+Extension.h"

@interface RAYSlideLockSmallView ()
@property (nonatomic, strong) NSArray *allItem;
@end

@implementation RAYSlideLockSmallView

#pragma mark - Init
+ (instancetype)slideLockSmallWithFrame:(CGRect)frame {
    return [[RAYSlideLockSmallView alloc] initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initItem];
    }
    return self;
}

- (void)initItem {
    CGFloat widthSpace = self.width/3;
    CGFloat heightSpcae = self.height/3;
    CGFloat itemWidth = widthSpace*0.7;
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (SInt8 i = 0; i < 9; i++) {
        SInt8 row = i/3;
        SInt8 column = i%3;
        CGFloat x = widthSpace*0.5-itemWidth*0.5 + column*widthSpace;
        CGFloat y = heightSpcae*0.5-itemWidth*0.5 + row*heightSpcae;
        UIView *item = [[UIView alloc] initWithFrame:CGRectMake(x, y, itemWidth, itemWidth)];
        item.tag = i;
        item.backgroundColor = rayNormalColor;
        item.clipsToBounds = YES;
        item.layer.cornerRadius = item.width*0.5;
        [mutableArray addObject:item];
        [self addSubview:item];
    }
    self.allItem = [mutableArray copy];
}

#pragma mark - 公开方法
- (void)showTipWithPassword:(NSString *)password {
    [self restoreItem];
    for (SInt8 i = 0; i < password.length; i ++) {
        SInt8 index = [[password substringWithRange:NSMakeRange(i,1)] integerValue];
        UIView * item = self.allItem[index];
        item.backgroundColor = raySelectedColor;
    }
}

#pragma mark - 私有方法
/// 重置Item
- (void)restoreItem {
    for (UIView *item in self.allItem) {
        item.backgroundColor = rayNormalColor;
    }
}

@end
