//
//  UIView+RAYShake.m
//  SlideLock-mast
//
//  Created by Emily on 2017/2/4.
//  Copyright © 2017年 Ray. All rights reserved.
//

#import "UIView+RAYShake.h"

@implementation UIView (RAYShake)

- (void)shake {
    CAKeyframeAnimation *kfa = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    CGFloat s = 16;
    kfa.values = @[@(-s),@(0),@(s),@(0),@(-s),@(0),@(s),@(0)];
    kfa.duration = .1f;
    kfa.repeatCount =2;
    kfa.removedOnCompletion = YES;
    [self.layer addAnimation:kfa forKey:@"shake"];
}

@end
