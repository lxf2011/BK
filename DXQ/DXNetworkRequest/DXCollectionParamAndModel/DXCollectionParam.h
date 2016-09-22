//
//  DXCollectionParam.h
//  DXQ
//
//  Created by rason on 8/13/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXCollectionParam : NSObject
@property (nonatomic, copy) NSString *cat;
//位移
@property (nonatomic, assign) int offset;
//每页多少条
@property (nonatomic, assign) int limit;
@end
