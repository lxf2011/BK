//
//  DXOrgTool.h
//  DXQ
//
//  Created by rason on 8/12/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "RFBaseTool.h"
#import "DXGetOrgMsgsParam.h"
#import "DXGetOrgMsgsModel.h"
#import "DXGetOrgsModel.h"
#import "DXGetOrgsParam.h"
@interface DXOrgTool : RFBaseTool
/**
 *  获取社团发布的资讯
 */
+ (void)getOrgMsgWithParams:(DXGetOrgMsgsParam *)param success:(void (^)(DXGetOrgMsgsModel *result))success failure:(void(^)(NSError *error))failure;
/**
 *  社团列表
 */
+ (void)getOrgsWithParams:(DXGetOrgsParam *)param success:(void (^)(NSMutableArray *result))success failure:(void(^)(NSError *error))failure;
/**
 *  获取社团详情
 */
+ (void)getOrgsDetialWithParams:(int )lid success:(void (^)(DxGetOrgsItemModel *result))success failure:(void(^)(NSError *error))failure;
@end