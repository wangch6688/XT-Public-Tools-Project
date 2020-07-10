//
//  NSString+Range.h
//  MyFramework
//
//  Created by 张发政 on 2017/1/12.
//  Copyright © 2017年 zhangfazheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Range)
/**
 *  Finds and returns the ranges of a given string, within the given range of the receiver.
 *  查找一个字符串中是否包含每个给定字符串，并包返回所有包含该字符串的位置
 *
 *  @param searchString searchString.
 *  @param mask         A mask specifying search options. The following options may be specified by combining them with the C bitwise OR operator: NSCaseInsensitiveSearch, NSLiteralSearch, NSBackwardsSearch, NSAnchoredSearch. See String Programming Guide for details on these options.
 *  @param range        serachRange.
 *
 *  @return Ranges.
 */
- (NSArray <NSValue *> *)rangesOfString:(NSString *)searchString options:(NSStringCompareOptions)mask serachRange:(NSRange)range;

//数字三位分隔
+ (NSString *)countNumAndChangeformat:(NSString *)num;
//用给定字符分隔字符串
+ (NSString *)countStringAndChangeformat:(NSString *)string sapce:(NSString *)space count:(NSInteger) count;
@end
