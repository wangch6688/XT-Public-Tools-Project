//
//  XTLoadingView.m
//  Sitech
//
//  Created by wangchuang on 2018/7/18.
//  Copyright © 2018年 sitechTeam. All rights reserved.
//

#import "XTLoadingView.h"

@interface XTLoadingView()

@property (assign, nonatomic) CGFloat lineWidth;
@property (strong, nonatomic) NSArray * colors;
@property (strong, nonatomic) CAShapeLayer * progressLayer;
@property (strong, nonatomic) CAAnimationGroup * animationGroup;
@property (strong, nonatomic) CABasicAnimation * rotateAnomation;

@end

@implementation XTLoadingView

- (id)initWithFrame:(CGRect)frame withWidth:(CGFloat)width withColors:(NSArray *)colors {
    self = [super initWithFrame:frame];
    if (self) {
        self.lineWidth = 2.0;
        self.lineWidth = width;
        self.colors = colors;
        
        [self defaultSetting];
    }
    return self;
}

- (void)defaultSetting {
    self.rotateAnomation.fromValue = [NSNumber numberWithDouble:0.0];
    self.rotateAnomation.toValue = [NSNumber numberWithDouble:M_PI * 2.0];
    self.rotateAnomation.repeatCount = HUGE;
    self.rotateAnomation.duration = 3.0;
    self.rotateAnomation.beginTime = 0.0;
    //rotateAnimation.fillMode = kCAFillModeForwards
    [self.rotateAnomation setRemovedOnCompletion:NO];
    
    CABasicAnimation * strokeEndAnimation = [[CABasicAnimation alloc]init];
    strokeEndAnimation.keyPath = @"strokeEnd";
    strokeEndAnimation.fromValue = [NSNumber numberWithDouble: 0.0];
    strokeEndAnimation.toValue = [NSNumber numberWithDouble: 1.0];
    strokeEndAnimation.duration = 1.0;
    strokeEndAnimation.beginTime = 0.0;
    strokeEndAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation * strokeStartAnimation = [[CABasicAnimation alloc]init];
    strokeStartAnimation.keyPath = @"strokeStart";
    strokeStartAnimation.fromValue = [NSNumber numberWithDouble: 0.0];
    strokeStartAnimation.toValue = [NSNumber numberWithDouble: 1.0];
    strokeStartAnimation.duration = 1.0;
    strokeStartAnimation.beginTime = 1.0;
    strokeStartAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    self.animationGroup.duration = 2.0;
    self.animationGroup.repeatCount = HUGE;
    //animationGroup.fillMode = kCAFillModeForwards
    [self.animationGroup setRemovedOnCompletion:NO];
    self.animationGroup.animations =@[strokeEndAnimation, strokeStartAnimation];
    
    CGRect rect = CGRectMake(self.lineWidth, self.lineWidth, self.frame.size.width - 2 * self.lineWidth, self.frame.size.width - 2 * self.lineWidth);
    UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:rect];
    self.progressLayer.lineWidth = self.lineWidth;
    self.progressLayer.lineCap = kCALineCapRound;
    self.progressLayer.strokeColor = [self.colors.firstObject CGColor];
    self.progressLayer.fillColor = [[UIColor clearColor] CGColor];
    self.progressLayer.strokeStart = 0.0;
    self.progressLayer.strokeEnd = 1.0;
    self.progressLayer.path = path.CGPath;
}

- (void)startAnimation {
    [self.progressLayer addAnimation:self.animationGroup forKey:@"strokeAnim"];
    [self.layer addSublayer:self.progressLayer];
    [self.layer addAnimation:self.rotateAnomation forKey:@"rotateAnimation"];
    [self.progressLayer setHidden:NO];
}

- (void)endAniamtion {
    [self.progressLayer setHidden:YES];
    [self.progressLayer removeAnimationForKey:@"strokeAnim"];
    [self.progressLayer removeFromSuperlayer];
    [self.layer removeAnimationForKey:@"rotateAnimation"];
}

#pragma mark -lazy loading
- (NSArray *)colors {
    if (_colors == nil) {
        _colors = [[NSArray alloc]init];
    }
    return _colors;
}

- (CAShapeLayer *)progressLayer {
    if (_progressLayer == nil) {
        _progressLayer = [[CAShapeLayer alloc]init];
    }
    return _progressLayer;
}

- (CAAnimationGroup *)animationGroup {
    if (_animationGroup == nil) {
        _animationGroup = [[CAAnimationGroup alloc]init];
    }
    return _animationGroup;
}

- (CABasicAnimation *)rotateAnomation {
    if (_rotateAnomation == nil) {
        _rotateAnomation = [[CABasicAnimation alloc]init];
        _rotateAnomation.keyPath = @"transform.rotation.z";
    }
    return _rotateAnomation;
}

@end
