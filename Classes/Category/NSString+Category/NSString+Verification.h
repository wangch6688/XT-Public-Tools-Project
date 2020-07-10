//
//  NSString+Verification.h
//  OperationEquipment
//
//  Created by 张发政 on 2017/3/13.
//  Copyright © 2017年 cyberplus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Verification)
#pragma mark - 验证手机号码是否合法
+ (BOOL)stringValidateMobile:(NSString *)mobileNum;


//验证IP是否合法
- (BOOL)stringValidateIP;

/**
 nil, @"", @"  ", @"\n" will Returns NO; otherwise Returns YES.
 */
- (BOOL)isNotBlank;
//获取手机型号
+ (NSString *)iphoneType;

- (BOOL)stringValidateEmail;

//至少8个字符，并且包含大小写字母和数字
- (BOOL)passwordValidateEmail_8_up_lo;

//包含字母大小写
- (BOOL)passwordInclidUpLow;

//包含数字
- (BOOL)passwordInclidNumber;

+ (BOOL)verifyIDCardNumber:(NSString *)IDCardNumber;
//包含字母
- (BOOL)passwordInclidLetter;

//以太坊地址校验
- (BOOL)ethAddressInclid;

//比特币，莱特币，zcash地址校验
- (BOOL)btc_ltc_zcashAddressInclid;

//验证有0-8位小数的正实数
- (BOOL)number_of_8_decimal;

@end
