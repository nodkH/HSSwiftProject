//
//  HSValidate.h
//  ChinaLink
//
//  Created by 孔祥刚 on 2019/5/10.
//  Copyright © 2019 ChinaLink. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSValidate : NSObject

/// 手机号验证
+ (BOOL)validateMobilePhoneNumber:(NSString *)mobileNum;

/// 验证正整数
+ (BOOL)validatePositiveInteger:(NSString *)string;


/// 验证是否汉字
+ (BOOL)validateHanZi:(NSString *)string;
@end

NS_ASSUME_NONNULL_END
