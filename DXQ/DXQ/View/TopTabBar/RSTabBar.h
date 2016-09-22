//
//  TopTarbar.h
//  NanYueTong
//
//  Created by apple on 15/7/2.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^clickTarBar)(int tag);
@interface RSTabBar  : UIView
@property (strong,nonatomic) UIView *slideView;
@property (strong,nonatomic) NSArray *contentArr;
@property (nonatomic,copy) clickTarBar clickTabBarCallBack;

//初始化方法
-(instancetype)initWithY :(float) y withTabTitleArr :(NSArray *)titleNameArr withClickCallBack
                         :(clickTarBar)clickCallBack;
@end