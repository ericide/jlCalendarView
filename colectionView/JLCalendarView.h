//
//  JLCalendarView.h
//  colectionView
//
//  Created by junlei on 15/6/29.
//  Copyright (c) 2015年 HA. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JLCalendarView;

@protocol JLCalendarViewDategete
- (void)returnDidTouchforJLCalendarView:(JLCalendarView*)JLCalendarView;
- (void)JLCalendarView:(JLCalendarView *)view dateDidSelect:(NSDate* )date;
- (BOOL)JLCalendarView:(JLCalendarView *)view elementHighlightSelect:(NSDate* )date;
@end
@interface JLCalendarView : UIView
@property (nonatomic,weak) id<JLCalendarViewDategete> delegate;
@end
