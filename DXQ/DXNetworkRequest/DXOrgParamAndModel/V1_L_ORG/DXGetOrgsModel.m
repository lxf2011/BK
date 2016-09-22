//
//  GetOrgsModel.m
//  DXQ
//
//  Created by rason on 8/12/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "DXGetOrgsModel.h"

@implementation DXGetOrgsModel

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [DxGetOrgsItemModel class]};
}
@end


