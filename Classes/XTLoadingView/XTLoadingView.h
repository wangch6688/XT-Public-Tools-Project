//
//  XTLoadingView.h
//  Sitech
//
//  Created by wangchuang on 2018/7/18.
//  Copyright © 2018年 sitechTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XTLoadingView : UIView

- (id)initWithFrame:(CGRect)frame withWidth:(CGFloat)width withColors:(NSArray *)colors;

- (void)startAnimation;
- (void)endAniamtion;

@end
