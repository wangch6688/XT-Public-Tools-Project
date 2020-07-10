//
//  NSString+Url.m
//  MixMining
//
//  Created by 张发政 on 2018/5/18.
//  Copyright © 2018年 北京芯智引擎科技有限公司. All rights reserved.
//

#import "NSString+Url.h"

@implementation NSString (Url)
- (NSString *)URLEncodedString
{
    
    NSCharacterSet *set = [NSCharacterSet alphanumericCharacterSet]; //所有数字和字母
    
    NSString *encodedString =  [self stringByAddingPercentEncodingWithAllowedCharacters:set];
//    NSString *encodedString = (NSString *)
//    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
//                                                              (CFStringRef)self,
//                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
//                                                              NULL,
//                                                              kCFStringEncodingUTF8));
    return encodedString;
}
@end
