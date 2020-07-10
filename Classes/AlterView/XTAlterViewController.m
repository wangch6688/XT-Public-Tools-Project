//
//  XTAlterViewController.m
//  Sitech
//
//  Created by 张宇 on 2018/4/16.
//  Copyright © 2018年 sitechTeam. All rights reserved.
//

#import "XTAlterViewController.h"
#import "XTUtilsMacros.h"
#import "XTFontAndColorMacros.h"

@interface XTAlterViewController ()
@property (nonatomic, strong) UIView * alertview;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIView * mainView;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * messageLabel;
@property (nonatomic, strong) UILabel * promptMessageLabel;//提示文字
@property (nonatomic, strong) UIImageView * topImageView;
@property (nonatomic, strong) UITextField * inputTextField;
@end

#define XTAlterViewWidth  kRealValue(300)
#define XTAlterViewtopMargin  kRealValue(21)
#define XTAlterViewButtonHeight  kRealValue(50)

@implementation XTAlterViewController

/**
 *  默认按钮两个按钮 -> title  message  cancel   confirm
 */
- (id)initWithTitle:(NSString *)title withMessage:(NSString *)message withCancelBtn:(NSString *)cancelStr confirmBtn:(NSString *)confirmStr {
    self = [super init];
    if (self) {
        self.alertType = XTAlertViewCommonType;
        self.showStyle = XTAlertViewShowCustomStyle;
        _title = title;
        _message = message;
        self.paramters = @{
                         @"buttonTitle1" : cancelStr,
                         @"buttonTitle2" : confirmStr};
        [self createAlterView];
        
    }
    return self;
}

#pragma mark - 两个按钮
- (instancetype)initWithStyle:(XTAlertViewShowStyle)style title:(NSString *)title withMessage:(NSString *)message withCancelBtn:(NSString *)cancelStr confirmBtn:(NSString *)confirmStr {
    return [self initWithStyle:style buttonType:XTAlertViewCommonType customView:nil title:title withMessage:message withCancelBtn:cancelStr confirmBtn:confirmStr];
}

#pragma mark - 一个按钮
- (instancetype)initWithStyle:(XTAlertViewShowStyle)style title:(NSString *)title withMessage:(NSString *)message confirmBtn:(NSString *)confirmStr {
    return [self initWithStyle:style buttonType:XTAlertViewDefaultType customView:nil title:title withMessage:message withCancelBtn:nil confirmBtn:confirmStr];
}

- (instancetype)initWithStyle:(XTAlertViewShowStyle)style buttonType:(XTAlertViewType)buttonType customView:(UIView *)customView title:(NSString *)title withMessage:(NSString *)message withCancelBtn:(NSString *)cancelStr confirmBtn:(NSString *)confirmStr{
    if (self = [super init]) {
        self.alertType = buttonType;
        self.showStyle = style;
        _customView = customView;
        _title = title;
        _message = message;
        if (buttonType == XTAlertViewDefaultType) {
            self.paramters = @{
            @"buttonTitle1" : confirmStr,
            };
        }else{
            self.paramters = @{
            @"buttonTitle1" : cancelStr,
            @"buttonTitle2" : confirmStr};
        }
        
        
        [self createAlterView];
    }
    return self;
}


/**
 *  默认一个按钮-> title  message  cancel   confirm
 */
- (id)initWithTitle:(NSString *)title withMessage:(NSString *)message withKnowButton:(NSString *)knowStr {
    self = [super init];
    if (self) {
        self.showStyle = XTAlertViewShowCustomStyle;
        self.alertType = XTAlertViewDefaultType;
        _title = title;
        _message = message;
        self.paramters = @{
                                @"buttonTitle1" : knowStr,
                                @"buttonTitle2" : @""};
        [self createAlterView];
        
    }
    return self;
}


/**
 *  头部是图片 -> 图片  message  cancel   confirm
 */
- (id)initWithMessge:(NSString *)message withCancelBtn:(NSString *)cancelStr confirmBtn:(NSString *)confirmStr {
    self = [super init];
    if (self) {
        self.alertType = XTAlertViewCommonType;
        //_customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"alert_warning"]];
        self.showStyle = XTAlertViewShowCustomStyle;
        _message = message;
        self.paramters = @{
                                @"buttonTitle1" : cancelStr,
                                @"buttonTitle2" : confirmStr};
        [self createAlterView];
    }
    return self;
}

- (id)initWithParamters:(NSDictionary *)params withAlertType:(XTAlertViewType)type withIsShowTopImage:(BOOL)isShowImg {
    self = [super init];
    if (self) {
        if (isShowImg) {
            self.showStyle = XTAlertViewShowCustomStyle;
             //_customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"alert_warning"]];
        }
        self.alertType = type;
        self.paramters = params;
        [self createAlterView];
        
    }
    return self;
}

- (void)createAlterView {
    self.mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    self.mainView.backgroundColor = [UIColor blackColor];
    self.mainView.alpha = 0.5;
    [self addSubview:self.mainView];
    self.alertview = [[UIView alloc]init];
    self.alertview.layer.cornerRadius = kRealValue(12);
    self.alertview.clipsToBounds = YES;
    self.alertview.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.alertview];
    
    //根据type判断当前alert类型
    float alertViewHeight = XTAlterViewtopMargin;
    float messageHeight = 0.01;
    if (self.message.length > 0) {
        messageHeight = [self heightForString:self.message font:Font_Medium_Text andWidth:kRealValue(220)];
    }
    
    switch (self.showStyle) {
        case XTAlertViewShowEditStyle:{
            if (_title) {
                self.titleLabel.textAlignment = NSTextAlignmentLeft;
                self.titleLabel.frame = CGRectMake(kMediumMargin, alertViewHeight,XTAlterViewWidth - kRealValue(50), kRealValue(21));
                [self.alertview addSubview:self.titleLabel];
                alertViewHeight += _titleLabel.frame.size.height;
            }
            
            self.inputTextField.frame = CGRectMake(kMediumMargin, alertViewHeight + kMediumMargin, XTAlterViewWidth - kMediumMargin*2, kRealValue(40));
            [self.alertview addSubview:self.inputTextField];
            
            alertViewHeight += _inputTextField.frame.size.height + kMediumMargin;
            
            if (_message) {
                self.promptMessageLabel.frame = CGRectMake(kMediumMargin, alertViewHeight + kMediumMargin,self.promptMessageLabel.frame.size.width, self.promptMessageLabel.frame.size.height);
                [self.alertview addSubview:self.promptMessageLabel];
                alertViewHeight += (self.promptMessageLabel.frame.size.height + kMediumMargin);
            }
            
            
            break;
        }case XTAlertViewShowCustomStyle:{
            if (_customView) {
                _customView.frame = CGRectMake((XTAlterViewWidth - _customView.frame.size.width)/2, XTAlterViewtopMargin, _customView.frame.size.width, _customView.frame.size.height);
                [self.alertview addSubview:_customView];
                alertViewHeight += _customView.frame.size.height;
            }
            
            if (_title) {
                self.titleLabel.frame = CGRectMake(0, alertViewHeight,XTAlterViewWidth, kRealValue(21));
                [self.alertview addSubview:self.titleLabel];
                alertViewHeight += _titleLabel.frame.size.height;
            }
            self.messageLabel.frame = CGRectMake(kRealValue(40), alertViewHeight + kSmallMargin,kRealValue(220), messageHeight);
            [self.alertview addSubview:self.messageLabel];
            alertViewHeight += messageHeight;
            break;
        }
            
        default:
            break;
    }
    
    //根据情况计算线的顶部
    CGFloat lineTopMargin = kRealValue(26);
    if (_customView || _title || _inputTextField) {
        lineTopMargin = kRealValue(16);
    }
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, alertViewHeight + lineTopMargin, XTAlterViewWidth, 1)];
    lineView.backgroundColor = kLineViewColor;
    [self.alertview addSubview:lineView];
    alertViewHeight += lineTopMargin +1;
    
    if (self.alertType == XTAlertViewDefaultType) { //一个按钮
        UIButton *knowBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, lineView.frame.origin.y + 1, XTAlterViewWidth, XTAlterViewButtonHeight)];
        [knowBtn setTitle:[self.paramters valueForKey:@"buttonTitle1"] forState:UIControlStateNormal];
        knowBtn.titleLabel.font = Font_Large_Title;
        [knowBtn setTitleColor:kSystemColor(1) forState:UIControlStateNormal];
        [knowBtn addTarget:self action:@selector(knowBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.alertview addSubview:knowBtn];
    } else {
        UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, lineView.frame.origin.y + 1, (XTAlterViewWidth - 1) / 2, XTAlterViewButtonHeight)];
        [cancelBtn setTitle:[self.paramters valueForKey:@"buttonTitle1"] forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = Font_Large_Text;
        [cancelBtn setTitleColor:kSystemSubitleTextColor forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.alertview addSubview:cancelBtn];
        
        UIView *middleLineView = [[UIView alloc]initWithFrame:CGRectMake(cancelBtn.frame.size.width, lineView.frame.origin.y + 1, 1, XTAlterViewButtonHeight)];
        middleLineView.backgroundColor = kLineViewColor;
        [self.alertview addSubview:middleLineView];
        
        UIButton *confirmlBtn = [[UIButton alloc]initWithFrame:CGRectMake(middleLineView.frame.origin.x + 1, lineView.frame.origin.y + 1, (XTAlterViewWidth - 1) / 2, XTAlterViewButtonHeight)];
        [confirmlBtn setTitle:[self.paramters valueForKey:@"buttonTitle2"] forState:UIControlStateNormal];
        confirmlBtn.titleLabel.font = Font_Large_Title;
        [confirmlBtn setTitleColor:kSystemColor(1) forState:UIControlStateNormal];
        [confirmlBtn addTarget:self action:@selector(confirmlBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.alertview addSubview:confirmlBtn];
    }
    
    self.alertview.frame = CGRectMake(0, 0, XTAlterViewWidth, alertViewHeight + 1+XTAlterViewButtonHeight);
    
//    [self exChangeOut:self.alertview dur:0.6];
}

//显示提示框
- (void)showAlter {
    self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    self.alertview.center = self.center;
    UIView * keywindow = [[UIApplication sharedApplication] keyWindow];
    [keywindow addSubview: self];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
    }];
}

//我知道了按钮
- (void)knowBtnAction:(UIButton *)btn{
    [self cancleView];
    if (self.confirmBlock) {
        self.confirmBlock(0);
    }
}

//确认按钮
- (void)confirmlBtnAction:(UIButton *)btn {
    [self cancleView];
    if (self.confirmBlock) {
        self.confirmBlock(1);
    }
}

//取消按钮
- (void)cancelBtnAction:(UIButton *)btn {
    [self cancleView];
    if (self.confirmBlock) {
        self.confirmBlock(0);
    }
}
- (void)cancleView {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.alertview = nil;
    }];
}

//弹出动画
- (void)exChangeOut:(UIView *)changeOutView dur:(CFTimeInterval)dur {
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = dur;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    [changeOutView.layer addAnimation:animation forKey:nil];
}

//获得字符串的高度
- (float) heightForString:(NSString *)value font:(UIFont *)font andWidth:(float)width {
    CGRect sizeToFit = [value boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil];
    return sizeToFit.size.height;
}

- (void)dealloc {
    DLog(@"------------ttttt-------");
}

- (UILabel *)titleLabel{
    if(!_titleLabel){
        UILabel * titleLabel = [[UILabel alloc]init];
        titleLabel.frame = CGRectMake(0, kRealValue(22),kRealValue(300), kRealValue(21));
        titleLabel.text = _title;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = Font_Large_Title;
        titleLabel.textColor = kSystemTextColor(1);
        
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

- (UILabel *)messageLabel{
    if (!_messageLabel) {
        UILabel *messageLabel = [[UILabel alloc]init];
        messageLabel.text = _message;
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = Font_Medium_Text;
        messageLabel.textColor = kSystemTextColor(1);
        
        _messageLabel = messageLabel;
    }
    return _messageLabel;
}

- (UITextField *)inputTextField{
    if (!_inputTextField) {
        UITextField *textField = [UITextField new];
        textField.textColor = kSystemTextColor(1);
        textField.font = Font_Medium_Text;
        textField.backgroundColor = KUIColorHexValue(0xF5F6F7, 1);
        textField.layer.borderColor = kBorderColor.CGColor;
        textField.layer.borderWidth = 1;
        textField.layer.cornerRadius = kViewCornerRadius;
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kLargeMargin, 1)];
        textField.placeholder = @"请输入";
        
        _inputTextField = textField;
    }
    return _inputTextField;
}


- (UILabel *)promptMessageLabel{
    if (!_promptMessageLabel) {
        UILabel *messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, XTAlterViewWidth- 2*kMediumMargin, kRealValue(22.5))];
        messageLabel.text = _message;
        messageLabel.font = Font_Medium_Text;
        messageLabel.textColor = KUIColorHexValue(0xFF000B, 1);
        messageLabel.backgroundColor = KUIColorHexValue(0xFFEEF0, 1);
        messageLabel.layer.cornerRadius = 2;
        
        _promptMessageLabel = messageLabel;
    }
    return _promptMessageLabel;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
}

- (void)setMessage:(NSString *)message{
    _message = message;
    if(self.showStyle == XTAlertViewShowEditStyle){
        self.promptMessageLabel.text = message;
    }
}

- (void)setPlaceholderText:(NSString *)placeholderText{
    _placeholderText = placeholderText;
    self.inputTextField.placeholder = placeholderText;
}

@end
