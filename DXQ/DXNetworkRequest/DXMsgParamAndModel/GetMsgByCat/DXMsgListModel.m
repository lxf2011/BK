//
//  DXMsgListModel.m
//  DXQ
//
//  Created by rason on 8/11/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "DXMsgListModel.h"

@implementation DXMsgListModel

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [DXMsgItemModel class]};
}

@end





