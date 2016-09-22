//
//  NYReturnPublicParam.h
//  nanyuetongiOS
//
//  Created by RoKingsly on 15/6/29.
//  Copyright (c) 2015年 RoKingsly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXPublicModel : NSObject
/**
 *  是否成功,0为获取成功，1为失败
 */
@property (nonatomic, assign) int code;
/**
 *  错误信息
 */
@property (nonatomic, copy) NSString *msg;
+(DXPublicModel *)moni;
+(void)test;
@end
