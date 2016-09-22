//
//  RFBaseTool.h
//  黑马微博
//
//  Created by RoKingsly on 15/6/7.
//  Copyright (c) 2015年 heima. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "PrintObject.h"
#import "RFHttpTool.h"
@interface RFBaseTool : PrintObject
/**
 *  发送一个GET请求
 *
 *  @param url         URL请求地址
 *  @param param       请求参数
 *  @param resultClass 请求结果
 *  @param success     请求成功回调
 *  @param failure     请求失败回调
 */
+ (void)getWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure;
+ (void)getWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure showProgress:(BOOL)showProgress;
/**
 *  发送一个POST请求
 *
 *  @param url         URL请求地址
 *  @param param       请求参数
 *  @param resultClass 请求结果
 *  @param success     请求成功回调
 *  @param failure     请求失败回调
 */
+ (void)postWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure;
+ (void)postWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure showProgress:(BOOL)showProgress;

/**
 *  发送一个POST请求带有文件数据
 *
 *  @param url       请求路径URL
 *  @param params    请求参数
 *  @param construct 上传文件拼接
 *  @param success   请求成功后的回调
 *  @param failure   请求失败后的回调
 */
+ (void)post:(NSString *)url param:(id)param  constructingBldyWithBlock:(void (^)(id<AFMultipartFormData>))construct  resultClass:(Class)resultClass  success:(void (^)(id))success failure:(void (^)(NSError *))failure;
/**
 *  NSDictionary转换为 a=b&c=d&e=f格式
 *
 *  @param parms       请求参数
 */
+(NSString *) queryStrByDict:(NSDictionary *)parms;
@end
