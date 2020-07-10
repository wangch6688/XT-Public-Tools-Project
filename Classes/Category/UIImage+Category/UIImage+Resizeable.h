//
//  UIImage+Resizeable.h
//  MyMVVMFramework
//
//  Created by 张发政 on 2017/8/23.
//  Copyright © 2017年 zhangfazheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Resizeable)
//图片拉伸保护
/**
 *  通过传入一个要拉伸不变形的图片名称返回一张经过处理的图片
 */
+ (instancetype)resizableImageWithName:(NSString *)imageName;
@end
