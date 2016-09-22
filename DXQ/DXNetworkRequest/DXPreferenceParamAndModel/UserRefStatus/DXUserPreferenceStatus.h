//
//  DXUserPreferenceModel.h
//  DXQ
//
//  Created by 做功课 on 15/8/25.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DXAddPreferenceParam.h"

@interface DXUserPreferenceStatus : NSObject

+ (void)addPraiseStatus:(NSArray *)array;
+ (void)delPraiseStatus:(NSArray *)array;
+ (BOOL)isPraise:(NSArray *)array;
+ (NSUInteger)collectCount;
@end
