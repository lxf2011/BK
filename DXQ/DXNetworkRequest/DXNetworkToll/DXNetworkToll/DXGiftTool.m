//
//  DXGiftTool.m
//  DXQ
//
//  Created by rason on 8/12/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "DXGiftTool.h"

@implementation DXGiftTool
+ (void)getGiftsWithParams:(DXGetGiftsParam *)param success:(void (^)(DXGetGiftsModel *result))success failure:(void(^)(NSError *error))failure{
    NSString *url = [NSString stringWithFormat:@"%@/getSpcByCat?%@",DXNetworkAddress,[self queryStrByDict:[self getObjectData:param]]];
    [self getWithUrl:url param:nil resultClass:[DXGetGiftsModel class] success:success failure:failure];
}
@end
