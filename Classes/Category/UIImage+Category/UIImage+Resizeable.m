//
//  UIImage+Resizeable.m
//  MyMVVMFramework
//
//  Created by 张发政 on 2017/8/23.
//  Copyright © 2017年 zhangfazheng. All rights reserved.
//

#import "UIImage+Resizeable.h"

@implementation UIImage (Resizeable)
+ (instancetype)resizableImageWithName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    // 计算图片四周要保护的区域
    CGFloat imageW = image.size.width * 0.5;
    CGFloat imageH = image.size.height * 0.5;
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(imageH, imageW, imageH, imageW) resizingMode:UIImageResizingModeTile];
}
@end
