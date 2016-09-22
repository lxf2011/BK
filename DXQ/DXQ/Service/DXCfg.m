//
//  DXCfg.m
//  DXQ
//
//  Created by rason on 15/9/19.
//  Copyright © 2015年 rason. All rights reserved.
//

#import "DXCfg.h"
#import "ZXOperatePlist.h"
@implementation DXCfg
+(void)saveStringWithKey:(NSString *)key value:(NSString *)value{
    NSLog(@"存储值：%@--%@",key,value);
    [ZXOperatePlist saveDic:@{key:value} toPlist:@"localSharedPreferences"];
}
+(void)saveObjectWithKey:(NSString *)key value:(NSObject *)value{
    NSLog(@"存储值：%@--%@",key,value);
    [ZXOperatePlist saveDic:@{key:value} toPlist:@"localSharedPreferences"];
}

+(NSString *)readStringForKey:(NSString *)key{
    NSLog(@"访问值：%@",key);
    NSMutableDictionary *dic = [ZXOperatePlist getDicFromPlistWithName:@"localSharedPreferences"];
    return [dic valueForKey:key];
}
+(NSString *)readObjectForKey:(NSString *)key{
    NSLog(@"访问值：%@",key);
    NSMutableDictionary *dic = [ZXOperatePlist getDicFromPlistWithName:@"localSharedPreferences"];
    return [dic valueForKey:key];
}
@end
