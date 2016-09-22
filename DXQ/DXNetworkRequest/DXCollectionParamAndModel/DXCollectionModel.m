//
//  DXCollectionModel.m
//  DXQ
//
//  Created by rason on 8/16/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "DXCollectionModel.h"

@implementation DXCollectionModel


+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [DXCollectionItemModel class]};
}
@end


