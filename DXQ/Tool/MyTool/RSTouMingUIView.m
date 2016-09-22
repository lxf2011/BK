//
//  RSUIView.m
//  mashangjia
//
//  Created by mac on 14-12-15.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "RSTouMingUIView.h"

@implementation RSTouMingUIView{
    UITapGestureRecognizer* singleRecognizer;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        //最低层
        self.backgroundColor = [UIColor clearColor];
        self.frame = frame;
        //透明的，也是手势的添加View
        _toumingview = [[UIView alloc]init];
        _toumingview.backgroundColor = [UIColor blackColor];
        _toumingview.frame = frame;
        _toumingview.alpha = 0.5;
        _views = [[NSMutableArray alloc]init];
        [self addSubview:_toumingview];
    }
    return self;
}
-(void)addGestureWithTarget:(UIViewController *)controller AndWithSel:(SEL)sel{
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:controller action:sel];
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    [_toumingview addGestureRecognizer:singleRecognizer];

}
-(void)addGesture{
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touMingSingleTap:)];
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    [_toumingview addGestureRecognizer:singleRecognizer];
}
-(void)touMingSingleTap:(UITapGestureRecognizer*)recognizer
{
    
    //    self.navigationController.navigationBar.hidden = NO;
    NSLog(@"SingleTap");
    UIView *view = recognizer.view;
    while (![view isKindOfClass:[RSTouMingUIView class]]) {
        view = [recognizer.view superview];
    }
    [view removeFromSuperview];
    
    //处理单击操作
}
#pragma mark 隐藏
-(void)addGestureToHidden{
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toHiddenTap:)];
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    [_toumingview addGestureRecognizer:singleRecognizer];
}
-(void)toHiddenTap:(UITapGestureRecognizer*)recognizer
{
    
    //    self.navigationController.navigationBar.hidden = NO;
    NSLog(@"SingleTap");
    UIView *view = recognizer.view;
    while (![view isKindOfClass:[RSTouMingUIView class]]) {
        view = [recognizer.view superview];
    }
    view.hidden = YES;

}
#pragma mark 去除
-(void)addGestureToRemove{
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toRemoveTap:)];
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    [_toumingview addGestureRecognizer:singleRecognizer];
}
-(void)toRemoveTap:(UITapGestureRecognizer*)recognizer
{
    
    //    self.navigationController.navigationBar.hidden = NO;
    NSLog(@"SingleTap");
    UIView *view = recognizer.view;
    while (![view isKindOfClass:[RSTouMingUIView class]]) {
        view = [recognizer.view superview];
    }
    [view removeFromSuperview];
}
-(void)addView:(UIView *)view{
    //    _centerView = view;
    [_views addObject:view];
    [self addSubview:view];
    [self updateView];
}

-(void)updateView{
    int viewCount = 0;
    float y = self.frame.size.height;
    for (UIView *view in _views) {
        viewCount++;
        y-=view.frame.size.height;
        
    }
    y = (y-viewCount*10)/2;//第一个VIEW的位置
    //调整位置
    for (int i=0;i<viewCount;i++) {
        UIView *view = _views[i];
        CGRect frame = view.frame;
        frame.origin.y = y;
        frame.origin.x = (self.frame.size.width-view.frame.size.width)/2;
        view.frame = frame;
        y+= frame.size.height+(i+1)*10;
        
    }
    
}
@end
