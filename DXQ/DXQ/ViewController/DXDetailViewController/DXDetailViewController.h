//
//  InformationDetailViewController.h
//  DXQ
//
//  Created by 做功课 on 15/7/24.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewControllerNormal.h"
@interface DXDetailViewController : BaseViewControllerNormal
@property (strong,nonatomic)id model;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIView *viewBottom;
@property (nonatomic,strong) NSString *urlStr;//如果存在，则先执行
// 标题
@property (nonatomic, copy) NSString *hTitle;
// 网页
@property (nonatomic, copy) NSString *html;
//简介
@property (nonatomic, copy) NSString *L_INTRO;

// 设置最下面的点赞条
- (void)refreshOptionViewWithCollect:(NSString *)collect comment:(NSString *)comment praise:(NSString *)praise  share:(NSString *)share;
- (void)refreshOptionViewWithComment:(NSString *)comment;

// 目标id
@property (nonatomic, copy) NSString *LTARID;
// 评论 类型 L_MESSAGE  L_ACTIVITY  L_SPECIAL L_ORG
@property (nonatomic, copy) NSString *LTARGET;

@end
