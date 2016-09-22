//
//  RSFileHelp.h
//  DXQ
//
//  Created by rason on 8/13/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSFileHelp : NSObject
+(NSString *)getStringFromFile:(NSString *)filename;
//搜索包文件并返回路径
+(NSString *) fullPathByFileName:(NSString*)fileName;
@end
