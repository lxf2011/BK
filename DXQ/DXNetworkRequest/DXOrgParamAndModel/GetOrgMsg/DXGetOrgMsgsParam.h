//
//  GetOrgMsgsParam.h
//  DXQ
//
//  Created by rason on 8/12/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXGetOrgMsgsParam : NSObject
//资讯类型 msg表示消息 act表示活动
@property (nonatomic, copy) NSString *type;
// 社团id
@property (nonatomic, assign) int lid;

@property (nonatomic, assign) int oid;

@property (nonatomic, assign) int status;
//位移
@property (nonatomic, assign) int offset;
//每页多少条
@property (nonatomic, assign) int limit;
@property (nonatomic, copy) NSString *school;
@end
