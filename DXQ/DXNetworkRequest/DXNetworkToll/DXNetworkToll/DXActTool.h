//
//  DXActTool.h
//  DXQ
//
//  Created by 做功课 on 15/8/14.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RFBaseTool.h"
#import "DXGetActivityParam.h"
#import "DXGetActivityModel.h"

@interface DXActTool : RFBaseTool
/**
 *  获取活动列表
 */
+ (void)getActWithParams:(DXGetActivityParam *)param success:(void(^)(DXGetActivityModel *result))success failure:(void(^)(NSError *error))failure;
@end
