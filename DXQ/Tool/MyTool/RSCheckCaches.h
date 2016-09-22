//
//  RSCheckCaches.h
//  DXQ
//
//  Created by rason on 8/11/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSCheckCaches : NSObject
//获取缓存文件路径
+(NSString *)getCachesPath;
///计算缓存文件的大小的M
+ (long long) fileSizeAtPath:(NSString*) filePath;
+ (float ) folderSizeAtPath:(NSString*) folderPath;
+ (float ) folderSizeAtPath;
+(void)ss;
+(void)clearCaches;
@end
