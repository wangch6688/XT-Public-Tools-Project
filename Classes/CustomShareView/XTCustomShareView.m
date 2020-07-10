//
//  XTCustomShareView.m
//  Sitech
//
//  Created by wangchuang on 2018/11/8.
//  Copyright © 2018 sitechTeam. All rights reserved.
//

#import "XTCustomShareView.h"
#import "XTMyCarCellLabel.h"
#import <UMCommon/UMCommon.h>
#import <UMShare/UMShare.h>
#import "XTCustomLoading.h"
#import <Masonry.h>
//#import "XTBBSSendIntegralAPI.h"
#import "XTUtilsMacros.h"
#import "XTFontAndColorMacros.h"

static NSString * wechatType = @"shareType_wechat";
static NSString * friendType = @"shareType_friend";
static NSString * sinaType = @"shareType_sina";

@interface XTCustomShareView()
@property (nonatomic, strong) UIView * footView;
@property (nonatomic,strong)  UIView *topView;
@property (nonatomic, strong) UIButton * cancelButton;
@property (nonatomic, strong) UIButton * weChatButton;
@property (nonatomic, strong) XTMyCarCellLabel * weChatLabel;
@property (nonatomic, strong) UIButton * friendButton;
@property (nonatomic, strong) XTMyCarCellLabel * friendLabel;
@property (nonatomic, strong) UIButton * sinaButton;
@property (nonatomic, strong) XTMyCarCellLabel * sinaLabel;
@property (nonatomic, strong) UIView * lineView;
@property (nonatomic, strong) UIButton * delButton;
@property (nonatomic, strong) XTMyCarCellLabel * delLabel;
@property (nonatomic, strong) UIButton *reportBtn;
@property (nonatomic, strong) XTMyCarCellLabel * reportLabel;
@property (nonatomic, strong) UIButton * shieldButton;
@property (nonatomic, strong) XTMyCarCellLabel * shieldLabel;

@property (nonatomic, assign) BOOL isDel;
@end

@implementation XTCustomShareView

+ (XTCustomShareView *)sharedView {
    XTCustomShareView *sharedView = [[XTCustomShareView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    sharedView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.5];
    return sharedView;
}

- (void)showShareView:(BOOL)isDel
{
    self.isDel = isDel;
    [self layoutAllViews];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:self];
    
//    if ([[[XTUserManager sharedXTUserManager]getUserInfo].mobile isEqualToString:TestAccount]) {
//        [UIView animateWithDuration:0.35 animations:^{
//            [self.footView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(KScreenHeight - kRealValue(291));
//            }];
//            [self layoutIfNeeded];
//        }];
//    }else{
        if (self.isDel) {
            [UIView animateWithDuration:0.35 animations:^{
                [self.footView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(KScreenHeight - kRealValue(291));
                }];
                [self layoutIfNeeded];
            }];
        }else{
            [UIView animateWithDuration:0.35 animations:^{
                [self.footView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(KScreenHeight - kRealValue(191));
                }];
                [self layoutIfNeeded];
            }];
        }
//    }
}
- (void)wechatButtonAction {
    
    self.shareType = shareType_wechat;
    
    [self cancelView];
    
    [self toShareType:wechatType];
}

- (void)friendButtonAction {
    
    self.shareType = shareType_friend;

    [self cancelView];
    
    [self toShareType:friendType];
}

- (void)sinaButtonAction {
    
    self.shareType = shareType_sina;

    [self cancelView];
    
    [self toShareType:sinaType];
}

- (void)toShareType:(NSString *)type {
    if (self.shareVideoUrl.length > 0) {
        if (self.shareTitle.length == 0 && self.shareDescription.length > 0) {//无title，有文字信息
            self.shareTitle = self.shareDescription;
        } else if (self.shareTitle.length > 0 && self.shareDescription.length == 0) {//有title 无文字
            self.shareDescription = self.shareTitle;
        } else if (self.shareTitle.length == 0 && self.shareDescription.length == 0) { //无文字 无title
            self.shareTitle = @"用户分享视频";
            self.shareDescription = @"来自新特用户的分享";
        }
        
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        UMShareVideoObject *shareObject = [UMShareVideoObject shareObjectWithTitle:self.shareTitle descr:self.shareDescription thumImage:self.shareVideoSmallImageStr];
        shareObject.thumbImage = self.shareImageObject;
        shareObject.videoUrl = self.shareVideoUrl;
        messageObject.shareObject = shareObject;
        UMSocialPlatformType formType = 0;
        if ([type isEqualToString:wechatType]) {
            if([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession]) {
                formType = UMSocialPlatformType_WechatSession;
            } else {
                [XTCustomLoading showToastWithMessage:@"手机未安装微信"];
                return;
            }
        } else if ([type isEqualToString:friendType]) {
            if([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatTimeLine]) {
                formType = UMSocialPlatformType_WechatTimeLine;
            } else {
                [XTCustomLoading showToastWithMessage:@"手机未安装微信"];
                return;
            }
        } else if ([type isEqualToString:sinaType]) {
            if([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_Sina]) {
                formType = UMSocialPlatformType_Sina;
            } else {
                [XTCustomLoading showToastWithMessage:@"手机未安装新浪微博"];
                return;
            }
        }
        
        [[UMSocialManager defaultManager] shareToPlatform:formType messageObject:messageObject currentViewController:nil completion:^(id result, NSError *error) {
            if (error) {
                [XTCustomLoading showToastWithMessage:@"分享失败"];
            } else {
                if (self.shareSucess) {
                    self.shareSucess(self.shareType);
                }
                [XTCustomLoading showToastWithMessage:@"分享成功"];
                [self removeFromSuperview];
                [self shareSuccessAndSendIntegralWithShareType:type];
            }
        }];
    } else {
        if (self.isOnlyImageShare) {
            UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
            UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
            shareObject.thumbImage = self.shareImageObject;
            [shareObject setShareImage:self.shareImageObject];
            messageObject.shareObject = shareObject;
            
            UMSocialPlatformType formType = 0;
            if ([type isEqualToString:wechatType]) {
                if([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession]) {
                    formType = UMSocialPlatformType_WechatSession;
                } else {
                    [XTCustomLoading showToastWithMessage:@"手机未安装微信"];
                    return;
                }
            } else if ([type isEqualToString:friendType]) {
                if([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatTimeLine]) {
                    formType = UMSocialPlatformType_WechatTimeLine;
                } else {
                    [XTCustomLoading showToastWithMessage:@"手机未安装微信"];
                    return;
                }
            } else if ([type isEqualToString:sinaType]) {
                if([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_Sina]) {
                    formType = UMSocialPlatformType_Sina;
                } else {
                    [XTCustomLoading showToastWithMessage:@"手机未安装新浪微博"];
                    return;
                }
            }
            
            [[UMSocialManager defaultManager] shareToPlatform:formType messageObject:messageObject currentViewController:nil completion:^(id result, NSError *error) {
                if (error) {
                    [XTCustomLoading showToastWithMessage:@"分享失败"];
                } else {
                    [XTCustomLoading showToastWithMessage:@"分享成功"];
                    [self removeFromSuperview];
                    [self shareSuccessAndSendIntegralWithShareType:type];
                }
            }];
            
        } else {
            if (self.shareTitle.length == 0 && self.shareDescription.length > 0) {//无title，有文字信息
                self.shareTitle = self.shareDescription;
            } else if (self.shareTitle.length > 0 && self.shareDescription.length == 0) {//有title 无文字
                self.shareDescription = self.shareTitle;
            } else if (self.shareTitle.length == 0 && self.shareDescription.length == 0) { //无文字 无title
                self.shareTitle = @"用户分享图片";
                self.shareDescription = @"来自新特用户的分享";
            }
            
            UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
            if (self.shareImageObject != nil) {
                UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:self.shareTitle descr:self.shareDescription thumImage:self.shareImageObject];
                //        shareObject.webpageUrl = self.shareUrlStr;
                messageObject.shareObject = shareObject;
            } else {
                if (self.shareImage.length > 0) {
                    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:self.shareTitle descr:self.shareDescription thumImage:self.shareImage];
                    shareObject.webpageUrl = self.shareUrlStr;
                    messageObject.shareObject = shareObject;
                } else {
                    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:self.shareTitle descr:self.shareDescription thumImage:[UIImage imageNamed:@"login_faceHeader"]];
                    shareObject.webpageUrl = self.shareUrlStr;
                    messageObject.shareObject = shareObject;
                }
            }
            UMSocialPlatformType formType = 0;
            if ([type isEqualToString:wechatType]) {
                if([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession]) {
                    formType = UMSocialPlatformType_WechatSession;
                } else {
                    [XTCustomLoading showToastWithMessage:@"手机未安装微信"];
                    return;
                }
            } else if ([type isEqualToString:friendType]) {
                if([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatTimeLine]) {
                    formType = UMSocialPlatformType_WechatTimeLine;
                } else {
                    [XTCustomLoading showToastWithMessage:@"手机未安装微信"];
                    return;
                }
            } else if ([type isEqualToString:sinaType]) {
                if([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_Sina]) {
                    formType = UMSocialPlatformType_Sina;
                } else {
                    [XTCustomLoading showToastWithMessage:@"手机未安装新浪微博"];
                    return;
                }
            }
            [[UMSocialManager defaultManager] shareToPlatform:formType messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
                if (error) {
                    [XTCustomLoading showToastWithMessage:@"分享失败"];
                    NSLog(@"*********************%@******************",error);
                } else {
                    [XTCustomLoading showToastWithMessage:@"分享成功"];
                    [self removeFromSuperview];
                    [self shareSuccessAndSendIntegralWithShareType:type];
                    if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                        UMSocialShareResponse *resp = data;
                        //分享结果消息
                        NSLog(@"response message is %@",resp.message);
                        //第三方原始返回的数据
                        NSLog(@"response originalResponse data is %@",resp.originalResponse);
                        
                    }else{
                        NSLog(@"response data is %@",data);
                    }
                }
            }];
            
        }

    }
}

- (void)shareSuccessAndSendIntegralWithShareType:(NSString *)type {
    if (self.isSendIntegral && type == wechatType) {
//        XTBBSSendIntegralAPI * integralApi = [[XTBBSSendIntegralAPI alloc]initUserIdWith:[XTUserManager sharedXTUserManager].getUserInfo.userId withShareInfo:self.shareInfo];
//        NSString *authorization = [NSString stringWithFormat:@"Bearer %@",[XTUserManager sharedXTUserManager].getUserInfo.accessToken];
//        integralApi.authorization = authorization;
//        [integralApi requestStart:^(NSInteger responseCode, NSDictionary *successDate) {
//
//        } failure:^(RequestErrorType errorType, NSDictionary *errorData) {
//            [XTCustomLoading showToastWithMessage:[errorData valueForKey:@"message"]];
//        }];
    }
}

- (void)cancelButtonAction {
    
    [self cancelView];
    
}

- (void)layoutAllViews
{
//    if ([[[XTUserManager sharedXTUserManager]getUserInfo].mobile isEqualToString:TestAccount]) {
//        [self.footView makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(KScreenHeight);
//            make.left.equalTo(0);
//            make.right.equalTo(0);
//            make.height.equalTo(kRealValue(291));
//        }];
//        [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(0);
//            make.left.equalTo(kRegularMargin);
//            make.right.equalTo(-kRegularMargin);
//            make.height.equalTo(kRealValue(216));
//        }];
//    }else{
        if (self.isDel) {
            [self.footView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(KScreenWidth);
                make.left.mas_equalTo(0);
                make.right.mas_equalTo(0);
                make.height.mas_equalTo(kRealValue(291));
            }];
            [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0);
                make.left.mas_equalTo(kRegularMargin);
                make.right.mas_equalTo(-kRegularMargin);
                make.height.mas_equalTo(kRealValue(216));
            }];
        }else{
            [self.footView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(KScreenHeight);
                make.left.mas_equalTo(0);
                make.right.mas_equalTo(0);
                make.height.mas_equalTo(kRealValue(191));
            }];
            [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0);
                make.left.mas_equalTo(kRegularMargin);
                make.right.mas_equalTo(-kRegularMargin);
                make.height.mas_equalTo(kRealValue(116));
            }];
        }
//    }
    
    [self.weChatButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kRealValue(28));
        make.top.mas_equalTo(kRealValue(21));
        make.size.mas_equalTo(CGSizeMake(kRealValue(50), kRealValue(50)));
    }];
    
    [self.weChatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.weChatButton.mas_bottom).offset(kRealValue(7));
        make.centerX.mas_equalTo(self.weChatButton);
    }];
    
    [self.friendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.weChatButton.mas_right).offset(kRealValue(33));
        make.centerY.mas_equalTo(self.weChatButton.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kRealValue(50), kRealValue(50)));
    }];
    
    [self.friendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.friendButton.mas_bottom).offset(kRealValue(7));
        make.centerX.mas_equalTo(self.friendButton);
    }];
    
    [self.sinaButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.friendButton.mas_right).offset(kRealValue(33));
        make.centerY.mas_equalTo(self.friendButton);
        make.size.mas_equalTo(CGSizeMake(kRealValue(50), kRealValue(50)));
    }];
    
    [self.sinaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sinaButton.mas_bottom).offset(kRealValue(7));
        make.centerX.mas_equalTo(self.sinaButton);
    }];
    
    [self.reportBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.sinaButton.mas_right).offset(kRealValue(33));
        make.centerY.mas_equalTo(self.sinaButton);
        make.size.mas_equalTo(CGSizeMake(kRealValue(50), kRealValue(50)));
    }];
    
    [self.reportLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.reportBtn.mas_bottom).offset(kRealValue(7));
        make.centerX.equalTo(self.reportBtn);
    }];
    
//    if ([[[XTUserManager sharedXTUserManager]getUserInfo].mobile isEqualToString:TestAccount]) {
//
//        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.sinaLabel.mas_bottom).offset(kLargeMargin);
//            make.left.equalTo(kRegularMargin);
//            make.width.equalTo(KScreenWidth);
//            make.height.equalTo(1);
//        }];
//        [self.shieldButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(kRealValue(28));
//            make.top.equalTo(self.lineView.mas_bottom).offset(kRealValue(15));
//            make.size.equalTo(CGSizeMake(kRealValue(50), kRealValue(50)));
//        }];
//
//        [self.shieldLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.shieldButton.mas_bottom).offset(kRealValue(7));
//            make.centerX.equalTo(self.shieldButton);
//        }];
//
//        if (self.isDel) {
//            [self.delButton mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.equalTo(self.shieldButton.mas_right).offset(kRealValue(33));
//                make.top.equalTo(self.lineView.mas_bottom).offset(kRealValue(15));
//                make.size.equalTo(CGSizeMake(kRealValue(50), kRealValue(50)));
//            }];
//
//            [self.delLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(self.delButton.mas_bottom).offset(kRealValue(7));
//                make.centerX.equalTo(self.delButton);
//            }];
//        }
//    }else{
        
        if (self.isDel) {
            [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.sinaLabel.mas_bottom).offset(kLargeMargin);
                make.left.mas_equalTo(kRegularMargin);
                make.width.mas_equalTo(KScreenWidth);
                make.height.mas_equalTo(1);
            }];
            
            [self.delButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(kRealValue(28));
                make.top.mas_equalTo(self.lineView.mas_bottom).offset(kRealValue(15));
                make.size.mas_equalTo(CGSizeMake(kRealValue(50), kRealValue(50)));
            }];
            
            [self.delLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.delButton.mas_bottom).offset(kRealValue(7));
                make.centerX.equalTo(self.delButton);
            }];
        }
//    }
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kRegularMargin);
        make.right.mas_equalTo(-kRegularMargin);
        make.top.mas_equalTo(self.topView.mas_bottom).offset(kRegularMargin);
        make.height.mas_equalTo(kRealValue(57));
    }];
    [self layoutIfNeeded];
}

- (UIView *)footView {
    if (_footView == nil) {
        _footView = [UIView new];
        _footView.backgroundColor = [UIColor clearColor];
        [self addSubview:_footView];
    }
    return _footView;
}
- (UIView *)topView
{
    if (!_topView) {
        _topView = [[UIView alloc]init];
        _topView.layer.cornerRadius = kRealValue(12);
        _topView.backgroundColor = KUIColorHexValue(0xf0f1f2, 0.95);
        [self.footView addSubview:_topView];
    }
    return _topView;
}

- (UIButton *)cancelButton {
    if (_cancelButton == nil) {
        _cancelButton = [[UIButton alloc]init];
        [_cancelButton setTitle:@"关闭" forState:UIControlStateNormal];
        _cancelButton.backgroundColor = KUIColorHexValue(0xf0f1f2, 0.95);
        _cancelButton.titleLabel.font = FONT(@"PingFangSC-Regular", kRealValue(18));
        _cancelButton.layer.cornerRadius = kRealValue(12);
        [_cancelButton setTitleColor:KUIColorHexValue(0x030303, 1) forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.footView addSubview:_cancelButton];
    }
    return _cancelButton;
}

- (UIButton *)weChatButton {
    if (_weChatButton == nil) {
        _weChatButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_weChatButton setImage:[UIImage imageNamed:@"weixin_nor"] forState:UIControlStateNormal];
        [_weChatButton addTarget:self action:@selector(wechatButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.topView addSubview:_weChatButton];
    }
    return _weChatButton;
}

- (XTMyCarCellLabel *)weChatLabel {
    if (_weChatLabel == nil) {
        _weChatLabel = [[XTMyCarCellLabel alloc]initWithFontSize:kRealValue(11) color:KUIColorHexValue(0x030303, 1)];
        _weChatLabel.text = @"微信";
        [self.topView addSubview:_weChatLabel];
    }
    return _weChatLabel;
}

- (UIButton *)friendButton {
    if (_friendButton == nil) {
        _friendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_friendButton setImage:[UIImage imageNamed:@"weifriend_nor"] forState:UIControlStateNormal];
        [_friendButton addTarget:self action:@selector(friendButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.topView addSubview:_friendButton];
    }
    return _friendButton;
}

- (XTMyCarCellLabel *)friendLabel {
    if (_friendLabel == nil) {
        _friendLabel = [[XTMyCarCellLabel alloc]initWithFontSize:kRealValue(11) color:KUIColorHexValue(0x030303, 1)];
        _friendLabel.text = @"朋友圈";
        [self.topView addSubview:_friendLabel];
    }
    return _friendLabel;
}

- (UIButton *)sinaButton {
    if (_sinaButton == nil) {
        _sinaButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sinaButton setImage:[UIImage imageNamed:@"weibo_nor"] forState:UIControlStateNormal];
        [_sinaButton addTarget:self action:@selector(sinaButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.topView addSubview:_sinaButton];
    }
    
    return _sinaButton;
}

- (XTMyCarCellLabel *)sinaLabel {
    if (_sinaLabel == nil) {
        _sinaLabel = [[XTMyCarCellLabel alloc]initWithFontSize:kRealValue(11) color:KUIColorHexValue(0x030303, 1)];
        _sinaLabel.text = @"新浪";
        [self.topView addSubview:_sinaLabel];
    }
    return _sinaLabel;
}

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = KUIColorHexValue(0x272F3D, 0.1);
        [self.topView addSubview:_lineView];
    }
    return _lineView;
}
- (UIButton *)reportBtn
{
    if (!_reportBtn) {
        _reportBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_reportBtn setImage:[UIImage imageNamed:@"custrom_report"] forState:UIControlStateNormal];
        [_reportBtn addTarget:self action:@selector(reportButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.topView addSubview:_reportBtn];
    }
    return _reportBtn;
}

- (XTMyCarCellLabel *)reportLabel {
    if (_reportLabel == nil) {
        _reportLabel = [[XTMyCarCellLabel alloc]initWithFontSize:kRealValue(11) color:KUIColorHexValue(0x030303, 1)];
        _reportLabel.text = @"举报";
        [self.topView addSubview:_reportLabel];
    }
    return _reportLabel;
}

- (UIButton *)shieldButton
{
    if (!_shieldButton) {
        _shieldButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shieldButton setImage:[UIImage imageNamed:@"custrom_shield"] forState:UIControlStateNormal];
        [_shieldButton addTarget:self action:@selector(shieldButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.topView addSubview:_shieldButton];
    }
    return _shieldButton;
}
- (XTMyCarCellLabel *)shieldLabel
{
    if (_shieldLabel == nil) {
        _shieldLabel = [[XTMyCarCellLabel alloc]initWithFontSize:kRealValue(11) color:KUIColorHexValue(0x030303, 1)];
        _shieldLabel.text = @"屏蔽";
        [self.topView addSubview:_shieldLabel];
    }
    return _shieldLabel;
}

- (UIButton *)delButton
{
    if (!_delButton) {
        _delButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_delButton setImage:[UIImage imageNamed:@"custrom_del"] forState:UIControlStateNormal];
        [_delButton addTarget:self action:@selector(delButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.topView addSubview:_delButton];
    }
    return _delButton;
}

- (XTMyCarCellLabel *)delLabel {
    if (_delLabel == nil) {
        _delLabel = [[XTMyCarCellLabel alloc]initWithFontSize:kRealValue(11) color:KUIColorHexValue(0x030303, 1)];
        _delLabel.text = @"删除";
        [self.topView addSubview:_delLabel];
    }
    return _delLabel;
}
- (void)delButtonAction
{
    [self cancelView];
    
    if (self.delBlock) {
        self.delBlock();
    }
}

- (void)shieldButtonAction
{
    [self cancelView];
    if (self.shieldBlock) {
        self.shieldBlock();
    }
}

- (void)reportButtonAction
{
    [self cancelView];
    [XTCustomLoading showToastWithMessage:@"举报成功"];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self cancelView];
}
- (void)cancelView
{
    [UIView animateWithDuration:0.35 animations:^{
        [self.footView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(KScreenHeight);
        }];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
