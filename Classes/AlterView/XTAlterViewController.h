//
//  XTAlterViewController.h
//  Sitech
//
//  Created by 张宇 on 2018/4/16.
//  Copyright © 2018年 sitechTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 * AlterView   标题、提示信息
*/
typedef void (^XTAltertConfirmBlock)(NSUInteger buttonIndex);

typedef enum : NSUInteger {
    XTAlertViewDefaultType,//只有一个按钮
    XTAlertViewCommonType//两个按钮
} XTAlertViewType;

typedef enum : NSUInteger {
    XTAlertViewShowCustomStyle,//自定义模式，自定义view,标题，消息，按钮
    XTAlertViewShowEditStyle,//编辑样式，标题，输入框，消息，按钮
} XTAlertViewShowStyle;

@interface XTAlterViewController : UIView
@property (nonatomic,copy)XTAltertConfirmBlock confirmBlock;//确认回调
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * subTitle;
@property (nonatomic, copy) NSString * message;//消息文字
@property (nonatomic, copy) NSString * placeholderText;//输入框占位提示文字
@property (nonatomic, strong) UIView * customView;//自定义附加view
@property (nonatomic, assign) NSUInteger number;
@property (nonatomic, strong) UIColor * tintColor;
@property (nonatomic, assign) XTAlertViewType alertType;
@property (nonatomic, assign) XTAlertViewShowStyle showStyle;//显示样式
@property (nonatomic, strong) NSDictionary * paramters;

/**
 *  默认按钮两个按钮 -> title  message  cancel   confirm
 */
- (id)initWithTitle:(NSString *)title withMessage:(NSString *)message withCancelBtn:(NSString *)cancelStr confirmBtn:(NSString *)confirmStr;


/**
 *  默认一个按钮-> title  message  cancel   confirm
 */
- (id)initWithTitle:(NSString *)title withMessage:(NSString *)message withKnowButton:(NSString *)knowStr;


/**
 *  头部是图片 -> 图片  message  cancel   confirm
 */
- (id)initWithMessge:(NSString *)message withCancelBtn:(NSString *)cancelStr confirmBtn:(NSString *)confirmStr;


/// 创建只有一个按钮的提示框
/// @param style 样式
/// @param title 标题
/// @param message 消息
/// @param confirmStr 确认按钮文字
- (instancetype)initWithStyle:(XTAlertViewShowStyle)style title:(NSString *)title withMessage:(NSString *)message confirmBtn:(NSString *)confirmStr;

/// 创建有两个按钮的提示框
/// @param style 样式
/// @param title 标题
/// @param message 消息
/// @param cancelStr 取消按钮文字
/// @param confirmStr 确认按钮文字
- (instancetype)initWithStyle:(XTAlertViewShowStyle)style title:(NSString *)title withMessage:(NSString *)message withCancelBtn:(NSString *)cancelStr confirmBtn:(NSString *)confirmStr ;

/**
 *  显示当前alert
 */
- (void)showAlter;

@end
