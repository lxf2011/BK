//
//  DXPreferenceTool.m
//  DXQ
//
//  Created by rason on 8/13/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "DXPreferenceTool.h"
#import "DXUserPreferenceStatus.h"
#import "MJExtension.h"
@implementation DXPreferenceTool
+(void)postNotificationName:(NSString *)name{
    [[NSNotificationCenter defaultCenter]postNotificationName:name object:nil];
}
+ (void)postAddPreferenceWithParams:(DXAddPreferenceParam *)param success:(void (^)(DXAddPreferenceModel *result))success failure:(void(^)(NSError *error))failure{
    NSString *url = [NSString stringWithFormat:@"%@/usr/addUsrRef",DXNetworkAddress];
    failure = ^(NSError *error){
        if (![error isKindOfClass:[NSError class]]) {
            NSArray *array = @[param.LTARGET, param.LTYPE, [NSString stringWithFormat:@"%d",param.LTARID]];
            DXAddPreferenceModel *result = (DXAddPreferenceModel *)error;
            if ([result.msg rangeOfString:@"已存在"].location !=NSNotFound) {
                [DXUserPreferenceStatus addPraiseStatus:array];
                [self postNotificationName:kNotificationPreferenceStatusChange];
            }
        }
        else{
            failure(error);
        }
        
    };
    
    [self postWithUrl:url param:param resultClass:[DXAddPreferenceModel class] success:success failure:failure showProgress:NO];
}
+ (void)postDelPreferenceWithParams:(DXDelPreferenceParam *)param success:(void (^)(DXDelPreferenceModel *result))success failure:(void (^)(NSError *))failure{
    NSString *url = [NSString stringWithFormat:@"%@/usr/delUsrRef",DXNetworkAddress];
    success =^(DXDelPreferenceModel *result){
        [self postNotificationName:kNotificationPreferenceStatusChange];
        success(result);
    };
    [self postWithUrl:url param:param resultClass:[DXDelPreferenceModel class] success:success failure:failure showProgress:NO];
}
+ (void)getUpdateMsgViewWithParams:(DXUpdateMsgViewParam *)param success:(void (^)(DXUpdateMsgViewModel *result))success failure:(void(^)(NSError *error))failure{
    NSString *url = [NSString stringWithFormat:@"%@/updateMsgView?%@",DXNetworkAddress,[self queryStrByDict:[self getObjectData:param]]];
    [self getWithUrl:url param:nil resultClass:[DXUpdateMsgViewModel class] success:success failure:failure showProgress:NO];
}
+ (void)getUpdateActViewWithParams:(DXUpdateActViewParam *)param success:(void (^)(DXUpdateActViewModel *result))success failure:(void(^)(NSError *error))failure{
    NSString *url = [NSString stringWithFormat:@"%@/updateActView?%@",DXNetworkAddress,[self queryStrByDict:[self getObjectData:param]]];
    [self getWithUrl:url param:nil resultClass:[DXUpdateActViewModel class] success:success failure:failure showProgress:NO];
}
+ (void)getMsgSumWithParams:(DXGetMsgSumParam *)param success:(void (^)(DXGetMsgSumModel *result))success failure:(void(^)(NSError *error))failure{
    NSString *url = [NSString stringWithFormat:@"%@/getMsgSum?%@",DXNetworkAddress,[self queryStrByDict:[self getObjectData:param]]];
    [self getWithUrl:url param:nil resultClass:[DXGetMsgSumModel class] success:success failure:failure];

}
+ (void)getActSumWithParams:(DXGetActSumParam *)param success:(void (^)(DXGetActSumModel *result))success failure:(void(^)(NSError *error))failure{
    NSString *url = [NSString stringWithFormat:@"%@/getActSum?%@",DXNetworkAddress,[self queryStrByDict:[self getObjectData:param]]];
    [self getWithUrl:url param:nil resultClass:[DXGetActSumModel class] success:success failure:failure];
}
+ (void)getSpcSumWithParams:(DXGetSpcSumParam *)param success:(void (^)(DXGetSpcSumModel *result))success failure:(void(^)(NSError *error))failure{
    NSString *url = [NSString stringWithFormat:@"%@/getSpcSum?%@",DXNetworkAddress,[self queryStrByDict:[self getObjectData:param]]];
    [self getWithUrl:url param:nil resultClass:[DXGetSpcSumModel class] success:success failure:failure];
}
@end
