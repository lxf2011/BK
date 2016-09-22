//
//  DXLoginUserReallyModel.m
//  DXQ
//
//  Created by rason on 8/12/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "DXLoginUserReallyModel.h"

@implementation DXLoginUserReallyModel

+ (NSDictionary *)objectClassInArray{
    return @{@"ATTR" : [DXLoginUserDetailModel class]};
}

@end
