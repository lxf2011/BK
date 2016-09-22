//
//  ZXOperatePlist.m
//  数据测试
//
//  Created by rason on 5/29/15.
//  Copyright (c) 2015 mac. All rights reserved.
//

#import "ZXOperatePlist.h"

@implementation ZXOperatePlist

+(NSMutableArray *)getPlistWithName:(NSString *)name{
    //得到完整的文件名
    NSString *filename=[self getFilePath:name];
    NSMutableArray *arr = [NSMutableArray arrayWithContentsOfFile:filename];
    NSLog(@"%@",arr);
    return arr;
}
+(NSMutableDictionary *)getDicFromPlistWithName:(NSString *)name{
    //得到完整的文件名
    NSString *filename=[self getFilePath:name];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:filename];
    if (dic==nil) {
        return [NSMutableDictionary dictionary];
    }
    else{
        return dic;
    }
}
+(void)setPlist:(NSString *)name plistLength:(int)length{
    [[NSUserDefaults standardUserDefaults]setInteger:length forKey:name];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(void)saveArr:(NSArray *)infoArr toPlist:(NSString *)name{
    long number = [[NSUserDefaults standardUserDefaults] integerForKey:name];
    if (number==0) {
        number = 1;//设置默认长度
    }
    //得到完整的文件名
    NSString *filename=[self getFilePath:name];
    NSMutableArray *data = [self getPlistWithName:name];
    if (data == nil) {
        data = [NSMutableArray array];
    }
    for (int i=(int)[data count]-1;i>=0;i--) {
        BOOL isEqual = YES;
        NSArray *storedArr = data[i];
        for (int j=0;j<[infoArr count];j++) {
            NSString *info = infoArr[j];
            NSString *oldInfo = storedArr[j];
            if (![oldInfo isEqualToString:info]) {
                isEqual = NO;
                break;
            }
        }
        if (isEqual) {
            [data removeObjectAtIndex:i];
        }
    }
    while([data count]>=number){
        [data removeObjectAtIndex:number-1];
    }
    if ([data count]<number) {
        [data insertObject:infoArr atIndex:0];
        [data writeToFile:filename atomically:YES];
        [self getPlistWithName:name];
    }
}
+(void)saveDic:(NSDictionary *)dic toPlist:(NSString *)name{
    NSMutableDictionary *data = [self getDicFromPlistWithName:name];
    if (data==nil) {
        data = [NSMutableDictionary dictionary];
    }
    [data addEntriesFromDictionary:dic];
    //得到完整的文件名
    NSString *filename=[self getFilePath:name];
    [data writeToFile:filename atomically:YES];
}
+(NSString *)getFilePath:(NSString *)flieName{
    //获取应用程序沙盒的Documents目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    //得到完整的文件名
    return [plistPath1 stringByAppendingPathComponent:flieName];
}
+(void)clearOperatePlistByName:(NSString *)flieName{
    [[NSMutableArray array] writeToFile:[self getFilePath:flieName] atomically:YES];
}

@end
