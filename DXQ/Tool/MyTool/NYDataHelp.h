//
//  NYDataHelp.h
//  NanYueTong
//
//  Created by rason on 7/10/15.
//  Copyright (c) 2015 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NYDataHelp : NSObject
//根据文件名，获取相应字符串
+(NSData *)dataFromFileName:(NSString *)filename;
//根据文件名，获取相应字符串
+(NSString *)stringFromFileName:(NSString *)filename;
+(NSString *) fullPathByFileName:(NSString*)fileName;
@end
