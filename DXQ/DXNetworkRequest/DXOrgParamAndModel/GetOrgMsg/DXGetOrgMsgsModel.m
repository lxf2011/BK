//
//  GetOrgMsgsModel.m
//  DXQ
//
//  Created by rason on 8/12/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "DXGetOrgMsgsModel.h"

@implementation DXGetOrgMsgsModel


+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [DXGetOrgMsgsItemModel class]};
}
@end


