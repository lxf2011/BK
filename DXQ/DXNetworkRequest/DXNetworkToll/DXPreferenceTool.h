//
//  DXPreferenceTool.h
//  DXQ
//
//  Created by rason on 8/13/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "RFBaseTool.h"
#import "DXAddPreferenceParam.h"
#import "DXAddPreferenceModel.h"
#import "DXUpdateMsgViewParam.h"
#import "DXUpdateMsgViewModel.h"
#import "DXUpdateActViewParam.h"
#import "DXUpdateActViewModel.h"
#import "DXGetMsgSumParam.h"
#import "DXGetMsgSumModel.h"
#import "DXGetActSumParam.h"
#import "DXGetActSumModel.h"
#import "DXGetSpcSumParam.h"
#import "DXGetSpcSumModel.h"
#import "DXDelPreferenceModel.h"
#import "DXDelPreferenceParam.h"
@interface DXPreferenceTool : RFBaseTool
/**
 *  添加点赞，收藏,浏览
 */
+ (void)postAddPreferenceWithParams:(DXAddPreferenceParam *)param success:(void (^)(DXAddPreferenceModel *result))success failure:(void(^)(NSError *error))failure;
/**
 *  删除点赞，收藏,浏览
 */
+ (void)postDelPreferenceWithParams:(DXDelPreferenceParam *)param success:(void (^)(DXDelPreferenceModel *result))success failure:(void(^)(NSError *error))failure;
/**
 *  更新资讯浏览量
 */
+ (void)getUpdateMsgViewWithParams:(DXUpdateMsgViewParam *)param success:(void (^)(DXUpdateMsgViewModel *result))success failure:(void(^)(NSError *error))failure;
/**
 *  更新活动浏览量
 */
+ (void)getUpdateActViewWithParams:(DXUpdateActViewParam *)param success:(void (^)(DXUpdateActViewModel *result))success failure:(void(^)(NSError *error))failure;
/**
 *  获取资讯点赞数、评论数、收藏数
 */
+ (void)getMsgSumWithParams:(DXGetMsgSumParam *)param success:(void (^)(DXGetMsgSumModel *result))success failure:(void(^)(NSError *error))failure;
/**
 *  获取活动点赞数、评论数、收藏数
 */
+ (void)getActSumWithParams:(DXGetActSumParam *)param success:(void (^)(DXGetActSumModel *result))success failure:(void(^)(NSError *error))failure;
/**
 *  获取精品攻略点赞数、评论数、收藏数
 */
+ (void)getSpcSumWithParams:(DXGetSpcSumParam *)param success:(void (^)(DXGetSpcSumModel *result))success failure:(void(^)(NSError *error))failure;
@end
