//
//  ZXOperatePlist.h
//  数据测试
//
//  Created by rason on 5/29/15.
//  Copyright (c) 2015 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXOperatePlist : NSObject
+(NSMutableArray *)getPlistWithName:(NSString *)name;
+(void)saveArr:(NSArray *)infoArr toPlist:(NSString *)name;
//+(NSArray *)getDesArrFromPlistName:(NSString *)name;
+(void)clearOperatePlistByName:(NSString *)flieName;
+(void)setPlist:(NSString *)name plistLength:(int)length;

+(void)saveDic:(NSDictionary *)dic toPlist:(NSString *)name;
+(NSMutableDictionary *)getDicFromPlistWithName:(NSString *)name;
@end
