//
//  UIImage+CIQRCodeImage.h
//  MixMining
//
//  Created by 张发政 on 2018/4/27.
//  Copyright © 2018年 北京芯智引擎科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CIQRCodeImage)

/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 *
 *  @return 生成的高清的UIImage
 */
+ (UIImage *)creatNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size;

/**
 *  根据给定的字符串生成指定大小的二维码图片
 *
 *  @param str   给定的字符串
 *  @param size  图片宽度
 *
 *  @return 生成的高清的UIImage
 */
+ (UIImage *)creatCIQRCodeImageWithString:(NSString *)str withSize:(CGFloat)size;


/**
 生成二维码(中间有小图片)
 QRStering：字符串
 centerImage：二维码中间的image对象
 */
+ (UIImage *)createImgQRCodeWithString:(NSString *)QRString centerImage:(UIImage *)centerImage;

/**
 生成二维码(中间有小图片)
 QRStering：所需字符串
 centerImage：二维码中间的image对象
 */
+ (UIImage *)createImgQRCodeWithString:(NSString *)QRString centerImage:(UIImage *)centerImage withSize:(CGFloat)size;


@end
