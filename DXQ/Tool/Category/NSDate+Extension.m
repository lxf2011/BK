//
//  NSDate+Extension.m
//  新浪微博
//
//  Created by 做功课 on 15/8/2.
//  Copyright (c) 2015年 做功课. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)
- (BOOL)isThisYear{
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *dateCmps = [calender components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *nowCmps = [calender components:NSCalendarUnitYear fromDate:[NSDate date]];
    return dateCmps.year == nowCmps.year;
}

- (BOOL)isYesterday{
    // date ==  2014-04-30 10:05:28 --> 2014-04-30 00:00:00
    // now == 2014-05-01 09:22:10 --> 2014-05-01 00:00:00
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSDate *now = [NSDate date];
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:now];
    
    NSDate *date = [fmt dateFromString:dateStr];
    now = [fmt dateFromString:nowStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:now options:0];
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}

- (BOOL)isToday{
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *nowStr = [fmt stringFromDate:now];
    NSString *dateStr = [fmt stringFromDate:self];
    
    return [nowStr isEqualToString:dateStr];
}
@end
