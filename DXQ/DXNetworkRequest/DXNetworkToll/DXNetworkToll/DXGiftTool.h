//
//  DXGiftTool.h
//  DXQ
//
//  Created by rason on 8/12/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "RFBaseTool.h"
#import "DXGetGiftsParam.h"
#import "DXGetGiftsModel.h"
@interface DXGiftTool : RFBaseTool
/**
 *  获取精品列表
 */
+ (void)getGiftsWithParams:(DXGetGiftsParam *)param success:(void (^)(DXGetGiftsModel *result))success failure:(void(^)(NSError *error))failure;
@end
