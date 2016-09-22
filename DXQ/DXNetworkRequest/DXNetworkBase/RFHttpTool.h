//
//  RFHttpTool.h
//  黑马微博
//
//  Created by RoKingsly on 15/6/4.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSProgressHUD.h"
#import "AFNetworking.h"
@interface RFHttpTool : NSObject
/**
 *  发送一个GET请求
 *
 *  @param url     请求路径url
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
*  @param showProgress 是否显示指示器
 */
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void(^)(id))success failure:(void(^)(NSError *error)) failure;
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure showProgress:(BOOL)showProgress;
/**
 *  发送一个POST请求
 *
 *  @param url     请求路径URL
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 *  @param showProgress 是否显示指示器
 */
+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj)) success failure:(void (^)(NSError *error)) failure;
+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure  showProgress:(BOOL)showProgress;
/**
 *  发送一个POST请求带有文件数据
 *
 *  @param url       请求路径URL
 *  @param params    请求参数
 *  @param construct 上传文件拼接
 *  @param success   请求成功后的回调
 *  @param failure   请求失败后的回调
 */
+ (void)post:(NSString *)url params:(NSDictionary *)params constructingBldyWithBlock:(void(^)(id<AFMultipartFormData> formData))construct success:(void (^)(id responseObj))success :(void (^)(NSError *error)) failure;
@end
