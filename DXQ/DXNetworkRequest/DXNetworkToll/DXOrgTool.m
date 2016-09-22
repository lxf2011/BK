//
//  DXOrgTool.m
//  DXQ
//
//  Created by rason on 8/12/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "DXOrgTool.h"
@implementation DXOrgTool
+ (void)getOrgMsgWithParams:(DXGetOrgMsgsParam *)param success:(void (^)(DXGetOrgMsgsModel *result))success failure:(void(^)(NSError *error))failure{
    NSString *url = [NSString stringWithFormat:@"%@/getOrgMsg",DXNetworkAddress];
    [self getWithUrl:url param:param resultClass:[DXGetOrgMsgsModel class] success:success failure:failure];
}
+ (void)getOrgsWithParams:(DXGetOrgsParam *)param success:(void (^)(NSMutableArray *result))success failure:(void(^)(NSError *error))failure{
    NSString *url = [NSString stringWithFormat:@"%@/v1/L_ORG",DXNetworkAddress];
    [self getWithUrl:url param:param resultClass:[DxGetOrgsItemModel class] success:success failure:failure];
}
+ (void)getOrgsDetialWithParams:(int )lid success:(void (^)(DxGetOrgsItemModel *result))success failure:(void(^)(NSError *error))failure{
    NSString *url = [NSString stringWithFormat:@"%@/v1/L_ORG/%d",DXNetworkAddress,lid];
    [self getWithUrl:url param:nil resultClass:[DxGetOrgsItemModel class] success:success failure:failure];
}
@end
