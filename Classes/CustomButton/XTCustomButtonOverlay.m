//
//  XTCustomButtonOverlay.m
//  Sitech
//
//  Created by 张发政 on 2020/6/29.
//  Copyright © 2020 sitechTeam. All rights reserved.
//

#import "XTCustomButtonOverlay.h"

@interface XTCustomButtonOverlay () {
    
    __strong UIFont *_font;
    __strong UIColor *_tintColor;
    __strong NSAttributedString *_attributedText;
}

- (void)_updateTextHeight;

@end

@implementation XTCustomButtonOverlay

- (instancetype)initWithStyle:(XTCustomButtonOverlayStyle)style cornerRadius:(CGFloat)cornerRadius roundingCorners:(UIRectCorner)roundingCorners borderWidth:(CGFloat)borderWidth tintColor:(UIColor *)tintColor font: (UIFont *) font textColor:(UIColor *)textColor{
    if (self = [self init]) {
        _cornerRadius = cornerRadius;
        _roundingCorners = roundingCorners;
        _borderWidth = borderWidth;
        _tintColor = tintColor;
        _font = font;
        _textColor = textColor;
        self.style = style;
        
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        
        
        
        self.opaque = NO;
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    CGSize size = self.bounds.size;
    if (size.width == 0 || size.height == 0) return;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, self.bounds);
    
    [self.tintColor setStroke];
    [self.tintColor setFill];
    
    CGRect boxRect = CGRectInset(self.bounds, self.borderWidth / 2, self.borderWidth / 2);
    
    if (self.hideRightBorder) {
        boxRect.size.width += self.borderWidth * 2;
    }
    
    // draw background and border
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:boxRect byRoundingCorners:self.roundingCorners cornerRadii:CGSizeMake(self.cornerRadius, self.cornerRadius)];
    path.lineWidth = self.borderWidth;
    [path stroke];
    
    if (self.style == XTCustomButtonOverlayStyleInvert) {
        // fill the rounded rectangle area
        [path fill];
    }
    
    CGContextClipToRect(context, boxRect);
    
    // draw icon
    if (self.icon != nil) {
        
        CGSize iconSize = self.icon.size;
        CGRect iconRect = CGRectMake((size.width - iconSize.width) / 2,
                                     (size.height - iconSize.height) / 2,
                                     iconSize.width,
                                     iconSize.height);
        
        if (self.style == XTCustomButtonOverlayStyleNormal) {
            // ref: http://blog.alanyip.me/tint-transparent-images-on-ios/
            CGContextSetBlendMode(context, kCGBlendModeNormal);
            CGContextFillRect(context, iconRect);
            CGContextSetBlendMode(context, kCGBlendModeDestinationIn);
        } else if (self.style == XTCustomButtonOverlayStyleInvert) {
            // this will make the CGContextDrawImage below clear the image area
            CGContextSetBlendMode(context, kCGBlendModeDestinationOut);
        }
        
        CGContextTranslateCTM(context, 0, size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        
        // for some reason, drawInRect does not work here
        CGContextDrawImage(context, iconRect, self.icon.CGImage);
    }
    
    // draw text
    if (_attributedText) {
        
        if (self.style == XTCustomButtonOverlayStyleInvert) {
            // this will make the drawInRect below clear the text area
            CGContextSetBlendMode(context, kCGBlendModeClear);
        }
        [self.attributedText drawInRect:CGRectMake(0.0, (size.height - self.textHeight) / 2, size.width, self.textHeight)];
    }else if (self.text != nil) {
        
        NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        style.lineBreakMode = NSLineBreakByTruncatingTail;
        style.alignment = NSTextAlignmentCenter;
        
        if (self.style == XTCustomButtonOverlayStyleInvert) {
            // this will make the drawInRect below clear the text area
            CGContextSetBlendMode(context, kCGBlendModeClear);
        }
        if (self.style == XTCustomButtonOverlayStyleCustom && self.textColor) {
            [self.text drawInRect:CGRectMake(0.0, (size.height - self.textHeight) / 2, size.width, self.textHeight) withAttributes:@{ NSFontAttributeName:self.font, NSForegroundColorAttributeName:self.textColor, NSParagraphStyleAttributeName:style }];
        }else{
            [self.text drawInRect:CGRectMake(0.0, (size.height - self.textHeight) / 2, size.width, self.textHeight) withAttributes:@{ NSFontAttributeName:self.font, NSForegroundColorAttributeName:self.tintColor, NSParagraphStyleAttributeName:style }];
        }
    }
}

#pragma mark - Override Getters

- (UIFont *)font {
    return _font;
}

- (UIColor *)tintColor {
    return _tintColor;
}

- (NSAttributedString *)attributedText{
    return _attributedText;
}

#pragma mark - Override Setters

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    [self setNeedsDisplay];
}

- (void)setRoundingCorners:(UIRectCorner)roundingCorners {
    _roundingCorners = roundingCorners;
    [self setNeedsDisplay];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    [self setNeedsDisplay];
}

- (void)setIcon:(UIImage *)icon {
    _icon = icon;
    _text = nil;
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text {
    _icon = nil;
    _text = [text copy];
    [self _updateTextHeight];
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font {
    _font = font;
    [self _updateTextHeight];
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText{
    _icon = nil;
    _attributedText = attributedText;
    [self _updateTextHeight];
    [self setNeedsDisplay];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    NSLog(@"XTCustomButtonOverlay: backgroundColor is deprecated and has no effect. Use tintColor instead.");
    [super setBackgroundColor:backgroundColor];
}

- (void)setTintColor:(UIColor *)tintColor {
    _tintColor = tintColor;
    [self setNeedsDisplay];
}

- (void)updateTintColor:(UIColor *)tintColor text:(NSString *)text{
    _icon = nil;
    _text = [text copy];
    _tintColor = tintColor;
    [self _updateTextHeight];
    [self setNeedsDisplay];
}

- (void)setHideRightBorder:(BOOL)hideRightBorder {
    _hideRightBorder = hideRightBorder;
    [self setNeedsDisplay];
}

#pragma mark - Private Methods

- (void)_updateTextHeight {
    if (_attributedText) {
        CGRect bounds = [_attributedText boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        self.textHeight = bounds.size.height;
    }else{
        CGRect bounds = [self.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:self.font } context:nil];
        self.textHeight = bounds.size.height;
    }
}

@end
