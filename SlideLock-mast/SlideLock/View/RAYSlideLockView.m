//
//  RAYSlideLockView.m
//  SlideLock-mast
//
//  Created by Emily on 2017/1/30.
//  Copyright © 2017年 Ray. All rights reserved.
//

#import "RAYSlideLockView.h"
#import "RAYSlideLockItem.h"
#import "UIView+Extension.h"

@interface RAYSlideLockView ()
@property (nonatomic, strong) NSArray<RAYSlideLockItem *> *allItem;
@property (nonatomic, strong) NSMutableArray<RAYSlideLockItem *> *allSelectedItem;
@property (nonatomic, assign) CGPoint currentPoint;
@property (nonatomic, assign) BOOL canTouch;

@end

@implementation RAYSlideLockView

#pragma mark - Init
+ (instancetype)slideLockWithFrame:(CGRect)frame {
    return [[RAYSlideLockView alloc] initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _allSelectedItem = [NSMutableArray array];
        _canTouch = YES;
        _showSlidePath = YES;
        [self initItem];
    }
    return self;
}

- (void)initItem {
    CGFloat widthSpace = self.width/3;
    CGFloat heightSpcae = self.height/3;
    CGFloat itemWidth = widthSpace*0.5;
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (SInt8 i = 0; i < 9; i++) {
        SInt8 row = i/3;
        SInt8 column = i%3;
        CGFloat x = widthSpace*0.5-itemWidth*0.5 + column*widthSpace;
        CGFloat y = heightSpcae*0.5-itemWidth*0.5 + row*heightSpcae;
        RAYSlideLockItem *item = [RAYSlideLockItem itemWithFrame:CGRectMake(x, y, itemWidth, itemWidth)];
        item.tag = i;
        item.state = RAYSlideLockItemStateNormal;
        [mutableArray addObject:item];
        [self addSubview:item];
    }
    self.allItem = [mutableArray copy];
}

#pragma mark - 
- (void)drawRect:(CGRect)rect {
    if (self.allSelectedItem.count == 0 || !_showSlidePath) return;
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (SInt8 i = 0; i < self.allSelectedItem.count; i++) {
        RAYSlideLockItem *item = self.allSelectedItem[i];
        CGPoint itemCenter = item.center;
        i == 0 ? [path moveToPoint:itemCenter] : [path addLineToPoint:itemCenter];
    }
    
    [path addLineToPoint:self.currentPoint];
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineWidth = 8;
    self.canTouch ? [raySelectedColor setStroke] : [rayErrorColor setStroke];
    [path stroke];
}

#pragma mark - 公开方法
- (void)alert {
    self.canTouch = NO;
    for (RAYSlideLockItem *item in self.allSelectedItem) {
        item.state = RAYSlideLockItemStateError;
    }
    [self setNeedsDisplay];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self restoreItem];
        self.canTouch = YES;
    });
}

- (void)restoreItem {
    for (RAYSlideLockItem *item in self.allSelectedItem) {
        item.state = RAYSlideLockItemStateNormal;
    }
    [self.allSelectedItem removeAllObjects];
    [self setNeedsDisplay];
}

#pragma mark - Touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!self.canTouch) return;
    [self pointChanged:[self getPoint:touches]];
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!self.canTouch) return;
    [self pointChanged:[self getPoint:touches]];
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!self.canTouch || self.allSelectedItem.count==0) return;
    if ([self.delegate respondsToSelector:@selector(didGetPassword:)]) {
        [self.delegate didGetPassword:[self getPassword]];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self restoreItem];
}

#pragma mark - 其他方法
/// 当前点发生改变调用的方法，功能-判断当前点是否在Item中
- (void)pointChanged:(CGPoint)point {
    for (RAYSlideLockItem *item in self.allItem) {
        if (CGRectContainsPoint(item.frame, point) && ![self.allSelectedItem containsObject:item]) {
            item.state = _showSlidePath ? RAYSlideLockItemStateSelectd : RAYSlideLockItemStateNormal;
            [self.allSelectedItem addObject:item];
        }
    }
}

/// 获取当前触目的点
- (CGPoint)getPoint:(NSSet<UITouch *> *)touches {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    self.currentPoint = point;
    return point;
}

/// 获取滑动密码
- (NSString *)getPassword {
    NSMutableString *password = [NSMutableString string];
    for (SInt8 i = 0; i < self.allSelectedItem.count; i++) {
        RAYSlideLockItem *item = self.allSelectedItem[i];
        [password appendFormat:@"%ld", item.tag];
    }
    return [password copy];
}

@end
