//
//  NSDate+Fun.h
//  colectionView
//
//  Created by junlei on 15/6/29.
//  Copyright (c) 2015年 HA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSCalendar(date)
-(NSUInteger)yearForDate:(NSDate * )date;
//获取当前的月
-(NSUInteger)monthForDate:(NSDate * )date;
//获取当前的日
-(NSUInteger)dayForDate:(NSDate * )date;
//获取当前月有多少天
- (NSUInteger)numberOfDaysInCurrentMonthForDate:(NSDate * )date;
//获得一月的第一天为星期几
-(NSUInteger)firstWeekDayInMonthForDate:(NSDate * )date;
//减去第一周的天数，剩余天数除以7，得到倍数和余数, 获得一个月有几周
- (NSUInteger)numberOfWeeksInCurrentMonthForDate:(NSDate * )date;
@end
