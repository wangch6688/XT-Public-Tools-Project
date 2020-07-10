//
//  XTCustomLoading.m
//  Sitech
//
//  Created by wangchuang on 2018/7/18.
//  Copyright © 2018年 sitechTeam. All rights reserved.
//

#import "XTCustomLoading.h"
#import "XTLoadingView.h"
#import <Masonry.h>
#import "XTFontAndColorMacros.h"
#import "XTUtilsMacros.h"

@interface XTCustomLoading()

@property (strong, nonatomic) UILabel * loadingTextLabel;
@property (strong, nonatomic) UIView * cicleView;
@property (strong, nonatomic) XTLoadingView * loadingView;
@property (assign, nonatomic) CGFloat cicleViewWidth;
@property (assign, nonatomic) NSTimeInterval duration;

@end

@implementation XTCustomLoading

+ (XTCustomLoading *)sharedView {
    static dispatch_once_t once;
    static XTCustomLoading *sharedView;
    dispatch_once(&once, ^ {
        sharedView = [[XTCustomLoading alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    });
    return sharedView;
}

- (void)layoutSetting {
    self.cicleViewWidth = KScreenWidth;
    self.duration = 2.0;
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6];
    [self.cicleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.height.mas_equalTo(self.cicleViewWidth);
        make.width.mas_equalTo(self.cicleViewWidth);
    }];
    
    [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.center.equalTo(self.cicleView);
    }];
    
    [self.loadingTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cicleView);
        make.right.equalTo(self.cicleView);
        make.top.equalTo(self.loadingView.mas_bottom).offset(5);
//        make.height.equalTo(@20);
    }];
    
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    if (deviceOrientation == UIDeviceOrientationLandscapeRight) {
        self.frame = CGRectMake(0, 0, KScreenHeight, KScreenWidth);
    } else {
        self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    }
}

+ (void)loading {
    XTCustomLoading * loading = [XTCustomLoading sharedView];
    [loading layoutSetting];
    loading.loadingTextLabel.text = @"";
    [kAppWindow addSubview:loading];
    [loading.loadingView startAnimation];
}

+ (void)loading:(NSString *)title {
    XTCustomLoading * loading = [XTCustomLoading sharedView];
    [loading layoutSetting];
    loading.loadingTextLabel.text = title;
    [kAppWindow addSubview:loading];
    [loading.loadingView startAnimation];
}

+ (void)dismiss {
    [[XTCustomLoading sharedView].loadingView endAniamtion];
    [[XTCustomLoading sharedView] removeFromSuperview];
}

#pragma mark - 纯文本toast提示
/** 纯文本toast提示 */
+ (void)showToastWithMessage:(NSString *)message {
    [XTCustomLoading dismiss];
    // 背景view
    UIView *bgView = [[UIView alloc] init];
    bgView.tag = 1000;
    bgView.layer.cornerRadius = kRealValue(12);
    bgView.backgroundColor = KUIColorHexValue(0x676d77, 0.9);
    [[[[UIApplication sharedApplication] delegate] window] addSubview:bgView];
    [[[[UIApplication sharedApplication] delegate] window] bringSubviewToFront:bgView];
    // label
    UILabel *label = [[UILabel alloc] init];
    label.text = message;
    label.textColor = KUIColorHexValue(0xffffff, 1);
    label.numberOfLines = 0;
    [bgView addSubview:label];
    
    if (message.length <= 10) {
        label.font = FONT(@"PingFangSC-Regular", kRealValue(17));
        label.textAlignment = NSTextAlignmentCenter;

        // 设置背景view的约束
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(bgView.superview);
            make.size.mas_equalTo(CGSizeMake(kRealValue(200), kRealValue(60)));
        }];
        // 设置label的约束
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(label.superview);
        }];
        
    }else{
        label.font = FONT(@"PingFangSC-Regular", kRealValue(13));
        label.textAlignment = NSTextAlignmentLeft;
        
        // 设置背景view的约束
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(bgView.superview);
            make.top.mas_equalTo(label).mas_offset(-kRealValue(20));
            make.left.mas_equalTo(label).mas_equalTo(-kRealValue(20));
            make.bottom.mas_equalTo(label).mas_offset(kRealValue(20));
            make.right.mas_equalTo(label).mas_equalTo(kRealValue(20));
        }];
        // 设置label的约束
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_lessThanOrEqualTo(kRealValue(200));
            make.center.mas_equalTo(label.superview);
        }];
    }
    

    // 2秒后移除toast
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5 animations:^{
            bgView.alpha = 0;
        } completion:^(BOOL finished) {
            [bgView removeFromSuperview];
        }];
    });
}

/** 图文toast提示 */
+ (void)showToastWithMessage:(NSString *)message image:(NSString *)imageName {
    [XTCustomLoading dismiss];
    // 背景view
    UIView *bgView = [[UIView alloc] init];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:bgView];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.9];
    bgView.layer.cornerRadius = 5;
    
    // 图片
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [bgView addSubview:imageView];
    
    // label
    UILabel *label = [[UILabel alloc]init];
    label.text = message;
    [bgView addSubview:label];
    label.textColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:22];
    
    // 设置背景view的约束
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(bgView.superview);
        make.width.mas_equalTo(150);
    }];
    
    // 设置imageView的约束
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView);
        make.top.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(34, 34));
    }];
    
    // 设置label的约束
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_lessThanOrEqualTo(130);
        make.centerX.mas_equalTo(label.superview);
        make.top.mas_equalTo(imageView.mas_bottom).mas_offset(20);
        make.bottom.mas_offset(-18);
    }];
    
    // 2秒后移除toast
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5 animations:^{
            bgView.alpha = 0;
        } completion:^(BOOL finished) {
            [bgView removeFromSuperview];
        }];
    });
}

#pragma mark - 移除所有的loading或者toast
/** 移除所有的loading或者toast提示 */
+ (void)removeAllCustomLoadingView {
    if ([[[[UIApplication sharedApplication] delegate] window] viewWithTag:1000]) {
        UIView * bgView = [[[[UIApplication sharedApplication] delegate] window] viewWithTag:1000];
        [bgView removeFromSuperview];
    }
}

#pragma mark - lazy load
- (UILabel *)loadingTextLabel {
    if (_loadingTextLabel == nil) {
        _loadingTextLabel = [[UILabel alloc]init];
        _loadingTextLabel.font = [UIFont systemFontOfSize:15];
        _loadingTextLabel.textColor = [UIColor whiteColor];
        _loadingTextLabel.textAlignment = NSTextAlignmentCenter;
        [self.cicleView addSubview:_loadingTextLabel];
    }
    return _loadingTextLabel;
}

- (UIView *)cicleView {
    if (_cicleView == nil) {
        _cicleView = [[UIView alloc]init];
        [self addSubview:_cicleView];
    }
    return _cicleView;
}

- (XTLoadingView *)loadingView {
    if (_loadingView == nil) {
        _loadingView = [[XTLoadingView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)
                                                 withWidth:3.0
                                                withColors:@[kSystemColor(1)]];
        [self.cicleView addSubview:_loadingView];
    }
    return _loadingView;
}

@end
