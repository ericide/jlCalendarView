//
//  JLCalendarView.m
//  colectionView
//
//  Created by junlei on 15/6/29.
//  Copyright (c) 2015年 HA. All rights reserved.
//
#define SCALE(n)  ((n)/1.5)

#import "JLCalendarView.h"
#import "NSCalendar+date.h"
#import "UIDateButton.h"

@interface JLCalendarView()
@property (nonatomic,strong) NSCalendar * calendar;
@property (nonatomic,strong) NSDate * date;
@property (nonatomic,strong) UIView * dynamicView;
@property (nonatomic,strong) UILabel * selectDay;
@property (nonatomic,strong) UIView * selectView;
@end
@implementation JLCalendarView

- (instancetype)init
{
    self = [super init];
    self.calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    self.date = [NSDate date];
    self.frame = CGRectMake(0, 0, SCALE(460), SCALE(600));
    self.backgroundColor = [UIColor clearColor];
    [self creatCalendarView];
    [self freshDateTable];
    return self;
}

-(void)freshDateTable
{
    NSUInteger dayNum = [self.calendar numberOfDaysInCurrentMonthForDate:self.date];
    NSUInteger firstDay = [self.calendar firstWeekDayInMonthForDate:self.date];
    NSUInteger dayCount = 1;
    
    NSUInteger todayDay = [self getMarkDayByLastDay:dayNum];
    
    for (; dayCount <= dayNum; dayCount++)  {
        UIDateButton * but = (UIDateButton *)[self.dynamicView viewWithTag:(dayCount+1024)];
        [but setTitle:[NSString stringWithFormat:@"%ld",dayCount] forState:UIControlStateNormal];
        but.hidden = NO;
        but.frame = CGRectMake((SCALE(20)+((dayCount + firstDay-2)%7)*SCALE(66)), SCALE((((dayCount + firstDay-2)/7)*80)), 25, 20);
        if (dayCount < todayDay) {
            [but setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        } else {
            [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
    for (; dayCount <= 31; dayCount++) {
        UIDateButton * but = (UIDateButton *)[self.dynamicView viewWithTag:(dayCount+1024)];
        but.hidden = YES;
    }
    
    self.selectDay.text = [NSString stringWithFormat:@"%ld年%ld月%ld日",[self.calendar yearForDate:self.date],[self.calendar monthForDate:self.date],[self.calendar dayForDate:self.date]];
}
- (NSUInteger)getMarkDayByLastDay:(NSUInteger)day
{
    NSDate * todayDate = [NSDate date];
    NSDateComponents *comps = [self.calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self.date];
    [comps setDay:day];
    NSDate * newDate = [self.calendar dateFromComponents:comps];
    if (todayDate.timeIntervalSince1970 > newDate.timeIntervalSince1970){
        return 32;
    }
    comps = [self.calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self.date];
    [comps setDay:1];
    newDate = [self.calendar dateFromComponents:comps];
    if (todayDate.timeIntervalSince1970 < newDate.timeIntervalSince1970){
        return 0;
    }
    comps = [self.calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:todayDate];
    return comps.day;
}

- (void)elementClick:(UIDateButton *)btu
{
    NSUInteger todayOfDay = btu.tag-1023;
    NSDateComponents *comps = [self.calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self.date];
    [comps setDay:todayOfDay];
    NSDate * selectDate = [self.calendar dateFromComponents:comps];
    if ([self.delegate JLCalendarView:self elementHighlightSelect:selectDate]) {
        CGPoint origin = btu.frame.origin;
        //origin.x -= 1;
        origin.y -= 1.5;
        CGRect fra = self.selectView.frame;
        fra.origin = origin;
        self.selectView.frame = fra;
        self.selectView.hidden = NO;
    } else {
        self.selectView.hidden = YES;
    }
    
    [self.delegate JLCalendarView:self dateDidSelect:selectDate];

}

- (void)returnClick
{
    [self.delegate returnDidTouchforJLCalendarView:self];
}
- (void)nextClick
{
    self.selectView.hidden = YES;
    
    NSDateComponents *comps = [self.calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self.date];
    
    if (comps.month == 12) {
        comps.month = 1;
        comps.year ++;
    } else {
        comps.month ++;
    }
    self.date = [self.calendar dateFromComponents:comps];
    [self freshDateTable];
}
- (void)previousClick
{
    self.selectView.hidden = YES;
    
    NSDateComponents *comps = [self.calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self.date];
    
    if (comps.month == 1) {
        comps.month = 12;
        comps.year --;
    } else {
        comps.month --;
    }
    self.date = [self.calendar dateFromComponents:comps];
    [self freshDateTable];
}

- (void)creatCalendarView
{
    
    //创建"请选择日期"label
    UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(0, SCALE(46), SCALE(460), 18)];
    title.text = @"请选择日期";
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont systemFontOfSize:18];
    [self addSubview:title];
    //创建返回按钮
    UIButton * returnB = [UIButton buttonWithType:UIButtonTypeContactAdd];
    CGRect re = returnB.frame;
    re.origin = CGPointMake(SCALE(20), SCALE(46));
    returnB.frame = re;
    [self addSubview:returnB];
    [returnB addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //创建星期1-7标题
    NSArray * weekDay = [NSArray arrayWithObjects:@"日",@"一",@"二",@"三",@"四",@"五",@"六",nil];
    for (int num = 0; num <7; num ++) {
        UILabel * weekLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCALE(20)+num*SCALE(66)), SCALE(102), 20, 20)];
        weekLabel.text = weekDay[num];
        weekLabel.font  = [UIFont systemFontOfSize:15];
        weekLabel.textColor = [UIColor whiteColor];
        [self addSubview:weekLabel];
    }
    
    //创建 前一个月/下一个月 按钮
    UIButton * previous = [UIButton buttonWithType:UIButtonTypeContactAdd];
    re = previous.frame;
    re.origin = CGPointMake(SCALE(126), SCALE(184));
    previous.frame = re;
    [previous addTarget:self action:@selector(previousClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:previous];
    
    UIButton * next = [UIButton buttonWithType:UIButtonTypeContactAdd];
    re = next.frame;
    re.origin = CGPointMake(SCALE(315), SCALE(184));
    next.frame = re;
    [next addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:next];
    //创建 日历 容器
    self.dynamicView = [[UIView alloc]initWithFrame:CGRectMake(0, SCALE(242), SCALE(460), SCALE(600-242))];
    self.dynamicView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.dynamicView];
    
    //创建 日历 元素
    for (int num = 1; num<32; num++) {
        UIButton * but = [[UIDateButton alloc]init];
        but.tag = 1024+num;
        but.hidden = YES;
        [but addTarget:self action:@selector(elementClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.dynamicView addSubview:but];
        but.titleLabel.font  = [UIFont systemFontOfSize:15];
    }
    

    //创建选择日期展示label
    self.selectDay = [[UILabel alloc]initWithFrame:CGRectMake(0, SCALE(184), SCALE(460), 18)];
    self.selectDay.textColor = [UIColor whiteColor];
    self.selectDay.font = [UIFont systemFontOfSize:15];
    self.selectDay.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.selectDay];
    
    //创建选择框北京
    self.selectView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 24, 24)];
    self.selectView.backgroundColor = [UIColor redColor];
    self.selectView.layer.cornerRadius = 12;
    self.selectView.hidden = YES;
    [self.dynamicView insertSubview:self.selectView atIndex:0 ];
    

}
@end
