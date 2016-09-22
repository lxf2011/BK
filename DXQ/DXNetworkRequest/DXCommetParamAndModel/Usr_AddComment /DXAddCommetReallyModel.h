//
//  DXAddCommetReallyModel.h
//  DXQ
//
//  Created by rason on 8/12/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXAddCommetReallyModel : NSObject
//评论者id
@property (nonatomic, assign) NSInteger LOWNER;

@property (nonatomic, assign) NSInteger LREPLY;
//要回复的评论的id
@property (nonatomic, assign) NSInteger Id;
//0为普通评论，1为回复
@property (nonatomic, assign) NSInteger LTYPE;
//目标类型，如L_MESSAGE，L_ACTIVITY，L_SPECIAL
@property (nonatomic, copy) NSString *LTARGETTYPE;

@property (nonatomic, copy) NSString *ADD1;
//评论内容
@property (nonatomic, copy) NSString *LCONTENT;

@property (nonatomic, copy) NSString *LTIME;
//目标id，可以是资讯id，活动id，评论的id
@property (nonatomic, assign) NSInteger LTARGET;
//点赞量
@property (nonatomic, assign) NSInteger LPRAISE;

@property (nonatomic, assign) NSInteger LSUMPRAISE;

@property (nonatomic, copy) NSString *ADD2;

@end
