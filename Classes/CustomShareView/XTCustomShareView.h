//
//  XTCustomShareView.h
//  Sitech
//
//  Created by wangchuang on 2018/11/8.
//  Copyright © 2018 sitechTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    shareType_wechat = 0,
    shareType_friend = 1,
    shareType_sina,
} XTShareType;

typedef void(^ShareViewDelBlock)(void);
typedef void(^ShareViewShieldBlock)(void);
typedef void(^ShareViewSuccesBlock)(XTShareType shareType);


@interface XTCustomShareView : UIView
@property (nonatomic, copy) ShareViewDelBlock delBlock;
@property (nonatomic, copy) ShareViewShieldBlock shieldBlock;
@property (nonatomic, copy) NSString * shareTitle;
@property (nonatomic, copy) NSString * shareDescription;
@property (nonatomic, copy) NSString * shareImage;
@property (nonatomic, copy) NSString * shareUrlStr;
@property (nonatomic, copy) NSString * shareVideoUrl;
@property (nonatomic, copy) NSString * shareVideoSmallImageStr;
//@property (nonatomic, assign) BOOL 
@property (nonatomic, copy) UIImage * shareImageObject;
@property (nonatomic, assign) BOOL isOnlyImageShare;
@property (nonatomic, copy)ShareViewSuccesBlock shareSucess;
@property (nonatomic, assign) XTShareType shareType;//分享类型
@property (nonatomic, assign) BOOL isSendIntegral;

@property (nonatomic, copy) NSString * shareInfo;

+ (XTCustomShareView *)sharedView;
- (void)showShareView:(BOOL)isDel;

@end

NS_ASSUME_NONNULL_END
