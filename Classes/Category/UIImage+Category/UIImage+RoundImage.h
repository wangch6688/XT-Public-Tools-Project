//
//  UIImage+RoundImage.h
//  MyMVVMFramework
//
//  Created by 张发政 on 2017/6/26.
//  Copyright © 2017年 zhangfazheng. All rights reserved.
//

#import <UIKit/UIKit.h>

struct ImageRadius {
    CGFloat topLeftRadius;
    CGFloat topRightRadius;
    CGFloat bottomLeftRadius;
    CGFloat bottomRightRadius;
};
typedef struct ImageRadius ImageRadius;

static inline ImageRadius RadiusMake(CGFloat topLeftRadius, CGFloat topRightRadius, CGFloat bottomLeftRadius, CGFloat bottomRightRadius) {
    ImageRadius radius;
    radius.topLeftRadius = topLeftRadius;
    radius.topRightRadius = topRightRadius;
    radius.bottomLeftRadius = bottomLeftRadius;
    radius.bottomRightRadius = bottomRightRadius;
    return radius;
}

static inline NSString * NSStringFromRadius(ImageRadius radius) {
    return [NSString stringWithFormat:@"{%.2f, %.2f, %.2f, %.2f}", radius.topLeftRadius, radius.topRightRadius, radius.bottomLeftRadius, radius.bottomRightRadius];
}


@interface UIImage (RoundImage)
- (UIImage *)setRadius:(CGFloat)radius
                     size:(CGSize)size;

- (UIImage *)setRadius:(CGFloat)radius
                     size:(CGSize)size
              contentMode:(UIViewContentMode)contentMode;

+ (UIImage *)setRadius:(CGFloat)radius
                     size:(CGSize)size
              borderColor:(UIColor *)borderColor
              borderWidth:(CGFloat)borderWidth
          backgroundColor:(UIColor *)backgroundColor;

+ (UIImage *)setRadius:(ImageRadius)radius
                      image:(UIImage *)image
                       size:(CGSize)size
                borderColor:(UIColor *)borderColor
                borderWidth:(CGFloat)borderWidth
            backgroundColor:(UIColor *)backgroundColor
            withContentMode:(UIViewContentMode)contentMode;
@end
