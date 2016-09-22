//
//  GetOrgsParam.h
//  DXQ
//
//  Created by rason on 8/12/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXGetOrgsParam : NSObject
//query=LSCHOOL:广州大学 意思是找广州大学的社团
//不传query就是查所有大学的社团
@property (nonatomic, copy) NSString *query;
//位移
@property (nonatomic, assign) int offset;
//每页多少条
@property (nonatomic, assign) int limit;
@end
