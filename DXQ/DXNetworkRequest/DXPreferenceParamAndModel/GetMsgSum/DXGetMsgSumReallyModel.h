//
//  DXGetMsgSumReallyModel.h
//  DXQ
//
//  Created by rason on 8/13/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DXGetMsgSumReallyModel : NSObject
//L_COLLECT 收藏数
//L_COMMENT_SUM 评论数
//L_PRAISE 点赞数
@property (nonatomic, copy) NSString *L_COLLECT;

@property (nonatomic, copy) NSString *L_PRAISE;

@property (nonatomic, copy) NSString *L_COMMENT_SUM;

@property (nonatomic, copy) NSString *L_SHARE;

@end
