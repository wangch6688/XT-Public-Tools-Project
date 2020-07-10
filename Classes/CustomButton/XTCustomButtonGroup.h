//
//  XTCustomButtonGroup.h
//  Sitech
//
//  Created by 张发政 on 2020/6/29.
//  Copyright © 2020 sitechTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XTBaseCustomButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface XTCustomButtonGroup : UIView

@property (nonatomic, readonly) NSArray *buttons;
@property (nonatomic, readonly) NSUInteger buttonCount;

@property (nonatomic, assign) BOOL animated;
@property (nonatomic, assign) CGFloat animationDuration;
@property (nonatomic, assign) CGFloat invertAlphaHighlighted;
@property (nonatomic, assign) CGFloat translucencyAlphaNormal;
@property (nonatomic, assign) CGFloat translucencyAlphaHighlighted;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, strong) UIFont *font;

#ifdef __IPHONE_8_0
// the vibrancy effect to be applied on the button
@property (nonatomic, strong) UIVibrancyEffect *vibrancyEffect;
#endif

// the deprecated background color
@property (nonatomic, strong) UIColor *backgroundColor DEPRECATED_MSG_ATTRIBUTE("Use tintColor instead.");

// the tint color when vibrancy effect is nil, or not supported.
@property (nonatomic, strong) UIColor *tintColor;

- (instancetype)initWithFrame:(CGRect)frame buttonTitles:(NSArray *)buttonTitles style:(XTCustomButtonStyle)style cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth;
- (instancetype)initWithFrame:(CGRect)frame buttonIcons:(NSArray *)buttonIcons style:(XTCustomButtonStyle)style cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth;

- (XTBaseCustomButton *)buttonAtIndex:(NSUInteger)index;
@end

NS_ASSUME_NONNULL_END
