//
//  XTCustomLoading.h
//  Sitech
//
//  Created by wangchuang on 2018/7/18.
//  Copyright © 2018年 sitechTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XTCustomLoading : UIView

#pragma mark - default loading
/** 默认loading框 */
+ (void)loading;
+ (void)loading:(NSString *)title;
+ (void)dismiss;

#pragma mark - 纯文本toast提示
/** 纯文本toast提示 */
+ (void)showToastWithMessage:(NSString *)message;
/** 图文toast提示 */
+ (void)showToastWithMessage:(NSString *)message image:(NSString *)imageName;

#pragma mark - 移除所有的loading或者toast
/** 移除所有的loading或者toast提示 */
+ (void)removeAllCustomLoadingView;

@end
