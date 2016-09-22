//
//  DXOtherTool.h
//  DXQ
//
//  Created by rason on 15/9/27.
//  Copyright © 2015年 rason. All rights reserved.
//

#import "RFBaseTool.h"

@interface DXOtherTool : RFBaseTool
+ (void)getConfigWithSuccess:(void (^)(NSDictionary *result))success failure:(void(^)(NSError *error))failure;
+ (void)getSchoolWithSuccess:(void (^)(NSArray *result))success failure:(void(^)(NSError *error))failure;
+ (void)getUpdateShareWithUrl:(NSString *)sufUrl tagertId:(NSString *)tagertId withSuccess:(void (^)(NSDictionary *result))success failure:(void(^)(NSError *error))failure;
+ (void)getLabelWithUrl:(NSString *)sufUrl withSuccess:(void (^)(NSArray *result))success failure:(void(^)(NSError *error))failure;
@end
