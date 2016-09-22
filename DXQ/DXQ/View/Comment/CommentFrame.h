//
//  CommentFrame.h
//  DXQ
//
//  Created by 做功课 on 15/8/17.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Comment.h"

// 用户名字体大小
#define userNameFont [UIFont systemFontOfSize:13]
// 回复用户名字体大小
#define replyUserNameFont [UIFont systemFontOfSize:11]
// 时间字体大小
#define timeFont [UIFont systemFontOfSize:14]
// 内容字体大小
#define contentFont [UIFont systemFontOfSize:14]
// 回复内容字体大小
#define replyContentFont [UIFont systemFontOfSize:12]

// cell的边框宽度
#define cellBorderW 10


@interface CommentFrame : NSObject

@property (nonatomic, strong) Comment *comment;

/** 时间 */
@property (nonatomic, assign) CGRect timeF;
/** 内容 */
@property (nonatomic, assign) CGRect contentF;
/** 用户头像 */
@property (nonatomic, assign) CGRect headIconF;
/** 用户名 */
@property (nonatomic, assign) CGRect userNameF;
/** 背景 */
@property (assign, nonatomic) CGRect viewBackgroundF;

/** 回复背景 */
@property (assign, nonatomic) CGRect viewReplyF;
/** 回复用户头像 */
@property (nonatomic, assign) CGRect replyHeadIconF;
/** 回复用户名 */
@property (nonatomic, assign) CGRect replyUserNameF;
/** 回复内容 */
@property (nonatomic, assign) CGRect replayContentF;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

@end
