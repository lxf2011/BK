//
//  RFHttpTool.m
//  黑马微博
//
//  Created by RoKingsly on 15/6/4.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import "RFHttpTool.h"


@implementation RFHttpTool
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure showProgress:(BOOL)showProgress{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    mgr.requestSerializer =     [AFJSONRequestSerializer serializer];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    //    MBProgressHUD *hud =  [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:YES];
    //     //loading
    //    hud.labelText = @"加载中";
    //    [hud show:YES];
    if (showProgress) {
        [RSProgressHUD show];
    }
    
    // 2.发送GET请求
    DXLog(@"%@", url);
    [mgr GET:url parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObj) {
         if (success) {
             //             [hud hide:YES];
             if (showProgress) {
                 [RSProgressHUD dismiss];
             }
             
             success(responseObj);
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         //         [hud hide:YES];
         if (showProgress) {
             [RSProgressHUD dismiss];
         }
         if (failure) {
             failure(error);
         }
     }];

}
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [self get:url params:params success:success failure:failure showProgress:YES];
}
+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure  showProgress:(BOOL)showProgress{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    //loading
    //    MBProgressHUD *hud =  [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:YES];
    //    hud.labelText = @"加载中";
    //    [hud show:YES];
    if (showProgress) {
        [RSProgressHUD show];
    }
    
    // 2.发送Post请求
    [mgr POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            //            [hud hide:YES];
            if (showProgress) {
                [RSProgressHUD dismiss];
            }
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure){
            //            [hud hide:YES];
            if (showProgress) {
                [RSProgressHUD dismiss];
            }
            failure(error);
        }
    }];

    
}
+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [self post:url params:params success:success failure:failure showProgress:YES];
}

+ (void)post:(NSString *)url params:(NSDictionary *)params constructingBldyWithBlock:(void (^)(id<AFMultipartFormData>))construct success:(void (^)(id))success :(void (^)(NSError *))failure{
    // 1. 获得请求管理器
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
//    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
//    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    //loading
    //    MBProgressHUD *hud =  [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:YES];
    //    hud.labelText = @"加载中";
    //    [hud show:YES];
    
    [RSProgressHUD show];
    // 2.封装参数
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if (construct) {
            construct(formData);
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //          [hud hide:YES];
        [RSProgressHUD dismiss];
        if (success){
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //          [hud hide:YES];
        [RSProgressHUD dismiss];
        if (failure){
            failure(error);
        }
    }];
}
@end
