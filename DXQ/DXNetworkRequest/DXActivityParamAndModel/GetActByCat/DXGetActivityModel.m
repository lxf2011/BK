//
//  DXGetActivityModel.m
//  DXQ
//
//  Created by rason on 8/12/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "DXGetActivityModel.h"

@implementation DXGetActivityModel


+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [DXGetActivityItemModel class]};
}
@end



