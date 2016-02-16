//
//  NSDate+Fun.m
//  colectionView
//
//  Created by junlei on 15/6/29.
//  Copyright (c) 2015年 HA. All rights reserved.
//

#import "NSCalendar+date.h"

@implementation NSCalendar(date)
//1. self代表的是调用方法的时间NSDate类型.这是在NSDate的类目中增加的方法
//获取当前的年
-(NSUInteger)yearForDate:(NSDate * )date
{
    NSDateComponents *components = [self components:NSCalendarUnitYear fromDate:date];
    return [components year];
}

//获取当前的月
-(NSUInteger)monthForDate:(NSDate * )date
{
    NSDateComponents *components = [self components:NSCalendarUnitMonth fromDate:date];
    return [components month];
}

//获取当前的日
-(NSUInteger)dayForDate:(NSDate * )date
{
    NSDateComponents *components = [self components:NSCalendarUnitDay fromDate:date];
    return [components day];
}

//获取当前月有多少天
- (NSUInteger)numberOfDaysInCurrentMonthForDate:(NSDate * )date
{
    // 频繁调用 [NSCalendar currentCalendar] 可能存在性能问题
    return [self rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date].length;
}


//获得一月的第一天为星期几
-(NSUInteger)firstWeekDayInMonthForDate:(NSDate * )date
{
    //[self setFirstWeekday:1];
    //[gregorian setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"nl_NL"]];
    
    //Set date to first of month
    NSDateComponents *comps = [self components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    [comps setDay:1];
    date = [self dateFromComponents:comps];
    comps = [self components:NSCalendarUnitWeekday fromDate:date];
    
    return comps.weekday;
}

//减去第一周的天数，剩余天数除以7，得到倍数和余数, 获得一个月有几周
- (NSUInteger)numberOfWeeksInCurrentMonthForDate:(NSDate * )date
{
    NSUInteger weeks = 0;
    NSUInteger weekday = [self firstWeekDayInMonthForDate:date];
    if (weekday > 0) {
        weeks += 1;
    }
    NSUInteger monthDays = [self numberOfDaysInCurrentMonthForDate:date];
    weeks = weeks + (monthDays - weekday)/7;
    if ((monthDays - weekday) %7 > 0) {
        weeks += 1;
    }
    
    return weeks;
}
@end
