//
//  RAYSlideLockItem.m
//  SlideLock-mast
//
//  Created by Emily on 2017/1/30.
//  Copyright © 2017年 Ray. All rights reserved.
//

#import "RAYSlideLockItem.h"
#import "UIView+Extension.h"

@interface RAYSlideLockItem ()
@property (nonatomic, strong) CAShapeLayer *outCircle;
@property (nonatomic, strong) CAShapeLayer *insideCircle;

@end

@implementation RAYSlideLockItem

#pragma mark - Init
+ (instancetype)itemWithFrame:(CGRect)frame {
    return [[RAYSlideLockItem alloc] initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _outCircle = [CAShapeLayer layer];
        _outCircle.path = [UIBezierPath bezierPathWithOvalInRect:self.bounds].CGPath;
        _outCircle.lineWidth = 3;
        _outCircle.fillColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:_outCircle];
        _insideCircle = [CAShapeLayer layer];
        _insideCircle.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.width*0.25, self.width*0.25, self.width*0.5, self.width*0.5)].CGPath;
        _insideCircle.strokeColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:_insideCircle];
    }
    return self;
}

#pragma mark - Setter
- (void)setState:(RAYSlideLockItemState)state {
    _state = state;
    switch (state) {
        case RAYSlideLockItemStateNormal:
            self.outCircle.strokeColor  = rayNormalColor.CGColor;
            self.insideCircle.fillColor = rayNormalColor.CGColor;
            break;
        case RAYSlideLockItemStateSelectd:
            self.outCircle.strokeColor  = raySelectedColor.CGColor;
            self.insideCircle.fillColor = raySelectedColor.CGColor;
            break;
        case RAYSlideLockItemStateError:
            self.outCircle.strokeColor  = rayErrorColor.CGColor;
            self.insideCircle.fillColor = rayErrorColor.CGColor;
            break;
    }
}

@end
