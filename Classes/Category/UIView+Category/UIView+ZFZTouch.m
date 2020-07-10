//
//  UIView+ZFZTouch.m
//  MyMVVMFramework
//
//  Created by 张发政 on 2017/9/7.
//  Copyright © 2017年 zhangfazheng. All rights reserved.
//

#import "UIView+ZFZTouch.h"
#import <objc/runtime.h>

@implementation UIView (ZFZTouch)
static const char * ZFZ_UN_TOUCH_KEY = "ZFZ_UN_TOUCH";
static const char * ZFZ_UN_TOUCH_RECT_KEY = "ZFZ_UN_TOUCH_RECT";

+ (void)load {
    method_exchangeImplementations(class_getInstanceMethod([UIView class], @selector(pointInside:withEvent:)), class_getInstanceMethod([UIView class], @selector(ZFZ_pointInside:withEvent:)));
}

- (void)setUnTouch:(BOOL)unTouch {
    objc_setAssociatedObject(self, ZFZ_UN_TOUCH_KEY, [NSNumber numberWithInt:unTouch], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)unTouch {
    return objc_getAssociatedObject(self, ZFZ_UN_TOUCH_KEY) ? [objc_getAssociatedObject(self, ZFZ_UN_TOUCH_KEY) boolValue] : NO;
}

- (void)setUnTouchRect:(CGRect)unTouchRect {
    objc_setAssociatedObject(self, ZFZ_UN_TOUCH_RECT_KEY, [NSValue valueWithCGRect:unTouchRect], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGRect)unTouchRect {
    return objc_getAssociatedObject(self, ZFZ_UN_TOUCH_RECT_KEY) ? [objc_getAssociatedObject(self, ZFZ_UN_TOUCH_RECT_KEY) CGRectValue] : CGRectZero;
}

- (BOOL)ZFZ_pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.unTouch) return NO;
    if (self.unTouchRect.origin.x == 0 && self.unTouchRect.origin.y == 0 && self.unTouchRect.size.width == 0 && self.unTouchRect.size.height == 0) {
        return [self ZFZ_pointInside:point withEvent:event];
    } else {
        if (CGRectContainsPoint(self.unTouchRect, point)) return NO;
        else return [self ZFZ_pointInside:point withEvent:event];
    }
}

@end
