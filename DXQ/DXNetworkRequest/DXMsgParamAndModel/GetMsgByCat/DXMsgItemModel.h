//
//  DXMsgItemModel.h
//  DXQ
//
//  Created by rason on 8/11/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXMsgItemModel : NSObject
//封面，有多个图片时逗号分隔
@property (nonatomic, copy) NSString *L_PIC;

@property (nonatomic, copy) NSString *L_ID;

@property (nonatomic, copy) NSString *L_OID;

//创建者id
@property (nonatomic, copy) NSString *L_UID;
//点赞量
@property (nonatomic, copy) NSString *L_PRAISE;

@property (nonatomic, copy) NSString *L_SUM_PRAISE;

@property (nonatomic, copy) NSString *ADD2;

@property (nonatomic, copy) NSString *L_TIME;
//收藏数
@property (nonatomic, copy) NSString *L_COLLECT;

@property (nonatomic, copy) NSString *L_SUM_COLLECT;

//资讯的html内容
@property (nonatomic, copy) NSString *L_CONTENT;

@property (nonatomic, copy) NSString *ADD1;
//标题
@property (nonatomic, copy) NSString *L_TITLE;

@property (nonatomic, copy) NSString *L_STATUS;
//0是普通资讯，1是社团资讯
@property (nonatomic, copy) NSString *L_TYPE;
//简介
@property (nonatomic, copy) NSString *L_INTRO;
//浏览量
@property (nonatomic, copy) NSString *L_CLICK;

@end
