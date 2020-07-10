//
//  XTMyCarCellLabel.m
//  Sitech
//
//  Created by wangchuang on 2018/7/27.
//  Copyright © 2018年 sitechTeam. All rights reserved.
//

#import "XTMyCarCellLabel.h"
#import "XTFontAndColorMacros.h"

@implementation XTMyCarCellLabel

- (instancetype)initWithFontSize:(NSInteger)numebr color:(UIColor *)fontColor {
    self = [super init];
    if (self) {
        self.font = FONT(@"PingFangSC-Regular", numebr);
        self.textColor = fontColor;
//        self.text = @"暂无数据";
    }
    return self;
}

- (void)setStr1:(NSString *)str1 color1:(UIColor *)color1 WithStr2:(NSString *)str2 color2:(UIColor *)color2 allStr:(NSString *)str{
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange range1 = [str rangeOfString:str1];
    [attStr addAttribute:NSForegroundColorAttributeName value:color1 range:range1];
    NSRange range2 = [str rangeOfString:str2];
    [attStr addAttribute:NSForegroundColorAttributeName value:color2 range:range2];
    self.attributedText = attStr;
}

@end
