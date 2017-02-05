//
//  RAYSlideLockModel.h
//  SlideLock-mast
//
//  Created by Emily on 2017/2/2.
//  Copyright © 2017年 Ray. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 设置的状态
 * RAYSettingFirst  第一次设置密码
 * RAYSettingSecond 第二次设置密码
 */
typedef enum : NSUInteger {
    RAYSettingFirst,
    RAYSettingSecond,
} RAYSettingState;

/**
 * 检查的状态
 * RAYCheckExit    未设置过密码
 * RAYCheckSuccess 校对密码成功
 * RAYCheckFail    校对密码错误
 */
typedef enum : NSUInteger {
    RAYCheckExit,
    RAYCheckSuccess,
    RAYCheckFail,
} RAYCheckState;

@interface RAYSlideLockModel : NSObject

/**
 * 设置密码逻辑结束后调用的Block
 * @parameter isSuccess 是否设置密码成功
 * @parameter state 设置的状态
 */
typedef void(^RAYSetBlock)(BOOL isSuccess, RAYSettingState state);

/**
 * 检查密码逻辑结束后调用的Block
 * @parameter isSuccess 密码是否正确
 * @parameter state 检查的状态
 */
typedef void(^RAYCheckBlock)(BOOL isSuccess, RAYCheckState state);


/**
 * 设置密码
 * @parameter password 滑动密码
 * @parameter completeBlock 完成设置逻辑后调用的Block
 */
- (void)settingPassword:(NSString *)password completeBlock:(RAYSetBlock)completeBlock;

/**
 * 检查密码
 * @parameter password 滑动密码
 * @parameter completeBlock 完成检查逻辑后调用的Block
 */
- (void)checkPassword:(NSString *)password completeBlock:(RAYCheckBlock)completeBlock;

@end
