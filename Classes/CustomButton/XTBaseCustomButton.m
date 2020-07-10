//
//  XTBaseCustomButton.m
//  Sitech
//
//  Created by 张发政 on 2020/6/29.
//  Copyright © 2020 sitechTeam. All rights reserved.
//

#import "XTBaseCustomButton.h"
#import "XTCustomButtonOverlay.h"
#import <XTFontAndColorMacros.h>

#define kXTCustomButtonDefaultAnimationDuration 0.15
#define kXTCustomButtonDefaultAlpha 1.0
#define kXTCustomButtonDefaultInvertAlphaHighlighted 1.0
#define kXTCustomButtonDefaultTranslucencyAlphaNormal 1.0
#define kXTCustomButtonDefaultTranslucencyAlphaHighlighted 0.5
#define kXTCustomButtonDefaultCornerRadius 6.0
#define kXTCustomButtonDefaultBorderWidth 0.6
#define kXTCustomButtonDefaultFontSize 14.0
#define kXTCustomButtonDefaultTintColor [UIColor greenColor]
#define kXTCustomButtonDefaultDisabledColor [UIColor grayColor]

/** XTBaseCustomButton **/

@interface XTBaseCustomButton (){
    
    __strong UIColor *_tintColor;
}

@property (nonatomic, assign) XTCustomButtonStyle style;

#ifdef __IPHONE_8_0
@property (nonatomic, strong) UIVisualEffectView *visualEffectView;
#endif

@property (nonatomic, strong) XTCustomButtonOverlay *normalOverlay;
@property (nonatomic, strong) XTCustomButtonOverlay *highlightedOverlay;

@property (nonatomic, assign) BOOL activeTouch;


- (void)createOverlays;
- (void)updateOverlayAlpha;


@end

@implementation XTBaseCustomButton

- (instancetype)init {
    NSLog(@"XTBaseCustomButton must be initialized with initWithFrame:style:");
    
    return nil;
}

- (instancetype)initWithFrame:(CGRect)frame {
    NSLog(@"XTBaseCustomButton must be initialized with initWithFrame:style:");
    return nil;
}

- (instancetype)initWithFrame:(CGRect)frame style:(XTCustomButtonStyle)style {
    if (self = [self initWithFrame:frame style:style cornerRadius:kXTCustomButtonDefaultCornerRadius roundingCorners:UIRectCornerAllCorners borderWidth:kXTCustomButtonDefaultBorderWidth]) {
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(XTCustomButtonStyle)style cornerRadius:(CGFloat)cornerRadius roundingCorners:(UIRectCorner)roundingCorners borderWidth:(CGFloat)borderWidth{
    if (self = [super initWithFrame:frame]) {
            
            self.style = style;
            self.opaque = NO;
            self.userInteractionEnabled = YES;
            
            // default values
            _animated = YES;
            _animationDuration = kXTCustomButtonDefaultAnimationDuration;
            _cornerRadius = cornerRadius;
            _roundingCorners = roundingCorners;
            _borderWidth = borderWidth;
            _tintColor = kSystemColor(1);
            _disabledColor = kSystemColor(1);
            _font = [UIFont systemFontOfSize:kXTCustomButtonDefaultFontSize];
            _invertAlphaHighlighted = kXTCustomButtonDefaultInvertAlphaHighlighted;
            _translucencyAlphaNormal = kXTCustomButtonDefaultTranslucencyAlphaNormal;
            _translucencyAlphaHighlighted = kXTCustomButtonDefaultTranslucencyAlphaHighlighted;
            _alpha = kXTCustomButtonDefaultAlpha;
            _activeTouch = NO;
            
            // create overlay views
            [self createOverlays];
            
    #ifdef __IPHONE_8_0
            // add the default vibrancy effect
            self.vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
            
    #endif
            
            [self addTarget:self action:@selector(touchDown) forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragInside];
            [self addTarget:self action:@selector(touchUp) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside | UIControlEventTouchDragOutside | UIControlEventTouchCancel];
        }
        return self;
}

- (void)layoutSubviews {
#ifdef __IPHONE_8_0
    self.visualEffectView.frame = self.bounds;
#endif
    self.normalOverlay.frame = self.bounds;
    self.highlightedOverlay.frame = self.bounds;
}

- (void)createOverlays {
    
    if (self.style == XTCustomButtonStyleFill) {
        self.normalOverlay = [[XTCustomButtonOverlay alloc] initWithStyle:XTCustomButtonOverlayStyleInvert cornerRadius:_cornerRadius roundingCorners:_roundingCorners borderWidth:_borderWidth tintColor:_tintColor font:_font textColor:_tintColor];
    } else {
        self.normalOverlay = [[XTCustomButtonOverlay alloc] initWithStyle:XTCustomButtonOverlayStyleNormal cornerRadius:_cornerRadius roundingCorners:_roundingCorners borderWidth:_borderWidth  tintColor:_tintColor font:_font textColor:_tintColor];
    }
    
    if (self.style == XTCustomButtonStyleInvert) {
        self.highlightedOverlay = [[XTCustomButtonOverlay alloc] initWithStyle:XTCustomButtonOverlayStyleInvert cornerRadius:_cornerRadius roundingCorners:_roundingCorners borderWidth:_borderWidth  tintColor:_tintColor font:_font textColor:_tintColor];
        self.highlightedOverlay.alpha = 0.0;
    } else if (self.style == XTCustomButtonStyleTranslucent || self.style == XTCustomButtonStyleFill) {
        self.normalOverlay.alpha = self.translucencyAlphaNormal * self.alpha;
    }
    
#ifndef __IPHONE_8_0
    // for iOS 8, these two overlay views will be added as subviews in setVibrancyEffect:
    [self addSubview:self.normalOverlay];
    [self addSubview:self.highlightedOverlay];
#endif
    
}

- (void)updateOverlayAlpha {
    
    if (self.activeTouch) {
        if (self.style == XTCustomButtonStyleInvert) {
            self.normalOverlay.alpha = 0.0;
            self.highlightedOverlay.alpha = self.invertAlphaHighlighted * self.alpha;
        } else if (self.style == XTCustomButtonStyleTranslucent || self.style == XTCustomButtonStyleFill) {
            self.normalOverlay.alpha = self.translucencyAlphaHighlighted * self.alpha;
        }
    } else {
        if (self.style == XTCustomButtonStyleInvert) {
            self.normalOverlay.alpha = self.alpha;
            self.highlightedOverlay.alpha = 0.0;
        } else if (self.style == XTCustomButtonStyleTranslucent || self.style == XTCustomButtonStyleFill) {
            self.normalOverlay.alpha = self.translucencyAlphaNormal * self.alpha;
        }
    }
}

#pragma mark - Control Event Handlers

- (void)touchDown {
    
    self.activeTouch = YES;
    
    void(^update)(void) = ^(void) {
        if (self.style == XTCustomButtonStyleInvert) {
            self.normalOverlay.alpha = 0.0;
            self.highlightedOverlay.alpha = self.alpha;
        } else if (self.style == XTCustomButtonStyleTranslucent || self.style == XTCustomButtonStyleFill) {
            self.normalOverlay.alpha = self.translucencyAlphaHighlighted * self.alpha;
        }
    };
    
    if (self.animated) {
        [UIView animateWithDuration:self.animationDuration animations:update];
    } else {
        update();
    }
}

- (void)touchUp {
    
    self.activeTouch = NO;
    
    void(^update)(void) = ^(void) {
        if (self.style == XTCustomButtonStyleInvert) {
            self.normalOverlay.alpha = self.alpha;
            self.highlightedOverlay.alpha = 0.0;
        } else if (self.style == XTCustomButtonStyleTranslucent || self.style == XTCustomButtonStyleFill) {
            self.normalOverlay.alpha = self.translucencyAlphaNormal * self.alpha;
        }
    };
    
    if (self.animated) {
        [UIView animateWithDuration:self.animationDuration animations:update];
    } else {
        update();
    }
}

#pragma mark - Override Getters

- (UIColor *)tintColor {
    return _tintColor;
}

#pragma mark - Override Setters

- (void)setAlpha:(CGFloat)alpha {
    _alpha = alpha;
    [self updateOverlayAlpha];
}

- (void)setInvertAlphaHighlighted:(CGFloat)invertAlphaHighlighted {
    _invertAlphaHighlighted = invertAlphaHighlighted;
    [self updateOverlayAlpha];
}

- (void)setTranslucencyAlphaNormal:(CGFloat)translucencyAlphaNormal {
    _translucencyAlphaNormal = translucencyAlphaNormal;
    [self updateOverlayAlpha];
}

- (void)setTranslucencyAlphaHighlighted:(CGFloat)translucencyAlphaHighlighted {
    _translucencyAlphaHighlighted = translucencyAlphaHighlighted;
    [self updateOverlayAlpha];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    self.normalOverlay.cornerRadius = cornerRadius;
    self.highlightedOverlay.cornerRadius = cornerRadius;
}

- (void)setRoundingCorners:(UIRectCorner)roundingCorners {
    _roundingCorners = roundingCorners;
    self.normalOverlay.roundingCorners = roundingCorners;
    self.highlightedOverlay.roundingCorners = roundingCorners;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    self.normalOverlay.borderWidth = borderWidth;
    self.highlightedOverlay.borderWidth = borderWidth;
}

- (void)setIcon:(UIImage *)icon {
    _icon = icon;
    self.normalOverlay.icon = icon;
    self.highlightedOverlay.icon = icon;
}

- (void)setText:(NSString *)text {
    _text = [text copy];
    self.normalOverlay.text = text;
    self.highlightedOverlay.text = text;
}

- (void)setFont:(UIFont *)font {
    _font = font;
    self.normalOverlay.font = font;
    self.highlightedOverlay.font = font;
}

#ifdef __IPHONE_8_0
- (void)setVibrancyEffect:(UIVibrancyEffect *)vibrancyEffect {
    
    _vibrancyEffect = vibrancyEffect;
    
    [self.normalOverlay removeFromSuperview];
    [self.highlightedOverlay removeFromSuperview];
    [self.visualEffectView removeFromSuperview];
    
    if (vibrancyEffect != nil && _isUsevibrancyEffect) {
        self.visualEffectView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];
        self.visualEffectView.userInteractionEnabled = NO;
        [self.visualEffectView.contentView addSubview:self.normalOverlay];
        [self.visualEffectView.contentView addSubview:self.highlightedOverlay];
        [self addSubview:self.visualEffectView];
    } else {
        [self addSubview:self.normalOverlay];
        [self addSubview:self.highlightedOverlay];
    }
}
#endif

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    NSLog(@"XTBaseCustomButton: backgroundColor is deprecated and has no effect. Use tintColor instead.");
    [super setBackgroundColor:backgroundColor];
}

- (void)setTintColor:(UIColor *)tintColor {
    _tintColor = tintColor;
    if(self.enabled){
        self.normalOverlay.tintColor = _tintColor;
        self.highlightedOverlay.tintColor = _tintColor;
    }
}

- (void)setDisabledColor:(UIColor *)disabledColor{
    _disabledColor = disabledColor;
    if(!self.enabled){
        _normalOverlay.tintColor = _disabledColor;
        _highlightedOverlay.tintColor = _disabledColor;
    }
}

- (void)setSelectedColor:(UIColor *)selectedColor{
    _selectedColor =  selectedColor;
    if (self.enabled  &&  self.isSelected) {
        _normalOverlay.tintColor = _selectedColor;
        _highlightedOverlay.tintColor = _selectedColor;
    }
}

- (void)setHideRightBorder:(BOOL)hideRightBorder {
    _hideRightBorder = hideRightBorder;
    self.normalOverlay.hideRightBorder = hideRightBorder;
    self.highlightedOverlay.hideRightBorder = hideRightBorder;
}

-(void)setEnabled:(BOOL)enabled{
    [super setEnabled:enabled];
    if(enabled){
        if (_normalAttributedString) {
            _normalOverlay.attributedText = _normalAttributedString;
        }else {
            [_normalOverlay updateTintColor:_tintColor text:_text];
        }
        
    }else{
        if (_disabledAttributedString) {
            _normalOverlay.attributedText = _disabledAttributedString;
        }else {
            [_normalOverlay updateTintColor:_disabledColor?_disabledColor:_tintColor text:_disabledtext?_disabledtext:_text];
        }
    }
    
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {
        if (_selectedAttributedString) {
            self.normalOverlay.attributedText = _selectedAttributedString;
        }else {
            [self.normalOverlay updateTintColor:_selectedColor?_selectedColor:_tintColor text:_selectedtext?_selectedtext:_text];
        }
    }else{
        if (_normalAttributedString) {
            self.normalOverlay.attributedText = _normalAttributedString;
        }else {
            [self.normalOverlay updateTintColor:_tintColor text:_text];
        }
    }
}

@end


