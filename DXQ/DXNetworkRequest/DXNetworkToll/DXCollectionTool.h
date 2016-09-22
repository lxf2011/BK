//
//  DXCollectionTool.h
//  DXQ
//
//  Created by rason on 8/16/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "RFBaseTool.h"
#import "DXCollectionParam.h"
#import "DXCollectionModel.h"
@interface DXCollectionTool : RFBaseTool
/**
 *  获取用户收藏的资讯、活动、精品和社团
 */
+ (void)getCollectionWithParams:(DXCollectionParam *)param success:(void(^)(DXCollectionModel *model))success failure:(void(^)(NSError *error))failure;
@end
