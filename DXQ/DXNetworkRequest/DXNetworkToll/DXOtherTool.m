//
//  DXOtherTool.m
//  DXQ
//
//  Created by rason on 15/9/27.
//  Copyright © 2015年 rason. All rights reserved.
//

#import "DXOtherTool.h"

@implementation DXOtherTool
+ (void)getConfigWithSuccess:(void (^)(NSDictionary *result))success failure:(void(^)(NSError *error))failure{
    NSString *url = [NSString stringWithFormat:@"%@/config",DXNetworkAddress];
    [self getWithUrl:url param:nil resultClass:[NSDictionary class] success:success failure:failure];
}
+ (void)getSchoolWithSuccess:(void (^)(NSArray *result))success failure:(void(^)(NSError *error))failure{
    NSString *url = [NSString stringWithFormat:@"%@/static/json/school.json",DXNetworkAddress];
    [self getWithUrl:url param:nil resultClass:[NSArray class] success:success failure:failure];
}
+ (void)getUpdateShareWithUrl:(NSString *)sufUrl tagertId:(NSString *)tagertId withSuccess:(void (^)(NSDictionary *result))success failure:(void(^)(NSError *error))failure{
    NSString *url = [NSString stringWithFormat:@"%@/usr/%@?id=%@",DXNetworkAddress,sufUrl,tagertId];
    [self getWithUrl:url param:nil resultClass:[NSDictionary class] success:success failure:failure];
}
+ (void)getLabelWithUrl:(NSString *)sufUrl withSuccess:(void (^)(NSArray *result))success failure:(void(^)(NSError *error))failure{
    NSString *url = [NSString stringWithFormat:@"%@/v1/L_SYSTEM?query=LTYPE:%@,LPRIORITY__gt:-1",DXNetworkAddress,sufUrl];
    [self getWithUrl:url param:nil resultClass:[NSArray class] success:success failure:failure showProgress:NO];
}
@end
