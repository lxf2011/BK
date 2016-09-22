//
//  DXMsgTool.m
//  DXQ
//
//  Created by rason on 8/11/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "DXMsgTool.h"

@implementation DXMsgTool
+ (void)getMsgByCatWithParams:(DXMsgListParam *)param success:(void (^)(DXMsgListModel *result))success failure:(void(^)(NSError *error))failure{
    NSString *url = [NSString stringWithFormat:@"%@/getMsgByCat?%@",DXNetworkAddress,[self queryStrByDict:[self getObjectData:param]]];
    [self getWithUrl:url param:nil resultClass:[DXMsgListModel class] success:success failure:failure];
}
+ (void)getAvtWithParams:(DXMsgAvtListParam *)param success:(void (^)(DXMsgAvtListModel *result))success failure:(void(^)(NSError *error))failure{
    NSString *url = [NSString stringWithFormat:@"%@/getAvt?%@",DXNetworkAddress,[self queryStrByDict:[self getObjectData:param]]];
    [self getWithUrl:url param:nil resultClass:[DXMsgAvtListModel class] success:success failure:failure];
}
@end
