//
//  DXAddPreferenceParam.h
//  DXQ
//
//  Created by rason on 8/13/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXAddPreferenceParam : NSObject
//L_MESSAGE  L_ACTIVITY  L_SPECIAL L_ORG
@property (nonatomic, copy) NSString *LTARGET;
//目标id
@property (nonatomic, assign) int LTARID;
//USR_ORG_COLLECT:人对社团的收藏
//USR_MSG_VIEW：人对资讯的浏览
//USR_MSG_PRAISE：人对资讯的点赞
//USR_MSG_COLLECT：人对资讯的收藏
//USR_ACT_VIEW：人对活动的浏览
//USR_ACT_PRAISE：人对活动的点赞
//USR_ACT_COLLECT：人对活动的收藏
//USR_SPC_VIEW：人对专题的浏览
//USR_SPC_PRAISE：人对专题的点赞
//USR_SPC_COLLECT：人对专题的收藏
@property (nonatomic, copy) NSString *LTYPE;

@end
