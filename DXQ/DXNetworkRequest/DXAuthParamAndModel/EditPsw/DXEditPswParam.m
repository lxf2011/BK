//
//  DXEditPswParam.m
//  DXQ
//
//  Created by rason on 9/2/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "DXEditPswParam.h"

@implementation DXEditPswParam
+ (DXEditPswParam *)sharedInstance {
    static DXEditPswParam *sharedInstance = nil;
    @synchronized(self) {
        if (!sharedInstance) {
            sharedInstance = [[self alloc] init];
        }
    }
    return sharedInstance;
}
@end
