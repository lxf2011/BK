//
//  RFBaseTool.m
//  黑马微博
//
//  Created by RoKingsly on 15/6/7.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import "RFBaseTool.h"

#import "MJExtension.h"
#import "DXPublicModel.h"
#import "NSString+QEncoding.h"
#import "PrintObject.h"
#import "DXLoginHelp.h"
#import "LoginViewController.h"
#import "NYControllerTools.h"
static int retry = 0;
@implementation RFBaseTool
+ (void)getWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure showProgress:(BOOL)showProgress{
    if (retry!=0) {
        retry--;
    }
    NSDictionary *params = [param keyValues];
    NSLog(@"%@  请求参数:%@",url, params);
    [RFHttpTool get:url params:params success:^(id responseObj) {
        NSString *jsonStr = [responseObj JSONString];
        NSLog(@"%@数据处理前：%@",url,jsonStr);
        if (success) {
            if ([responseObj isKindOfClass:[NSArray class]]) {
                NSArray *result = [resultClass objectArrayWithKeyValuesArray:responseObj];
                NSMutableArray *finallyResult = [NSMutableArray array];
                for (NSDictionary *dic in result) {
                    if ([dic isKindOfClass:[NSDictionary class]]||[dic isKindOfClass:[NSArray class]]) {
                        [finallyResult addObject:dic];
                    }
                    else{
                        NSObject *temp = [resultClass objectWithKeyValues:dic];
                        [finallyResult addObject:temp];
                    }
                    
                }
                success(finallyResult);
            }
            else{
                NSLog(@"返回的数据前:%@",responseObj);
                if ([responseObj isKindOfClass:[NSDictionary class]]&&[(NSDictionary *)responseObj count] ==0) {
                    success(nil);
                    return ;
                }
                DXPublicModel *result = [resultClass objectWithKeyValues:responseObj];
                if ([result isKindOfClass:[NSDictionary class]]&&[(NSDictionary *)result count]==0) {
                    success(responseObj);
                    return ;
                }
                
                NSLog(@"返回的数据后:%@",[result keyValues]);
                if ([result isKindOfClass:[DXPublicModel class]]) {
                    if (result.code!=0) {
                        UIWindow *window = [UIApplication sharedApplication].keyWindow;
                        [window makeToast:result.msg];
                        failure(result);
                    }
                    else{
                        success(result);
                    }
                }
                else{
                    success(result);
                }
                
            }
        }
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
        [self restoreRequestWithCode:error request:^{
            [self getWithUrl:url param:param resultClass:resultClass success:success failure:failure];
        }];
        if (failure) {
            failure(error);
        }
    } showProgress:showProgress];
    
}
+ (void)getWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [self getWithUrl:url param:param resultClass:resultClass success:success failure:failure showProgress:YES];
}

+ (void)postWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure showProgress:(BOOL)showProgress{
    if (retry!=0) {
        retry--;
    }
    // 把模型转化为字典
    NSDictionary *params ;
    if ([param isKindOfClass:[NSArray class]]) {
        params = [self keyValuesArrayWithObjectArray:param];
    }
    else{
        params= [param keyValues];
    }
    
    
    
    NSLog(@"请求参数:%@",params);
    [RFHttpTool post:url params:params success:^(id responseObj) {
        NSString *jsonStr = [responseObj JSONString];
        NSLog(@"%@数据处理前：%@",url,jsonStr);
        if (success) {
            
            
            DXPublicModel *result = [resultClass objectWithKeyValues:responseObj];
            NSLog(@"%@数据处理后:%@",url,[PrintObject getObjectData:result]);
            
            
            if (result.code!=0) {
                UIWindow *window = [UIApplication sharedApplication].keyWindow;
                
                // 针对点赞进行处理
                if ([result.msg isEqualToString:@"已存在"]) {
                    //请求成功，但是非正确操作处理
                    failure(result);
                    return ;
                }
                [window makeToast:result.msg];
                
            }
            else{
                success(result);
            }
        }
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
        [self restoreRequestWithCode:error request:^{
            [self postWithUrl:url param:param resultClass:resultClass success:success failure:failure];
        }];
        if (failure) {
            failure(error);
        }
    } showProgress:showProgress];

}
+ (void)postWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [self postWithUrl:url param:param resultClass:resultClass success:success failure:failure showProgress:YES];
}

+ (void)post:(NSString *)url param:(id)param  constructingBldyWithBlock:(void (^)(id<AFMultipartFormData>))construct  resultClass:(Class)resultClass  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    if (retry!=0) {
        retry--;
    }
    // 把模型转化为字典
    NSDictionary *params = [param keyValues];
    [RFHttpTool post:url params:params constructingBldyWithBlock:^(id<AFMultipartFormData> formData) {
        if (construct) {
            construct(formData);
        }
    } success:^(id responseObj) {
        NSString *jsonStr = [responseObj JSONString];
        NSLog(@"%@upload数据处理前：%@",url,jsonStr);
        
        DXPublicModel *result = [resultClass objectWithKeyValues:responseObj];
        
        if (result.code!=0) {
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            [window makeToast:result.msg];
        }
        else{
            success(result);
        }
    } :^(NSError *error) {
        NSLog(@"Error: %@", error);
        [self restoreRequestWithCode:error request:^{
            [self post:url param:param constructingBldyWithBlock:construct resultClass:resultClass success:success failure:failure];
        }];
        failure(error);
    }];
}
+(void)restoreRequestWithCode:(NSError *)error request:(void (^)())request{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    NSDictionary *userInfo =  error.userInfo;
    NSString * localizedDescription= [userInfo valueForKey:@"NSLocalizedDescription"];
    if (localizedDescription!=nil && [localizedDescription rangeOfString:@"405"].location!=NSNotFound) {
        //没有登录
        if (![DXLoginHelp canRestoreState]) {
            LoginViewController *loginViewController = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
//            UINavigationController *navigationController = [NYControllerTools getCurrentVC].navigationController;
//            [navigationController pushViewController:loginViewController animated:YES];
            [NYControllerTools pushViewController:loginViewController];
            [window makeToast:@"请先登录"];
        }
        else{//已登录过
            [DXLoginHelp restoreState:^{
                request();
            } :^{
                
            }];
        }
        
    }
}
/**
 *  拼接请求参数
 */
+(NSString *) queryStrByDict:(NSDictionary *)parms{
    NSMutableString *query = [NSMutableString stringWithString:@""];
    if(parms == nil || [parms count]==0)
        return query;
    
    for (NSString *key in [parms allKeys]) {
        NSString *value;
        NSString *name;
        NSLog(@"key:%@---value:%@",key,parms[key]);
        value = [key URLEncodedString];
        name = [[NSString stringWithFormat:@"%@",parms[key]] URLEncodedString];
        
        [query appendFormat:@"%@=%@&", value, name];
    }
    if (query.length>=1) {
        [query deleteCharactersInRange:NSMakeRange(query.length-1, 1)];
    }
    return query;
}
@end
