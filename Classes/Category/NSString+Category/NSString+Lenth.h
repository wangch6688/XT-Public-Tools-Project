//
//  NSString+Lenth.h
//  MyProjectTestDome
//
//  Created by 张发政 on 2020/5/21.
//  Copyright © 2020 张发政. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
struct HWTitleInfo {
    NSInteger length;
    NSInteger number;
};
typedef struct HWTitleInfo HWTitleInfo;

@interface NSString (Lenth)

/// 计算字符串字节长度
- (NSUInteger)charactorNumber;
- (NSUInteger)charactorNumberWithEncoding:(NSStringEncoding)encoding;
- (HWTitleInfo)getInfoWithMaxLength:(NSInteger)maxLength;
@end

NS_ASSUME_NONNULL_END
