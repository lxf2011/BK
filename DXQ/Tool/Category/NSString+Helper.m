//
//  NSString+Helper.m
//  NanYueTong
//
//  Created by Mac on 15-7-4.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "NSString+Helper.h"

@implementation NSString (Helper)
-(NSMutableString *)adjustDate:(NSString *)str
{
    
    NSMutableString *dateStr =[NSMutableString stringWithString: [str substringWithRange:NSMakeRange(0, 4)]];
    [dateStr appendString:@"-"];
    [dateStr appendString:[str substringWithRange:NSMakeRange(4, 2)]];
    [dateStr appendString:@"-"];
    [dateStr appendString:[str substringWithRange:NSMakeRange(6, 2)]];
    
    return dateStr;

}
//判断是否为身份证
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}
+(NSString *)getFilePath:(NSString *)flieName{
    //获取应用程序沙盒的Documents目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    //得到完整的文件名
    return [plistPath1 stringByAppendingPathComponent:flieName];
}
+(NSArray *)getPlistWithName:(NSString *)name{
    
    //得到完整的文件名
    NSString *filename=[self getFilePath:name];
    NSArray *arr = [NSArray arrayWithContentsOfFile:filename];
    NSLog(@"%@",arr);
    return arr;
}
@end
