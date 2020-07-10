//
//  XTAreaModel.h
//  Sitech
//
//  Created by 张宇 on 2018/11/14.
//  Copyright © 2018年 sitechTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTAreaModel : NSObject
@property(nonatomic,strong)NSString *areaId;
@property(nonatomic,strong)NSString *areaName;

- (instancetype)initWithAreaId:(NSString *)areaId areaName:(NSString *)areaName;
@end

NS_ASSUME_NONNULL_END
