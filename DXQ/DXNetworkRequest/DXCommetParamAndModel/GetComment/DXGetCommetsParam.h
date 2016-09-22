//
//  DXGetCommetsParam.h
//  DXQ
//
//  Created by rason on 8/12/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXGetCommetsParam : NSObject
//对应资源id
@property (nonatomic, assign) int id;
//L_MESSAGE资讯 L_ACTIVITY活动 L_SPECIAL商品攻略 
@property (nonatomic, copy) NSString *type;
//位移
@property (nonatomic, assign) int offset;
//每页多少条
@property (nonatomic, assign) int limit;
@end
