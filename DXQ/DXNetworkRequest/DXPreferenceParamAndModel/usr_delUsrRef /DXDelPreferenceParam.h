//
//  DXDelPreferenceParam.h
//  DXQ
//
//  Created by 做功课 on 15/8/25.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXDelPreferenceParam : NSObject

/*
 LTYPE："USR_MSG_PRAISE",
 LTARGET:"L_MESSAGE",
 LTARID:"1"
 */

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
