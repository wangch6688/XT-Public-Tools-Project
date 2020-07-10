//
//  NSDate+Extension.h
//  YZCCalender
//
//  Created by Jason on 2018/1/17.
//  Copyright © 2018年 jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)
//获取小时
+ (NSInteger)hour:(NSString *)date;
+ (NSArray *)getYearMonthDayHour:(NSString *)date;
//获取日
+ (NSInteger)day:(NSString *)date;
//获取月
+ (NSInteger)month:(NSString *)date;
//获取年
+ (NSInteger)year:(NSString *)date;
//获取当月第一天周几
+ (NSInteger)firstWeekdayInThisMonth:(NSDate *)date;
//获取当前月有多少天
+ (NSInteger)totaldaysInMonth:(NSDate *)date;
//计算两个日期之间相差天数
+ (NSDateComponents *)calcDaysbetweenDate:(NSString *)startDateStr endDateStr:(NSString *)endDateStr;
//获取两个时间差 传时间戳
+ (NSDateComponents *)calcHourbetweenDate:(long long )startTime endDateStr:(long long)endTime;
//获取日期
+ (NSString *)timeStringWithInterval:(NSTimeInterval)timeInterval;
//根据具体日期获取时间戳
+ (NSTimeInterval)timeIntervalFromDateString:(NSString *)dateString;
//当前时间的年月日
+ (NSString *)currentTimeYearMonthDay;
//获取当前时间的年月日时
+ (NSString *)currentTimeYearMonthDayHour;
//当前时间的年月日时
+ (NSString *)getTimeYearMonthDayHour:(NSTimeInterval)timeInterval;
//当前时间的年月日时
+ (NSString *)getTime:(NSTimeInterval)timeInterval dateFormat:(NSString *)dateFormat;
//时间戳转时间
+ (NSString *)getTimeToTimeStr:(NSInteger)nowTime;

+ (BOOL)isToday:(NSString *)date;
+ (BOOL)isEqualBetweenWithDate:(NSString *)date toDate:(NSString *)toDate;
//格式：2018-01
+ (BOOL)isCurrenMonth:(NSString *)date;
//当前日期是星期几
+(BOOL)isWeekDay:(NSString *)timeStr;
//获取当前你的时间戳到毫秒级
+ (NSInteger)getNowTimeTimestamp;
//获取从1900开始的时间戳
//获取当前时间戳  年月日小时
+ (NSTimeInterval)timeIntervalFromDateStringYearMonthDay:(NSString *)dateString;
+ (NSTimeInterval)timeIntervalFromDateSince1900:(NSString *)dateString;
@end
