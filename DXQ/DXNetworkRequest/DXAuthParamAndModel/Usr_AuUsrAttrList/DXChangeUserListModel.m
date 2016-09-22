//
//  DXChangeUserListModel.m
//  DXQ
//
//  Created by rason on 8/23/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "DXChangeUserListModel.h"

@implementation DXChangeUserListModel
+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [DXChangeUserReallyModel class]};
}
@end
