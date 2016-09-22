//
//  NSString+Helper.h
//  NanYueTong
//
//  Created by Mac on 15-7-4.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Helper)
-(NSMutableString *)adjustDate:(NSString *)str;
+ (BOOL) validateIdentityCard: (NSString *)identityCard;
+(NSString *)getFilePath:(NSString *)flieName;
+(NSMutableArray *)getPlistWithName:(NSString *)name;
@end
