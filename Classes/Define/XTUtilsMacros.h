//
//  XTUtilsMacros.h
//  Sitech
//
//  Created by xiaoxiao on 2018/1/24.
//  Copyright © 2018年 sitechTeam. All rights reserved.
//

//全局工具类定义

#ifndef XTUtilsMacros_h
#define XTUtilsMacros_h


//获取系统对象
#define kApplication        [UIApplication sharedApplication]
#define kAppWindow          [UIApplication sharedApplication].delegate.window
#define kAppDelegate        [AppDelegate shareAppDelegate]
#define kRootViewController [UIApplication sharedApplication].delegate.window.rootViewController
#define kUserDefaults       [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]


#define isIPhoneX ([[UIApplication sharedApplication] statusBarFrame].size.height>20?YES : NO)

#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0
#define kTopHeight (kStatusBarHeight + kNavBarHeight)
#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
#define kTabBottom ([[UIApplication sharedApplication] statusBarFrame].size.height>20?34:0)
#define kPasswordItemWidth KScreenWidth/7


//获取屏幕宽高
#define KScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define KScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScreen_Bounds [UIScreen mainScreen].bounds

#define Iphone6ScaleWidth KScreenWidth/375.0
#define Iphone6ScaleHeight KScreenHeight/667.0
//根据ip6的屏幕来拉伸
#define kRealValue(with) ((with)*(KScreenWidth/375.0f))

#pragma mark - UI规范
//边距，间距
#define kSmallMargin kRealValue(5)
#define kRegularMargin kRealValue(9)
#define kMediumMargin kRealValue(12)
#define kLargeMargin kRealValue(12)

//强弱引用
#define kWeakSelf(type)  __weak typeof(type) weak##type = type;
#define kStrongSelf(type) __strong typeof(type) type = weak##type;
#define WeakSelf __weak typeof(self) weakSelf = self;

#define WeakSelf __weak typeof(self) weakSelf = self;

//View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define ImageCornerRadius kRealValue(6)
#define kViewCornerRadius kRealValue(6)
#define kSmallCornerRadius kRealValue(4)
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

//车控Identity
#define CarControl_lock @"CarControl_lock"
#define CarControl_unlock @"CarControl_unlock"
#define CarControl_HotWind @"CarControl_HotWind"
#define CarControl_ColdWind @"CarControl_ColdWind"
#define CarControl_Light @"CarControl_Light"
#define CarControl_Sound @"CarControl_Sound"

//地图annotation的identity
#define Map_userlocationIdentifier @"Map_userlocationIdentifier"
#define Map_FenceIdentifier @"Map_FenceIdentifier"
#define Map_carIdentifier @"Map_carIdentifier"
#define Map_poiIdentifier @"Map_poiIdentifier"
#define Map_elecIdentifier @"Map_elecIdentifier"
#define Map_polymerizationIdentifier @"Map_polymerizationIdentifier"
#define Map_emptyIdentifier @"Map_emptyIdentifier"
#define Map_stopOverIdentifier @"Map_stopOverIdentifier"
#define Map_provinceIdentifier @"Map_provinceIdentifier"
#define Map_cityIdentifier @"Map_cityIdentifier"

#define Map_defaultType @"Map_defaultType"
#define Map_mapSearchType @"Map_mapSearchType"
#define Map_elecType @"Map_elecType"
#define Map_ActivityType @"Map_ActivityType"
#define Map_pickFriendType @"Map_pickFriendType"


#define XTChatFaceCreateGroupNoti @"XTChatFaceCreateGroupNoti"

///IOS 版本判断
#define IOSAVAILABLEVERSION(version) ([[UIDevice currentDevice] availableVersion:version] < 0)
// 当前系统版本
#define CurrentSystemVersion [[UIDevice currentDevice].systemVersion doubleValue]
//当前语言
#define CurrentLanguage ([NSLocale preferredLanguages] objectAtIndex:0])

//DEBUG  模式下打印日志,当前行
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
//#define DLog(...)
#endif

//拼接字符串
#define NSStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]


//判断字符串是否为空
#define isNull(x)             (!x || [x isKindOfClass:[NSNull class]])
#define isEmptyString(x)      (isNull(x) || [x isEqual:@""] || [x isEqual:@"(null)"] || [x isEqual:@"<null>"])

#define Sitech_MineQrCode @"sitech_myQrCode_"
#define Sitech_GroupQrCode @"sitech_groupQrCode_"



//验证码类型
#define phoneSID @"SID028"
#define emailID @"EID002"

#define verifyCode_SID001 @"SID001"
#define verifyCode_SID002 @"SID002"
#define verifyCode_SID003 @"SID003"
#define verifyCode_SID004 @"SID004"
#define verifyCode_SID005 @"SID005"
#define verifyCode_SID006 @"SID006"
#define verifyCode_SID007 @"SID007"
#define verifyCode_SID008 @"SID008"
#define verifyCode_SID028 @"SID028"

#define CarControlVersion @"2.0.8"

#define TIMECOUNT  60

/*
 SID001:app登陆验证
 SID002:车控密码设置短信验证，
 SID003:预约短信验证，
 SID004:车控密码修改短信验证，
 SID005:修改手机号旧手机短信验证，
 SID006:修改手机号新手机短信验证,
 SID007:车辆绑定短信验证，
 SID008:密码重置、密码找回，短信验证，
 SID028:绑定邮箱的短信验证码
*/

//定义UIImage对象
#define ImageWithFile(_pointer) [UIImage imageWithContentsOfFile:([[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@@%dx", _pointer, (int)[UIScreen mainScreen].nativeScale] ofType:@"png"])]
#define IMAGE_NAMED(name) [UIImage imageNamed:name]

//数据验证
#define StrValid(f) (f!=nil && [f isKindOfClass:[NSString class]] && ![f isEqualToString:@""])
#define SafeStr(f) (StrValid(f) ? f:@"")
#define HasString(str,key) ([str rangeOfString:key].location!=NSNotFound)
#define isEmptyString(x)      (x == nil || [x isEqual:@""] || [x isEqual:@"(null)"] || [x isEqual:@"<null>"])

#define ValidStr(f) StrValid(f)
#define ValidDict(f) (f!=nil && [f isKindOfClass:[NSDictionary class]])
#define ValidArray(f) (f!=nil && [f isKindOfClass:[NSArray class]] && [f count]>0)
#define ValidNum(f) (f!=nil && [f isKindOfClass:[NSNumber class]])
#define ValidClass(f,cls) (f!=nil && [f isKindOfClass:[cls class]])
#define ValidData(f) (f!=nil && [f isKindOfClass:[NSData class]])

//获取一段时间间隔
#define kStartTime CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
#define kEndTime  NSLog(@"Time: %f", CFAbsoluteTimeGetCurrent() - start)
//打印当前方法名
#define ITTDPRINTMETHODNAME() ITTDPRINT(@"%s", __PRETTY_FUNCTION__)

//发送通知
#define KPostNotification(name,obj) [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj];

//单例化一个类
#define SINGLETON_FOR_HEADER(className) \
\
+ (className *)shared##className;

#define SINGLETON_FOR_CLASS(className) \
\
+ (className *)shared##className { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}

#define dispatch_async_main_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

#define XTNIMTeddy @"[teddy_"
#define NIMSaveTopKey   @"NIMSaveTopKey"

#define XTCarType_AEVs   @"AEVs"
#define XTCarType_DEV   @"DEV"
#define XTCarType_GEV   @"GEV"

//LED 存储
#define XTLEDCurrentSelectImageArr @"XTLEDCurrentSelectImageArr"//选中的图片
#define XTLEDCurrentSelectTextArr @"XTLEDCurrentSelectTextArr"//选中的文字
#define XTLEDAllTextArr @"XTLEDAllTextArr"//所有的文字
#define XTLEDAllImage @"XTLEDAllImage"//所有的图片
#define XTLEDAllGifArr @"XTLEDAllGifArr"//所有的GIF
#define XTLEDCustomTextArr @"XTLEDCustomTextArr"//自定义的文字

#endif /* XTUtilsMacros_h */
