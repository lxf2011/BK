//
//  DXCollectionTool.m
//  DXQ
//
//  Created by rason on 8/16/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "DXCollectionTool.h"

@implementation DXCollectionTool
+ (void)getCollectionWithParams:(DXCollectionParam *)param success:(void(^)(DXCollectionModel *result))success failure:(void(^)(NSError *error))failure;{
    NSString *url = [NSString stringWithFormat:@"%@/usr/getCollect?%@", DXNetworkAddress, [self queryStrByDict:[self getObjectData:param]]];
    [self getWithUrl:url param:nil resultClass:[DXCollectionModel class] success:success failure:failure];
}
@end
