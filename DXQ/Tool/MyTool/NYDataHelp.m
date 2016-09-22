//
//  NYDataHelp.m
//  NanYueTong
//
//  Created by rason on 7/10/15.
//  Copyright (c) 2015 mac. All rights reserved.
//

#import "NYDataHelp.h"

@implementation NYDataHelp
+(NSData *)dataFromFileName:(NSString *)filename{
    NSString *path = [self fullPathByFileName:filename];
    NSData *data = [[NSData alloc]initWithContentsOfFile:path];
    return data;
}
+(NSString *)stringFromFileName:(NSString *)filename{
    NSString *path = [self fullPathByFileName:filename];
    NSString *data = [[NSString alloc]initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    return data;
}
+(NSString *) fullPathByFileName:(NSString*)fileName{
    NSString *ext = [fileName pathExtension];
    NSString *name = [fileName stringByDeletingPathExtension];
    NSString *fullPath = [[NSBundle mainBundle] pathForResource:name ofType:ext];
    return fullPath;
}
@end
