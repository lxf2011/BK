//
//  DXActTool.m
//  DXQ
//
//  Created by 做功课 on 15/8/14.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import "DXActTool.h"

@implementation DXActTool

+ (void)getActWithParams:(DXGetActivityParam *)param success:(void (^)(DXGetActivityModel *))success failure:(void (^)(NSError *))failure{
    NSString *url = [NSString stringWithFormat:@"%@/getActByCat", DXNetworkAddress];
    [self getWithUrl:url param:param resultClass:[DXGetActivityModel class] success:success failure:failure];
}
@end
