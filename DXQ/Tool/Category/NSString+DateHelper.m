//
//  NSString+DateHelper.m
//  NanYueTong
//
//  Created by rason on 7/11/15.
//  Copyright (c) 2015 mac. All rights reserved.
//

#import "NSString+DateHelper.h"

@implementation NSString (DateHelper)
-(NSString *)stringWithBeforeFormat:(NSString *)beforeFormat afterFormat:(NSString *)afterFormat{
    NSDateFormatter *beforeFormatter = [[NSDateFormatter alloc] init];
    [beforeFormatter setDateFormat:beforeFormat];
    NSDate *date = [beforeFormatter dateFromString:self];

    NSDateFormatter *afterFormatter = [[NSDateFormatter alloc] init];
    [afterFormatter setDateFormat:afterFormat];
    NSString *destDateString = [afterFormatter stringFromDate:date];
    return destDateString;
}
-(NSString *)formatToDayyyyy_MM_dd{
    return [self stringWithBeforeFormat:@"yyyyMMdd" afterFormat:@"yyyy-MM-dd"];
}
-(NSString *)formatToDayHHmm{
    return [self stringWithBeforeFormat:@"HHmm" afterFormat:@"HH:mm"];
}
-(NSDate *)dateFromStringWithFormat:(NSString *)format{
    NSDateFormatter *beforeFormatter = [[NSDateFormatter alloc] init];
    [beforeFormatter setDateFormat:format];
    NSDate *date = [beforeFormatter dateFromString:self];
    return date;
}
@end
