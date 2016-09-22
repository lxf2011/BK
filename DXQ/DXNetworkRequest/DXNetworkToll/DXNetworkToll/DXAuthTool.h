//
//  DXAuthTool.h
//  DXQ
//
//  Created by rason on 8/12/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "RFBaseTool.h"
#import "DXUserParam.h"
#import "DXRegisterUserModel.h"
#import "DXLoginUserModel.h"
#import "DXChangeUserModel.h"
#import "DXChangeUserParam.H"
@interface DXAuthTool : RFBaseTool
/**
 *  注册
 */
+ (void)postRegisterWithParams:(DXUserParam *)param success:(void (^)(DXRegisterUserModel *result))success failure:(void(^)(NSError *error))failure;
/**
 *  登录
 */
+ (void)postLoginWithParams:(DXUserParam *)param success:(void (^)(DXLoginUserModel *result))success failure:(void(^)(NSError *error))failure;
/**
 *  修改用户信息
 */
+ (void)postChangeUserWithParams:(DXChangeUserParam *)param success:(void (^)(DXChangeUserModel *result))success failure:(void(^)(NSError *error))failure;
@end
