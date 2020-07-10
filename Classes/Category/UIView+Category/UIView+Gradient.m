//
//  UIView+Gradient.m
//  TokenViewWallet
//
//  Created by 张发政 on 2018/10/12.
//  Copyright © 2018年 北京芯智引擎科技有限公司. All rights reserved.
//

#import "UIView+Gradient.h"

@implementation UIView (Gradient)

- (void)gradientLayerWithColors:(NSArray *)colors{
    CAShapeLayer *gradientMask = [CAShapeLayer layer];
    CGRect gradientFrame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    gradientMask.frame = gradientFrame;
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:gradientFrame];
    [path fill];
    gradientMask.path = path.CGPath;
    
    
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.startPoint = CGPointMake(0.5,0.0);
    gradientLayer.endPoint = CGPointMake(0.5,1.0);
    //    gradientLayer.startPoint = CGPointMake(0.5,1.0);
    //    gradientLayer.endPoint = CGPointMake(0.5,0.0);
    gradientLayer.frame = gradientFrame;
    
//    if ([self.coinWallet.coinType isEqualToString:@"BTC"]) {
//        colors = @[
//                   (id)RGB(234, 131, 57).CGColor,
//                   (id)RGB(241, 141, 68).CGColor,
//                   (id)RGB(240, 160, 79).CGColor,
//                   (id)RGB(247, 159, 121).CGColor
//                   ];
//    }else if([self.coinWallet.coinType isEqualToString:@"ETH"]){
//        colors = @[
//                   (id)RGB(91, 92, 93).CGColor,
//                   (id)RGB(110, 110, 110).CGColor,
//                   (id)RGB(135, 135, 135).CGColor,
//                   (id)RGB(178, 178, 178).CGColor
//                   ];
//    }
    gradientLayer.colors = colors;
    
    
    [gradientLayer setMask:gradientMask];
    
    [self.layer addSublayer:gradientLayer];
}

@end
