//
//  NSDate+Extension.m
//  YZCCalender
//
//  Created by Jason on 2018/1/17.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

#pragma mark - 获取年月日小时
+ (NSArray *)getYearMonthDayHour:(NSString *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    NSDate           *startDate     = [dateFormatter dateFromString:date];
    NSDateComponents *components    = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday) fromDate:startDate];
    
    return @[[NSString stringWithFormat:@"%ld",components.year],
             [NSString stringWithFormat:@"%ld",components.month],
             [NSString stringWithFormat:@"%ld",components.day],
             [NSString stringWithFormat:@"%ld",components.hour]];
}

#pragma mark - 获取小时
+ (NSInteger)hour:(NSString *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    NSDate           *startDate     = [dateFormatter dateFromString:date];
    NSDateComponents *components    = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday) fromDate:startDate];
    
    return components.hour;
}
#pragma mark -- 获取日
+ (NSInteger)day:(NSString *)date {
    NSDateFormatter  *dateFormatter = [[self class] setDataFormatter];
    NSDate           *startDate     = [dateFormatter dateFromString:date];
    NSDateComponents *components    = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:startDate];
    
    return components.day;
}

#pragma mark -- 获取月
+ (NSInteger)month:(NSString *)date {
    NSDateFormatter  *dateFormatter = [[self class] setDataFormatter];
    NSDate           *startDate     = [dateFormatter dateFromString:date];
    NSDateComponents *components    = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:startDate];
    
    return components.month;
}

#pragma mark -- 获取年
+ (NSInteger)year:(NSString *)date {
    NSDateFormatter  *dateFormatter = [[self class] setDataFormatter];
    NSDate           *startDate     = [dateFormatter dateFromString:date];
    NSDateComponents *components    = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:startDate];
    
    return components.year;
}

#pragma mark -- 获得当前月份第一天星期几
+ (NSInteger)firstWeekdayInThisMonth:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //设置每周的第一天从周几开始,默认为1,从周日开始
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate     *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    NSUInteger firstWeekday         = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    //若设置从周日开始算起则需要减一,若从周一开始算起则不需要减
    return firstWeekday - 1;
}

#pragma mark -- 获取当前月共有多少天
+ (NSInteger)totaldaysInMonth:(NSDate *)date {
    NSRange daysInLastMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInLastMonth.length;
}

#pragma mark -- 获取日期
+ (NSString *)timeStringWithInterval:(NSTimeInterval)timeInterval {
    NSDateFormatter *dateFormatter = [[self class] setDataFormatter];
    NSDate          *date          = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSString        *dateString    = [dateFormatter stringFromDate:date];
    
    return dateString;
}

#pragma mark -- 设置日期格式
+ (NSDateFormatter *)setDataFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    return dateFormatter;
}

#pragma mark -- 计算两个日期之间相差天数
+ (NSDateComponents *)calcDaysbetweenDate:(NSString *)startDateStr endDateStr:(NSString *)endDateStr {
    NSDateFormatter *dateFormatter = [[self class] setDataFormatter];
    NSDate          *startDate     = [dateFormatter dateFromString:startDateStr];
    NSDate          *endDate       = [dateFormatter dateFromString:endDateStr];
    
    //利用NSCalendar比较日期的差异
    NSCalendar *calendar = [NSCalendar currentCalendar];
    /**
     * 要比较的时间单位,常用如下,可以同时传：
     *    NSCalendarUnitDay : 天
     *    NSCalendarUnitYear : 年
     *    NSCalendarUnitMonth : 月
     *    NSCalendarUnitHour : 时
     *    NSCalendarUnitMinute : 分
     *    NSCalendarUnitSecond : 秒
     */
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    NSDateComponents *delta = [calendar components:unit fromDate:startDate toDate:endDate options:0];
    
    return delta;
}

+ (NSTimeInterval)timeIntervalFromDateString:(NSString *)dateString {
    static NSDateFormatter *dateFormatter = nil;
    
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        [dateFormatter setLocale:[NSLocale currentLocale]];
    }
    
    NSDate         *date    = [dateFormatter dateFromString:dateString];
    NSTimeInterval interval = [date timeIntervalSince1970];
    
    return interval;
}

+ (NSTimeInterval)timeIntervalFromDateStringYearMonthDay:(NSString *)dateString {
    static NSDateFormatter *dateFormatter = nil;
    
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        [dateFormatter setLocale:[NSLocale currentLocale]];
    }
    
    NSString *ts1 = @"1970-01-01 00:00";
    NSDateFormatter *fm1 = [[NSDateFormatter alloc] init];
    [fm1 setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *td1 = [fm1 dateFromString:ts1];
    
    NSDateFormatter *fm2 = [[NSDateFormatter alloc] init];
    [fm2 setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *td2 = [fm2 dateFromString:dateString];
    
    NSTimeInterval timeInterval = [[NSNumber numberWithDouble:[td2 timeIntervalSinceDate:td1]] integerValue];
    
    return timeInterval;
}

//获取从1900开始的时间戳
+ (NSTimeInterval)timeIntervalFromDateSince1900:(NSString *)dateString
{
    static NSDateFormatter *dateFormatter = nil;
    
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        [dateFormatter setLocale:[NSLocale currentLocale]];
    }
    NSString *ts1 = @"1900-01-01 00:00:00";
    NSDateFormatter *fm1 = [[NSDateFormatter alloc] init];
    [fm1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *td1 = [fm1 dateFromString:ts1];
    
    NSDateFormatter *fm2 = [[NSDateFormatter alloc] init];
    [fm2 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *td2 = [fm2 dateFromString:dateString];
    
    NSTimeInterval timeInterval = [[NSNumber numberWithDouble:[td2 timeIntervalSinceDate:td1]] integerValue];
    
    return timeInterval;
}

+ (BOOL)isToday:(NSString *)date {
    BOOL isToday = NO;
    NSString *today = [NSDate timeStringWithInterval:[NSDate date].timeIntervalSince1970];
    if ([date isEqualToString:today]) {
        isToday = YES;
    }
    return isToday;
}

+ (BOOL)isEqualBetweenWithDate:(NSString *)date toDate:(NSString *)toDate {
    BOOL isToday = NO;
    if ([toDate isEqualToString:date]) {
        isToday = YES;
    }
    return isToday;
}

+ (BOOL)isCurrenMonth:(NSString *)date {
    BOOL isCurrenMonth = NO;
    NSString *month = [[NSDate timeStringWithInterval:[NSDate date].timeIntervalSince1970] substringWithRange:NSMakeRange(0, 7)];
    
    if ([date isEqualToString:month]) {
        isCurrenMonth = YES;
    }
    return isCurrenMonth;
}

+ (NSString *)currentTimeYearMonthDay
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *datenow = [NSDate date];
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];

    return currentTimeString;
}

+ (NSString *)currentTimeYearMonthDayHour
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH"];
    NSDate *datenow = [NSDate date];
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    return currentTimeString;
}

+ (NSString *)getTimeYearMonthDayHour:(NSTimeInterval)timeInterval {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    NSDate          *date          = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSString        *dateString    = [dateFormatter stringFromDate:date];
    return dateString;
}

+ (NSString *)getTime:(NSTimeInterval)timeInterval dateFormat:(NSString *)dateFormat {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    NSDate          *date          = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSString        *dateString    = [dateFormatter stringFromDate:date];
    return dateString;
}

//获取两个时间差 ，上传时间戳
+ (NSDateComponents *)calcHourbetweenDate:(long long )startTime endDateStr:(long long)endTime
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *starDate = [NSDate dateWithTimeIntervalSince1970:startTime /1000];//开始时间
    
    NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:endTime / 1000];//结束时间
    
    unsigned int unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *d = [calendar components:unitFlags fromDate:starDate toDate:endDate options:0];
    
    return d;
}

//时间戳转时间
+ (NSString *)getTimeToTimeStr:(NSInteger)nowTime
{
    CGFloat time = nowTime/1000.0;
    NSDate * detailDate = [NSDate dateWithTimeIntervalSince1970:time];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [dateFormatter setTimeZone:timeZone];
    NSString *timeStr = [dateFormatter stringFromDate:detailDate];
    return timeStr;
}

+(BOOL)isWeekDay:(NSString *)timeStr
{
    BOOL isWeekDay = NO;
    static NSDateFormatter *inputFormatter = nil;
    static NSCalendar *calendar = nil;

    if (inputFormatter == nil) {
        inputFormatter=[[NSDateFormatter alloc]init];
        [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    
    if (calendar == nil) {
      calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    }
    
    NSDate *formatterDate= [inputFormatter dateFromString:timeStr];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:formatterDate];
    if (components.weekday == 7 || components.weekday == 1) {
        isWeekDay = YES;
    }
    return isWeekDay;
}

+ (NSInteger) getNowTimeTimestamp {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    return (long)[datenow timeIntervalSince1970]*1000;
}

@end

