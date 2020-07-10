//
//  XTAreaModel.m
//  Sitech
//
//  Created by 张宇 on 2018/11/14.
//  Copyright © 2018年 sitechTeam. All rights reserved.
//

#import "XTAreaModel.h"

@implementation XTAreaModel

- (instancetype)initWithAreaId:(NSString *)areaId areaName:(NSString *)areaName{
    if (self = [super init]) {
        _areaId = areaId;
        _areaName = areaName;
    }
    return self;
}

@end
