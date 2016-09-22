//
//  RSUIView.h
//  mashangjia
//
//  Created by mac on 14-12-15.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSTouMingUIView : UIView
@property (nonatomic,strong)UIView *toumingview;
-(void)addGestureWithTarget:(UIViewController *)controller AndWithSel:(SEL)sel;
-(void)addGesture;//点击灰色透明部分就删除。
-(void)addGestureToHidden;//点击灰色透明部分就隐藏
-(void)addGestureToRemove;//点击灰色透明部分就remove
-(void)addView:(UIView *)view;
@property (strong,nonatomic)NSMutableArray *views;
-(void)updateView;
@end
