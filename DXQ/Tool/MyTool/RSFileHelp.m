//
//  RSFileHelp.m
//  DXQ
//
//  Created by rason on 8/13/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "RSFileHelp.h"

@implementation RSFileHelp

//根据文件名，获取相应字符串
+(NSString *)getStringFromFile:(NSString *)filename{
    NSString *path = [self fullPathByFileName:filename];
    NSString *data = [[NSString alloc]initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    return data;
}
//搜索包文件并返回路径
+(NSString *) fullPathByFileName:(NSString*)fileName{
    NSString *ext = [fileName pathExtension];
    NSString *name = [fileName stringByDeletingPathExtension];
    NSString *fullPath = [[NSBundle mainBundle] pathForResource:name ofType:ext];
    return fullPath;
}
@end
