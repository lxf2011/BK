//
//  DXCommetTool.h
//  DXQ
//
//  Created by rason on 8/12/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "RFBaseTool.h"
#import "DXAddCommetParam.h"
#import "DXAddCommetModel.h"
#import "DXGetCommetsParam.h"
#import "DXGetCommetsModel.h"
@interface DXCommetTool : RFBaseTool
/**
 *  添加评论
 */
+ (void)postAddCommentWithParams:(DXAddCommetParam *)param success:(void (^)(DXAddCommetModel *result))success failure:(void(^)(NSError *error))failure;

/**
 *  获取评论列表
 */
+ (void)getCommentsWithParams:(DXGetCommetsParam *)param success:(void (^)(DXGetCommetsModel *result))success failure:(void(^)(NSError *error))failure;
@end
