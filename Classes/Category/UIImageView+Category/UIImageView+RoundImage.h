//
//  UIImageView+RoundImage.h
//  MyMVVMFramework
//
//  Created by 张发政 on 2017/6/26.
//  Copyright © 2017年 zhangfazheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+RoundImage.h"

@interface UIImageView (RoundImage)
- (void)setImageWithCornerRadius:(CGFloat)radius
                           imageURL:(NSURL *)imageURL
                        placeholder:(NSString *)placeholder
                               size:(CGSize)size;

- (void)setImageWithCornerRadius:(CGFloat)radius
                           imageURL:(NSURL *)imageURL
                        placeholder:(NSString *)placeholder
                        contentMode:(UIViewContentMode)contentMode
                               size:(CGSize)size;

- (void)setImageWithHTRadius:(ImageRadius)radius
                       imageURL:(NSURL *)imageURL
                    placeholder:(NSString *)placeholder
                    contentMode:(UIViewContentMode)contentMode
                           size:(CGSize)size;

- (void)setImageWithHTRadius:(ImageRadius)radius
                       imageURL:(NSURL *)imageURL
                    placeholder:(NSString *)placeholder
                    borderColor:(UIColor *)borderColor
                    borderWidth:(CGFloat)borderWidth
                backgroundColor:(UIColor *)backgroundColor
                    contentMode:(UIViewContentMode)contentMode
                           size:(CGSize)size;


/**
 合并多张图片

 @param radius 合成图片圆角半径
 @param imagesURLStrArray 合成图片的url（字符串）数组
 @param placeholder 占位图
 @param borderColor 边框颜色
 @param borderWidth 边框宽度
 @param backgroundColor 背景颜色
 @param contentBackgroundColor 内容背景颜色
 @param contentMode 拉伸
 @param size 合成图片大小
 */
-(void)setImagesWithRadius:(ImageRadius)radius
           imagesURLStrArray:(NSArray<NSString *> *)imagesURLStrArray
                 placeholder:(NSString *)placeholder
                 borderColor:(UIColor *)borderColor
                 borderWidth:(CGFloat)borderWidth
             backgroundColor:(UIColor *)backgroundColor
      contentBackgroundColor:(UIColor *)contentBackgroundColor
                 contentMode:(UIViewContentMode)contentMode
                        size:(CGSize)size;

@end
