//
//  UIImage+Compress.h
//  OperationEquipment
//
//  Created by 张发政 on 2017/4/25.
//  Copyright © 2017年 cyberplus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Compress)
+ (UIImage *)imageWithColor:(UIColor *)color ;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

- (UIImage *)compressWithWidth:(CGFloat)width;

- (void)compressToDataLength:(NSInteger)length withBlock :(void (^)(NSData *))block;

- (void)tryCompressToDataLength:(NSInteger)length withBlock:(void (^)(NSData *))block ;

- (void)fastCompressToDataLength:(NSInteger)length withBlock:(void (^)(NSData *))block ;


@end
