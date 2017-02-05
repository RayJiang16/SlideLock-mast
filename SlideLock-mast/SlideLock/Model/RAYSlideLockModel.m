//
//  RAYSlideLockModel.m
//  SlideLock-mast
//
//  Created by Emily on 2017/2/2.
//  Copyright © 2017年 Ray. All rights reserved.
//

#import "RAYSlideLockModel.h"

#define kPasswordKey @"RAYSlideLockKey"

@interface RAYSlideLockModel ()
@property (nonatomic, strong) NSString *password;

@end

@implementation RAYSlideLockModel

#pragma mark - Init
- (instancetype)init
{
    self = [super init];
    if (self) {
        _password = nil;
    }
    return self;
}

#pragma mark - 公开方法
- (void)settingPassword:(NSString *)password completeBlock:(RAYSetBlock)completeBlock {
    if (self.password == nil) {
        self.password = password;
        !completeBlock ?: completeBlock(NO, RAYSettingFirst);
    } else {
        if ([self.password isEqualToString:password]) {
            self.password = nil;
            [self savePassword:password];
            !completeBlock ?: completeBlock(YES, RAYSettingSecond);
        } else {
            !completeBlock ?: completeBlock(NO, RAYSettingSecond);
        }
    }
}

- (void)checkPassword:(NSString *)password completeBlock:(RAYCheckBlock)completeBlock {
    if ([self getPassword] == nil) {
        !completeBlock ?: completeBlock(NO, RAYCheckExit);
    } else if ([[self getPassword] isEqualToString:password]) {
        !completeBlock ?: completeBlock(YES, RAYCheckSuccess);
    } else {
        !completeBlock ?: completeBlock(NO, RAYCheckFail);
    }
}

#pragma mark - 私有方法
/// 获取密码
- (NSString*)getPassword{
    return [[NSUserDefaults standardUserDefaults] valueForKey:kPasswordKey];
}

/// 保存密码
- (void)savePassword:(NSString*)password{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:password forKey:kPasswordKey];
    [userDefaults synchronize];
}

@end
