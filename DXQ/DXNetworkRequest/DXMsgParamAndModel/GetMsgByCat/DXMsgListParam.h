//
//  DXMsgListParam.h
//  DXQ
//
//  Created by rason on 8/11/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface DXMsgListParam : NSObject
/*
 *offset：0，limit：10     就是取1到10条数据
 */

//资讯标签类型，如：美食，娱乐
@property (nonatomic, copy) NSString *cat;
//资讯名称
@property (nonatomic, copy) NSString *search;
//资讯列表位移
@property (nonatomic, assign) int offset;
//每页多少条资讯
@property (nonatomic, assign) int limit;

@property (nonatomic, copy) NSString *order;

@end
