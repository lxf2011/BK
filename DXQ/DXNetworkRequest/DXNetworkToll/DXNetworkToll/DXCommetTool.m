//
//  DXCommetTool.m
//  DXQ
//
//  Created by rason on 8/12/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "DXCommetTool.h"

@implementation DXCommetTool
+ (void)postAddCommentWithParams:(DXAddCommetParam *)param success:(void (^)(DXAddCommetModel *result))success failure:(void(^)(NSError *error))failure{
    NSString *url = [NSString stringWithFormat:@"%@/usr/addComment",DXNetworkAddress];
    [self postWithUrl:url param:param resultClass:[DXAddCommetModel class] success:success failure:failure];
}
+ (void)getCommentsWithParams:(DXGetCommetsParam *)param success:(void (^)(DXGetCommetsModel *result))success failure:(void(^)(NSError *error))failure{
    NSString *url = [NSString stringWithFormat:@"%@/getComment?%@",DXNetworkAddress,[self queryStrByDict:[self getObjectData:param]]];
    [self getWithUrl:url param:nil resultClass:[DXGetCommetsModel class] success:success failure:failure];
}
@end
