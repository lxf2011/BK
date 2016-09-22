//
//  DXAuthTool.m
//  DXQ
//
//  Created by rason on 8/12/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "DXAuthTool.h"

@implementation DXAuthTool
+ (void)postRegisterWithParams:(DXRegisterUserParam *)param success:(void (^)(DXRegisterUserModel *result))success failure:(void(^)(NSError *error))failure{
    NSString *url = [NSString stringWithFormat:@"%@/register",DXNetworkAddress];
    [self postWithUrl:url param:param resultClass:[DXRegisterUserModel class] success:success failure:failure];
}
+ (void)postLoginWithParams:(DXUserParam *)param success:(void (^)(DXLoginUserModel *result))success failure:(void( ^)(NSError *error))failure{
    NSString *url = [NSString stringWithFormat:@"%@/login",DXNetworkAddress];
    [self postWithUrl:url param:param resultClass:[DXLoginUserModel class] success:success failure:failure];
}
+ (void)postThreeLoginWithParams:(DXThreeUserParam *)param success:(void (^)(DXThreeUserModel *result))success failure:(void(^)(NSError *error))failure{
    NSString *url = [NSString stringWithFormat:@"%@/threeLogin",DXNetworkAddress];
    [self postWithUrl:url param:param resultClass:[DXThreeUserModel class] success:success failure:failure];
}
+ (void)postEditPswithParams:(DXEditPswParam *)param success:(void (^)(DXEditPswModel *result))success failure:(void(^)(NSError *error))failure{
    NSString *url = [NSString stringWithFormat:@"%@/editPsw",DXNetworkAddress];
    [self postWithUrl:url param:param resultClass:[DXEditPswModel class] success:success failure:failure];
}
+ (void)getSetPswithParams:(DXSetPswParam *)param success:(void (^)(DXEditPswModel *result))success failure:(void(^)(NSError *error))failure{
    NSString *url = [NSString stringWithFormat:@"%@/usr/setPsw",DXNetworkAddress];
    [self getWithUrl:url param:param resultClass:[DXEditPswModel class] success:success failure:failure];
}
+ (void)postChangeUserWithParams:(DXChangeUserParam *)param success:(void (^)(DXChangeUserModel *result))success failure:(void(^)(NSError *error))failure{
    NSString *url = [NSString stringWithFormat:@"%@/usr/auUsrAttr",DXNetworkAddress];
    [self postWithUrl:url param:param resultClass:[DXChangeUserModel class] success:success failure:failure];
}
+ (void)postChangeUserListWithParams:(NSArray *)param success:(void (^)(DXChangeUserListModel *result))success failure:(void(^)(NSError *error))failure{
    NSString *url = [NSString stringWithFormat:@"%@/usr/auUsrAttrList",DXNetworkAddress];
    [self postWithUrl:url param:param resultClass:[DXChangeUserListModel class] success:success failure:failure];
}
+ (void)getCheckUserSuccess:(void (^)())success failure:(void(^)(NSError *error))failure{
    NSString *url = [NSString stringWithFormat:@"%@/usr/checkLogin",DXNetworkAddress];
    [self getWithUrl:url param:nil resultClass:nil success:success failure:failure];
}
+ (void)postUploadConstructingBldyWithBlock:(NSString *)filePath success:(void (^)(DXUploadModel *result))success failure:(void(^)(NSError *error))failure{
    NSString *url = [NSString stringWithFormat:@"%@/usr/upload",DXNetworkAddress];
    [self post:url param:nil constructingBldyWithBlock:^(id<AFMultipartFormData> formData) {
         [formData appendPartWithFileURL:[NSURL fileURLWithPath:filePath] name:@"file" error:nil];
    } resultClass:[DXUploadModel class] success:success failure:failure];
}
@end
