//
//  DXLoginUserParam.m
//  DXQ
//
//  Created by rason on 8/12/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "DXUserParam.h"

@implementation DXUserParam
+ (DXUserParam *)sharedInstance {
    static DXUserParam *sharedInstance = nil;
    @synchronized(self) {
        if (!sharedInstance) {
            sharedInstance = [[self alloc] init];
        }
    }
    return sharedInstance;
}
@end
