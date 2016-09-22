//
//  DXAuthTool.h
//  DXQ
//
//  Created by rason on 8/12/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "RFBaseTool.h"
#import "DXUserParam.h"
#import "DXRegisterUserParam.h"
#import "DXRegisterUserModel.h"
#import "DXLoginUserModel.h"
#import "DXChangeUserModel.h"
#import "DXChangeUserParam.H"
#import "DXThreeUserParam.h"
#import "DXThreeUserModel.h"
#import "DXChangeUserListModel.h"
#import "DXEditPswModel.h"
#import "DXEditPswParam.h"
#import "DXUploadModel.h"
#import "DXSetPswParam.h"
@interface DXAuthTool : RFBaseTool
/**
 *  注册
 */
+ (void)postRegisterWithParams:(DXRegisterUserParam *)param success:(void (^)(DXRegisterUserModel *result))success failure:(void(^)(NSError *error))failure;
/**
 *  登录
 */
+ (void)postLoginWithParams:(DXUserParam *)param success:(void (^)(DXLoginUserModel *result))success failure:(void(^)(NSError *error))failure;
/**
 *  第三方登录
 */
+ (void)postThreeLoginWithParams:(DXThreeUserParam *)param success:(void (^)(DXThreeUserModel *result))success failure:(void(^)(NSError *error))failure;
/**
 *  找回密码
 */
+ (void)postEditPswithParams:(DXEditPswParam *)param success:(void (^)(DXEditPswModel *result))success failure:(void(^)(NSError *error))failure;
/**
 *  修改密码
 */
+ (void)getSetPswithParams:(DXSetPswParam *)param success:(void (^)(DXEditPswModel *result))success failure:(void(^)(NSError *error))failure;
/**
 *  修改用户信息
 */
+ (void)postChangeUserWithParams:(DXChangeUserParam *)param success:(void (^)(DXChangeUserModel *result))success failure:(void(^)(NSError *error))failure;
/**
 *  修改用户信息,同时修改多个属性
 */
+ (void)postChangeUserListWithParams:(NSArray *)param success:(void (^)(DXChangeUserListModel *result))success failure:(void(^)(NSError *error))failure;
/**
 *  检查登陆
 */
+ (void)getCheckUserSuccess:(void (^)())success failure:(void(^)(NSError *error))failure;
/**
 *  上传头像
 */
+ (void)postUploadConstructingBldyWithBlock:(NSString *)filePath success:(void (^)(DXUploadModel *result))success failure:(void(^)(NSError *error))failure;
@end
