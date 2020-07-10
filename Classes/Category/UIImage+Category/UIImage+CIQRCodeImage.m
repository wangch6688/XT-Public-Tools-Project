//
//  UIImage+CIQRCodeImage.m
//  MixMining
//
//  Created by 张发政 on 2018/4/27.
//  Copyright © 2018年 北京芯智引擎科技有限公司. All rights reserved.
//

#import "UIImage+CIQRCodeImage.h"
#import <CoreImage/CoreImage.h>
#import "UIImage+RoundImage.h"

@implementation UIImage (CIQRCodeImage)
/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 *
 *  @return 生成的高清的UIImage
 */
+ (UIImage *)creatNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1. 创建bitmap
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}


+ (UIImage *)creatCIQRCodeImageWithString:(NSString *)str withSize:(CGFloat)size{
    // 1.创建过滤器，这里的@"CIQRCodeGenerator"是固定的
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 2.恢复默认设置
    [filter setDefaults];
    
    // 3. 给过滤器添加数据
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    // 注意，这里的value必须是NSData类型
    [filter setValue:data forKeyPath:@"inputMessage"];
    
    // 4. 生成二维码
    CIImage *outputImage = [filter outputImage];
    
    UIImage *cordImage = [UIImage creatNonInterpolatedUIImageFormCIImage:outputImage withSize:size];
    
    return cordImage;

}


/**
 生成二维码(中间有小图片)
 QRStering：所需字符串
 centerImage：二维码中间的image对象
 */
+ (UIImage *)createImgQRCodeWithString:(NSString *)QRString centerImage:(UIImage *)centerImage withSize:(CGFloat)size{

    UIImage *startImage = [UIImage creatCIQRCodeImageWithString:QRString withSize:size];
    // 开启绘图, 获取图形上下文
    UIGraphicsBeginImageContext(startImage.size);
    // 把二维码图片画上去 (这里是以图形上下文, 左上角为(0,0)点
    [startImage drawInRect:CGRectMake(0, 0, startImage.size.width, startImage.size.height)];
    // 再把小图片画上去
    CGFloat icon_imageW = 44;
    CGFloat icon_imageH = icon_imageW;
    CGFloat icon_imageX = (startImage.size.width - icon_imageW) * 0.5;
    CGFloat icon_imageY = (startImage.size.height - icon_imageH) * 0.5;
    UIImage *reCenterImage = [UIImage setRadius:RadiusMake(3, 3, 3, 3) image:centerImage size:CGSizeMake(icon_imageW, icon_imageW) borderColor:[UIColor whiteColor] borderWidth:1 backgroundColor:[UIColor clearColor] withContentMode:UIViewContentModeScaleToFill];
    
    [reCenterImage drawInRect:CGRectMake(icon_imageX, icon_imageY, icon_imageW, icon_imageH)];
    //画边框
    
    
    // 获取当前画得的这张图片
    UIImage *qrImage = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    //返回二维码图像
    return qrImage;
}

@end
