//
//  XTCustomButtonGroup.m
//  Sitech
//
//  Created by 张发政 on 2020/6/29.
//  Copyright © 2020 sitechTeam. All rights reserved.
//

#import "XTCustomButtonGroup.h"
#import "XTBaseCustomButton.h"
#import "XTCustomButtonOverlay.h"

@interface XTCustomButtonGroup ()
@property (nonatomic, strong) NSArray *buttons;
@property (nonatomic, assign) NSUInteger buttonCount;

@end

@implementation XTCustomButtonGroup

- (instancetype)init {
    NSLog(@"XTCustomButtonGroup must be initialized with initWithFrame:buttonTitles:style: or initWithFrame:buttonIcons:style:");
    return nil;
}

- (instancetype)initWithFrame:(CGRect)frame {
    NSLog(@"XTCustomButtonGroup must be initialized with initWithFrame:buttonTitles:style: or initWithFrame:buttonIcons:style:");
    return nil;
}

- (instancetype)initWithFrame:(CGRect)frame buttonTitles:(NSArray *)buttonTitles style:(XTCustomButtonStyle)style cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth{
    if (self = [super initWithFrame:frame]) {
        [self _initButtonGroupWithSelector:@selector(setText:) andObjects:buttonTitles style:style cornerRadius:cornerRadius borderWidth:borderWidth];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame buttonIcons:(NSArray *)buttonIcons style:(XTCustomButtonStyle)style cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth{
    if (self = [super initWithFrame:frame]) {
        [self _initButtonGroupWithSelector:@selector(setIcon:) andObjects:buttonIcons style:style cornerRadius:cornerRadius borderWidth:borderWidth];
    }
    return self;
}

- (void)layoutSubviews {
    
    if (self.buttonCount == 0) return;
    
    CGSize size = self.bounds.size;
    CGFloat buttonWidth = size.width / self.buttonCount;
    CGFloat buttonHeight = size.height;
    
    [self.buttons enumerateObjectsUsingBlock:^void(XTBaseCustomButton *button, NSUInteger idx, BOOL *stop) {
        button.frame = CGRectMake(buttonWidth * idx, 0.0, buttonWidth, buttonHeight);
    }];
}

- (XTBaseCustomButton *)buttonAtIndex:(NSUInteger)index {
    return self.buttons[index];
}

#pragma mark - Override Setters

- (void)setAnimated:(BOOL)animated {
    _animated = animated;
    for (XTBaseCustomButton *button in self.buttons) {
        button.animated = animated;
    }
}

- (void)setAnimationDuration:(CGFloat)animationDuration {
    _animationDuration = animationDuration;
    for (XTBaseCustomButton *button in self.buttons) {
        button.animationDuration = animationDuration;
    }
}

- (void)setInvertAlphaHighlighted:(CGFloat)invertAlphaHighlighted {
    _invertAlphaHighlighted = invertAlphaHighlighted;
    for (XTBaseCustomButton *button in self.buttons) {
        button.invertAlphaHighlighted = invertAlphaHighlighted;
    }
}

- (void)setTranslucencyAlphaNormal:(CGFloat)translucencyAlphaNormal {
    _translucencyAlphaNormal = translucencyAlphaNormal;
    for (XTBaseCustomButton *button in self.buttons) {
        button.translucencyAlphaNormal = translucencyAlphaNormal;
    }
}

- (void)setTranslucencyAlphaHighlighted:(CGFloat)translucencyAlphaHighlighted {
    _translucencyAlphaHighlighted = translucencyAlphaHighlighted;
    for (XTBaseCustomButton *button in self.buttons) {
        button.translucencyAlphaHighlighted = translucencyAlphaHighlighted;
    }
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    [self.buttons.firstObject setCornerRadius:cornerRadius];
    [self.buttons.lastObject setCornerRadius:cornerRadius];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    for (XTBaseCustomButton *button in self.buttons) {
        button.borderWidth = borderWidth;
    }
}

- (void)setFont:(UIFont *)font {
    _font = font;
    [self.buttons makeObjectsPerformSelector:@selector(setFont:) withObject:font];
}

#ifdef __IPHONE_8_0
- (void)setVibrancyEffect:(UIVibrancyEffect *)vibrancyEffect {
    _vibrancyEffect = vibrancyEffect;
    [self.buttons makeObjectsPerformSelector:@selector(setVibrancyEffect:) withObject:vibrancyEffect];
}
#endif

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    NSLog(@"XTCustomButtonGroup: backgroundColor is deprecated and has no effect. Use tintColor instead.");
    [super setBackgroundColor:backgroundColor];
}

- (void)setTintColor:(UIColor *)tintColor {
    _tintColor = tintColor;
    [self.buttons makeObjectsPerformSelector:@selector(setTintColor:) withObject:tintColor];
}

#pragma mark - Private Methods

- (void)_initButtonGroupWithSelector:(SEL)selector andObjects:(NSArray *)objects style:(XTCustomButtonStyle)style  cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth{
    
    _cornerRadius = cornerRadius;
    _borderWidth = borderWidth;
    
    self.opaque = NO;
    self.userInteractionEnabled = YES;
    
    NSMutableArray *buttons = [NSMutableArray array];
    NSUInteger count = objects.count;
    
    [objects enumerateObjectsUsingBlock:^void(id object, NSUInteger idx, BOOL *stop) {
        
        XTBaseCustomButton *button = [[XTBaseCustomButton alloc] initWithFrame:CGRectZero style:style];
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [button performSelector:selector withObject:object];
#pragma clang diagnostic pop
        
        if (count == 1) {
            button.roundingCorners = UIRectCornerAllCorners;
        } else if (idx == 0) {
            button.roundingCorners = UIRectCornerTopLeft | UIRectCornerBottomLeft;
            button.hideRightBorder = YES;
        } else if (idx == count - 1) {
            button.roundingCorners = UIRectCornerTopRight | UIRectCornerBottomRight;
        } else {
            button.roundingCorners = (UIRectCorner)0;
            button.cornerRadius = 0;
            button.hideRightBorder = YES;
        }
        
        [self addSubview:button];
        [buttons addObject:button];
    }];
    
    self.buttons = buttons;
    self.buttonCount = count;
}
@end
