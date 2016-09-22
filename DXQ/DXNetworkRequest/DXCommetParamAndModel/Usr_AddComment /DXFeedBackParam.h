//
//  DXFeedBackParam.h
//  DXQ
//
//  Created by rason on 8/29/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXFeedBackParam : NSObject
//固定为FEED_BACK
@property (nonatomic, assign) NSString *LTARGETTYPE;
// 反馈内容
@property (nonatomic, copy) NSString *LCONTENT;
@end
