//
//  XTCustomButtonOverlay.h
//  Sitech
//
//  Created by 张发政 on 2020/6/29.
//  Copyright © 2020 sitechTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef enum {
    
    XTCustomButtonOverlayStyleNormal,
    XTCustomButtonOverlayStyleInvert,
    XTCustomButtonOverlayStyleCustom
} XTCustomButtonOverlayStyle;

@interface XTCustomButtonOverlay : UIView

// numeric configurations
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, assign) UIRectCorner roundingCorners;
@property (nonatomic, assign) CGFloat borderWidth;

// icon image
@property (nonatomic, strong) UIImage *icon;

// display text
@property (nonatomic, copy)   NSString *text;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) NSAttributedString * attributedText;

// the deprecated background color
@property (nonatomic, strong) UIColor *backgroundColor DEPRECATED_MSG_ATTRIBUTE("Use tintColor instead.");

// tint color
@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, assign) XTCustomButtonOverlayStyle style;
@property (nonatomic, assign) CGFloat textHeight;
@property (nonatomic, assign) BOOL hideRightBorder;

- (instancetype)initWithStyle:(XTCustomButtonOverlayStyle)style cornerRadius:(CGFloat)cornerRadius roundingCorners:(UIRectCorner)roundingCorners borderWidth:(CGFloat)borderWidth tintColor:(UIColor *)tintColor font: (UIFont *) font textColor:(UIColor *)textColor;

- (void)updateTintColor:(UIColor *)tintColor text:(NSString *)text;
@end

NS_ASSUME_NONNULL_END
