//
//  ViewController.m
//  colectionView
//
//  Created by junlei on 15/6/29.
//  Copyright (c) 2015年 HA. All rights reserved.
//

#import "ViewController.h"
#import "JLCalendarView.h"

@interface ViewController ()<JLCalendarViewDategete>
@property (nonatomic,strong) NSArray * books;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor blackColor];
    
    JLCalendarView * CalendarView =[[JLCalendarView alloc]init];
    CalendarView.delegate = self;
    [self.view addSubview:CalendarView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//实现代理方法,每次用户点击了某个日期后,都会调用该方法
- (void)JLCalendarView:(JLCalendarView *)view dateDidSelect:(NSDate *)date
{
    NSLog(@"%@",date);
}
//实现代理方法,每次用户点击了某个日期后,该日期是否显示被选中状态,由该方法决定
//下例中,实现了当日之前的日期不可被选中
- (BOOL)JLCalendarView:(JLCalendarView *)view elementHighlightSelect:(NSDate *)date
{
    NSDate * todayDate = [NSDate date];
    if (date.timeIntervalSince1970 < todayDate.timeIntervalSince1970)
        return NO;
    else
        return  YES;
}
//实现代理方法,当用户点击了日历中得返回按钮时,回调此方法
- (void)returnDidTouchforJLCalendarView:(JLCalendarView *)JLCalendarView
{
    NSLog(@"用户在日历上点击了返回按钮");
}
@end
