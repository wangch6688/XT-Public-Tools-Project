//
//  UIImage+SolidColor.h
//  OperationEquipment
//
//  Created by 张发政 on 2017/3/13.
//  Copyright © 2017年 cyberplus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SolidColor)
/**
 *  创建纯色图片.
 *
 *  @param size  The image size.
 *  @param color The image color.
 *
 *  @return Image.
 */
+ (UIImage *)imageWithSize:(CGSize)size color:(UIColor *)color;


/**
 *  重新绘制图片,改变图片颜色
 *
 *  @param color 填充色
 *
 *  @return UIImage
 */
- (UIImage *)imageWithColor:(UIColor *)color;
@end
