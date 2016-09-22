//
//  DXMsgAvtListSecondModel.m
//  DXQ
//
//  Created by rason on 8/11/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "DXMsgAvtListSecondModel.h"

@implementation DXMsgAvtListSecondModel

+ (NSDictionary *)objectClassInArray{
    return @{@"msg" : [DXMsgAvtItemModel class]};
}

@end
