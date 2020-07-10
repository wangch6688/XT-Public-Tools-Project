//
//  NSString+Lenth.m
//  MyProjectTestDome
//
//  Created by 张发政 on 2020/5/21.
//  Copyright © 2020 张发政. All rights reserved.
//

#import "NSString+Lenth.h"

@implementation NSString (Lenth)
- (NSUInteger)charactorNumber
{
    NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    return [self charactorNumberWithEncoding:encoding];
}

- (NSUInteger)charactorNumberWithEncoding:(NSStringEncoding)encoding
{
    NSUInteger strLength = 0;
    char *p = (char *)[self cStringUsingEncoding:encoding];
    
    NSUInteger lengthOfBytes = [self lengthOfBytesUsingEncoding:encoding];
    for (int i = 0; i < lengthOfBytes; i++) {
        if (*p) {
            p++;
            strLength++;
        }
        else {
            p++;
        }
    }
    return strLength;
}

//判断中英混合的的字符串长度及字符个数
- (HWTitleInfo)getInfoWithMaxLength:(NSInteger)maxLength
{
    HWTitleInfo title;
    int length = 0;
    int singleNum = 0;
    int totalNum = 0;
    char *p = (char *)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i = 0; i < [self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++) {
        if (*p) {
            length++;
            if (length <= maxLength) {
                totalNum++;
            }
        }
        else {
            if (length <= maxLength) {
                singleNum++;
            }
        }
        p++;
    }
    
    title.length = length;
    title.number = (totalNum - singleNum) / 2 + singleNum;
    
    return title;
}

//按照中文两个字符，英文数字一个字符计算字符数
-(NSUInteger) unicodeLength{
    NSUInteger asciiLength = 0;
    for (NSUInteger i = 0; i < self.length; i++) {
        unichar uc = [self characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    return asciiLength;
}
@end
