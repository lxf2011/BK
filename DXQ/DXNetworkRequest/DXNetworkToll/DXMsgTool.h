//
//  DXMsgTool.h
//  DXQ
//
//  Created by rason on 8/11/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "RFBaseTool.h"
#import "DXMsgListParam.h"
#import "DXMsgListModel.h"
#import "DXMsgAvtListParam.h"
#import "DXMsgAvtListModel.h"
@interface DXMsgTool : RFBaseTool
/**
 *  获取资讯列表
 */
+ (void)getMsgByCatWithParams:(DXMsgListParam *)param success:(void (^)(DXMsgListModel *result))success failure:(void(^)(NSError *error))failure;
/**
 *  获取资讯广告
 */
+ (void)getAvtWithParams:(DXMsgAvtListParam *)param success:(void (^)(DXMsgAvtListModel *result))success failure:(void(^)(NSError *error))failure;

@end
