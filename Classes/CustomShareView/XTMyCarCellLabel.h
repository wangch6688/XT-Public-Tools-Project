//
//  XTMyCarCellLabel.h
//  Sitech
//
//  Created by wangchuang on 2018/7/27.
//  Copyright © 2018年 sitechTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XTMyCarCellLabel : UILabel

- (instancetype)initWithFontSize:(NSInteger)numebr color:(UIColor *)fontColor;

- (void)setStr1:(NSString *)str1 color1:(UIColor *)color1 WithStr2:(NSString *)str2 color2:(UIColor *)color2 allStr:(NSString *)str;

@end
