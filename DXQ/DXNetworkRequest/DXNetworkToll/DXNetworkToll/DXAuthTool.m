//
//  DXAuthTool.m
//  DXQ
//
//  Created by rason on 8/12/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "DXAuthTool.h"

@implementation DXAuthTool
+ (void)postRegisterWithParams:(DXUserParam *)param success:(void (^)(DXRegisterUserModel *result))success failure:(void(^)(NSError *error))failure{
    NSString *url = [NSString stringWithFormat:@"%@/register",DXNetworkAddress];
    [self postWithUrl:url param:param resultClass:[DXRegisterUserModel class] success:success failure:failure];
}
+ (void)postLoginWithParams:(DXUserParam *)param success:(void (^)(DXLoginUserModel *result))success failure:(void(^)(NSError *error))failure{
    NSString *url = [NSString stringWithFormat:@"%@/login",DXNetworkAddress];
    [self postWithUrl:url param:param resultClass:[DXLoginUserModel class] success:success failure:failure];
}
+ (void)postChangeUserWithParams:(DXChangeUserParam *)param success:(void (^)(DXChangeUserModel *result))success failure:(void(^)(NSError *error))failure{
    NSString *url = [NSString stringWithFormat:@"%@/usr/auUsrAttr",DXNetworkAddress];
    [self postWithUrl:url param:param resultClass:[DXChangeUserModel class] success:success failure:failure];
}
@end
