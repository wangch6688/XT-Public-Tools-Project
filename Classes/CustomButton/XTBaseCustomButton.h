//
//  XTBaseCustomButton.h
//  Sitech
//
//  Created by 张发政 on 2020/6/29.
//  Copyright © 2020 sitechTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XTCustomButtonOverlay.h"

NS_ASSUME_NONNULL_BEGIN

/** XTBaseCustomButton **/

typedef enum {
    
    XTCustomButtonStyleInvert,
    XTCustomButtonStyleTranslucent,
    XTCustomButtonStyleFill
    
} XTCustomButtonStyle;


@interface XTBaseCustomButton : UIControl
@property (nonatomic, assign) BOOL animated;
@property (nonatomic, assign) CGFloat animationDuration;
@property (nonatomic, assign) CGFloat alpha;
@property (nonatomic, assign) CGFloat invertAlphaHighlighted;
@property (nonatomic, assign) CGFloat translucencyAlphaNormal;
@property (nonatomic, assign) CGFloat translucencyAlphaHighlighted;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, assign) UIRectCorner roundingCorners;
@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, strong) UIImage *selectedicon;
@property (nonatomic, strong) UIImage *disabledicon;
@property (nonatomic, copy)   NSString *text;
@property (nonatomic, copy)   NSString *selectedtext;
@property (nonatomic, copy)   NSString *disabledtext;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, assign) BOOL hideRightBorder;
#ifdef __IPHONE_8_0
// the vibrancy effect to be applied on the button
@property (nonatomic, assign) BOOL isUsevibrancyEffect;//是否启用活力效果
@property (nonatomic, strong) UIVibrancyEffect *vibrancyEffect;
#endif

// the deprecated background color
@property (nonatomic, strong) UIColor *backgroundColor DEPRECATED_MSG_ATTRIBUTE("Use tintColor instead.");

// the tint color when vibrancy effect is nil, or not supported.
@property (nonatomic, strong) UIColor *tintColor;

//不可点击状态的颜色
@property (nonatomic, strong) UIColor *disabledColor;

//选中状态的颜色
@property (nonatomic, strong) UIColor *selectedColor;

//正常状态的字体样式
@property (nonatomic, strong) NSAttributedString *normalAttributedString;

//选中状态的字体样式
@property (nonatomic, strong) NSAttributedString *selectedAttributedString;

//不可用状态的字体样式
@property (nonatomic, strong) NSAttributedString *disabledAttributedString;

//选中状态的字体
@property (nonatomic, strong) UIFont *selectedAttributedFont;

//不可用状态的字体
@property (nonatomic, strong) UIFont *disabledAttributedFont;

// this is the only method to initialize a vibrant button
- (instancetype)initWithFrame:(CGRect)frame style:(XTCustomButtonStyle)style;

- (instancetype)initWithFrame:(CGRect)frame style:(XTCustomButtonStyle)style cornerRadius:(CGFloat)cornerRadius roundingCorners:(UIRectCorner)roundingCorners borderWidth:(CGFloat)borderWidth;
@end

NS_ASSUME_NONNULL_END
