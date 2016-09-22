//
//  NSString+DateHelper.h
//  NanYueTong
//
//  Created by rason on 7/11/15.
//  Copyright (c) 2015 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DateHelper)
-(NSString *)stringWithBeforeFormat:(NSString *)beforeFormat afterFormat:(NSString *)afterFormat;
-(NSString *)formatToDayyyyy_MM_dd;
-(NSString *)formatToDayHHmm;
-(NSDate *)dateFromStringWithFormat:(NSString *)format;
@end
