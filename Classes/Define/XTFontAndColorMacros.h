//
//  STFontAndColorMacros.h
//  Sitech
//
//  Created by xiaoxiao on 2018/1/16.
//  Copyright © 2018年 sitechTeam. All rights reserved.
//

#ifndef XTFontAndColorMacros_h
#define XTFontAndColorMacros_h

#import "UIColor+expanded.h"

#pragma mark -  颜色区
#define KBackground     [UIColor colorWithHexString:@"000000"]
#define KNavBg          [UIColor colorWithHexString:@"000000"] //导航栏颜色

#pragma mark --线颜色
#define kLineViewColor [UIColor colorWithHexString:@"F2F2F2"] //224 224 224
#define kBorderColor [UIColor colorWithHexString:@"C1C1C1"]//边框颜色

#define kFontBlack80 [[UIColor colorWithHexString:@"333333"]colorWithAlphaComponent:1] //51 51 51
#define kFontContentColor [UIColor colorWithHexString:@"666666"] //102 102 102
#define kFontCellContentColor [UIColor colorWithHexString:@"999999"] //153 153 153
#define kFontCellGrayColor [UIColor colorWithHexString:@"C1C1C1"] //193 193 193

#define KClearColor [UIColor clearColor]
#define KWhiteColor [UIColor whiteColor]
#define KBlackColor [UIColor blackColor]
#define KGrayColor [UIColor grayColor]
#define KGray2Color [UIColor lightGrayColor]
#define KBlueColor [UIColor blueColor]
#define KRedColor [UIColor redColor]

//蓝色
#define kSystemColor(a) [UIColor colorWithRed:(81 / 255.0) green:(143 / 255.0) blue:(243 / 255.0) alpha:(a)]
//辅色
#define kSystemSecondaryColor(a) [UIColor colorWithRed:(39 / 255.0) green:(190 / 255.0) blue:(255 / 255.0) alpha:(a)]
//主字体颜色
#define kSystemTextColor(a) [UIColor colorWithRed:(44 / 255.0) green:(44 / 255.0) blue:(44 / 255.0) alpha:(a)]
//子标题字体颜色
#define kSystemSubitleTextColor [UIColor colorWithRed:(95 / 255.0) green:(101 / 255.0) blue:(112 / 255.0) alpha:1]
//次要标题字体颜色
#define kSystemSecondaryTextColor [UIColor colorWithHexString:@"B5B5B5"]
//提示信息文字颜色
#define kSystemPromptTextColor [UIColor colorWithHexString:@"FF6C0A"]

#define KRGBAlpha(r, g, b, a)   [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]
#define KUIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8) )/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define KUIColorHexValue(value, alphaValue) [UIColor colorWithRed:((float)((value & 0xFF0000) >> 16))/255.0 green:((float)((value & 0xFF00) >> 8) )/255.0 blue:((float)(value & 0xFF))/255.0 alpha:(alphaValue)]


#pragma mark -  字体区
#define BOLDSYSTEMFONT(FONTSIZE)    [UIFont boldSystemFontOfSize:FONTSIZE]
#define SYSTEMFONT(FONTSIZE)        [UIFont systemFontOfSize:FONTSIZE]
#define FONT(NAME, FONTSIZE)        [UIFont fontWithName:(NAME) size:(FONTSIZE)]
#define Font_Large_Title            [UIFont fontWithName:@"PingFangSC-Medium" size: 16.0f]
#define Font_Large_Text             [UIFont fontWithName:@"PingFangSC-Regular" size: 16.0f]
#define Font_Regular_Title          [UIFont fontWithName:@"PingFangSC-Medium" size: 14.0f]
#define Font_Regular_Text           [UIFont fontWithName:@"PingFangSC-Regular" size: 14.0f]
#define Font_Regular_Light          [UIFont fontWithName:@"PingFangSC-Light" size: 14.0f]
#define Font_Medium_Title           [UIFont fontWithName:@"PingFangSC-Medium" size: 13.0f]
#define Font_Medium_Text            [UIFont fontWithName:@"PingFangSC-Regular" size: 13.0f]
#define Font_Medium_Light           [UIFont fontWithName:@"PingFangSC-Light" size: 13.0f]
#define Font_Small_Title            [UIFont fontWithName:@"PingFangSC-Medium" size: 12.0f]
#define Font_Small_Text             [UIFont fontWithName:@"PingFangSC-Regular" size: 12.0f]


#define FONT_PF_BOLD                 @"PingFangSC-Bold"
#define FONT_PF_SEMIBOLD             @"PingFangSC-Semibold"
#define FONT_PF_MEDIUM               @"PingFangSC-Medium"
#define FONT_PF_LIGHT                @"PingFangSC-Light"
#define FONT_MONOSPACE               @"Menlo-Bold"
#define FONT_MONOSPACE_SMALL         @"Menlo-Regular"
#define FONT_NORMAL                  @"HelveticaNeue"
#define FONT_MEDIUM                  @"HelveticaNeue-Medium"
#define FONT_BOLD                    @"HelveticaNeue-Bold"
#define FONT_ITALIC                  @"HelveticaNeue-Italic"
#define FONT_BOLD_ITALIC             @"HelveticaNeue-BoldItalic"

#endif /* XTFontAndColorMacros_h */
