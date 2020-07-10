//
//  XTAreaView.h
//  Sitech
//
//  Created by 张宇 on 2018/11/14.
//  Copyright © 2018年 sitechTeam. All rights reserved.
//

//需要引入 XTAreaModel.h文件 XTFontAndColorMacros_h宏定义文件

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    AreaSelectViewTypeProvinces, ///省份
    AreaSelectViewTypeCity,      ///城市
    AreaSelectViewTypeArea,      ///地区
    AreaSelectViewTypeStreet,    ///街道
} AreaSelectViewType;

@protocol AreaSelectDelegate <NSObject>
@optional
- (void)selectIndex:(NSInteger)index selectID:(NSString *)areaID;

- (void)getSelectProvince:(NSString *)province withProvinceId:(NSString *)provinceId;

- (void)getSelectProvince:(NSString *)province withCity:(NSString *)city withProvinceId:(NSString *)provinceId withCityId:(NSString *)cityId;

- (void)getSelectProvince:(NSString *)province withCity:(NSString *)city withArea:(NSString *)area withProvinceId:(NSString *)provinceId withCityId:(NSString *)cityId withAreaId:(NSString *)areaId;

- (void)getSelectProvince:(NSString *)province withCity:(NSString *)city withArea:(NSString *)area withStreet:(NSString *)street withProvinceId:(NSString *)provinceId withCityId:(NSString *)cityId withAreaId:(NSString *)areaId withStreetId:(NSString *)streetId;

@end

@interface XTAreaView : UIView<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIScrollView *areaScrollView;
@property(nonatomic,strong)UIView *areaWhiteBaseView;
@property(nonatomic,strong)NSMutableArray *provinceArray;
@property(nonatomic,strong)NSMutableArray *cityArray;
@property(nonatomic,strong)NSMutableArray *areaArray;
@property(nonatomic,strong)NSMutableArray *streetArray;
@property(nonatomic,strong)id <AreaSelectDelegate> address_delegate;
@property (nonatomic, assign) AreaSelectViewType selectViewAccuracy;//选择区域精度，默认精确到城市

- (instancetype)initWithFrame:(CGRect)frame selectViewAccuracy:(AreaSelectViewType)selectViewAccuracy;

- (void)showAreaView;
- (void)hidenAreaView;

@end

NS_ASSUME_NONNULL_END
