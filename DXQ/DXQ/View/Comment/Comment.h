//
//  Comment.h
//  DXQ
//
//  Created by 做功课 on 15/8/17.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DXGetCommetsItemModel.h"
#import "DXAddCommetReallyModel.h"

@interface Comment : NSObject

/** 时间 */
@property (nonatomic, copy) NSString *time;
/** 内容 */
@property (nonatomic, copy) NSString *content;
/** 用户头像 */
@property (nonatomic, copy) NSString *headIcon;
/** 用户名 */
@property (nonatomic, copy) NSString *userName;
/** 点赞数 */
@property (nonatomic, copy) NSString *praise;

/** 回复用户头像 */
@property (nonatomic, copy) NSString *replyHeadIcon;
/** 回复用户名 */
@property (nonatomic, copy) NSString *replyUserName;
/** 回复内容 */
@property (nonatomic, copy) NSString *replayContent;

/** 此条评论的id */
@property (nonatomic, assign) NSInteger Id;

- (void)setModel:(DXGetCommetsItemModel *)model;
- (void)setAddCommnetModel:(DXAddCommetReallyModel *)model;

@end
