//
//  TopTarbar.m
//  NanYueTong
//
//  Created by apple on 15/7/2.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "RSTabBar.h"
//Tab高度
#define RSTabBarHeight 40.0
//灰白
#define DXColorWhiteGray [UIColor colorWithString:@"#F0F0F0"]
@implementation RSTabBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithY :(float) y withTabTitleArr :(NSArray *)titleNameArr withClickCallBack
:(clickTarBar)clickCallBack
{
    self = [super init];
    self.frame = CGRectMake(0, y, ScreenWidth, RSTabBarHeight);
    
    self.contentArr = titleNameArr;
    _clickTabBarCallBack = clickCallBack;
    self.backgroundColor = DXColorBlueDark;
    [self setTopTabBar];
    return self;


}
-(void)setTopTabBar
{
    
    float count = _contentArr.count;
    for (int i = 0; i < count; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/count*i, 0, ScreenWidth/count, RSTabBarHeight-1)];
        [button setTitle:_contentArr[i] forState:UIControlStateNormal];
        
        if (i == 0) {
            [button setTitleColor:DXColorWhite forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:14];
        }
        else
        {
            [button setTitleColor:DXColorWhiteGray forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:12];
        }
        // tag 0-100为系统保留，故按钮的tag加上100
        button.tag = i+100;
        [button addTarget:self action:@selector(onClickTobBar:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, RSTabBarHeight-1, ScreenWidth, 1)];
    bottomLine.backgroundColor = DXColorBlueDark;
    _slideView = [[UIView alloc]initWithFrame:CGRectMake(0, RSTabBarHeight-1, ScreenWidth/count, 1)];
    _slideView.backgroundColor = DXColorWhite;
    [self addSubview:bottomLine];
    [self addSubview:_slideView];
   // [self.view addSubview:tarBar];
    
    
}
-(void)onClickTobBar:(id)sender
{
    UIButton *clickBtn = sender;
    UIView *tarbar = clickBtn.superview;
    float count = _contentArr.count;
    
    // tag 0-100为系统保留，故按钮的tag加上100
    UIButton *button = tarbar.subviews[clickBtn.tag-100];
    if(button.titleLabel.text.length==0){
        return;
    }
    
    for (int i = 0; i < count; i++) {
        UIButton *button = tarbar.subviews[i];
        
        // tag 0-100为系统保留，故按钮的tag加上100
        if(i+100 == clickBtn.tag)
        {
            [button setTitleColor:DXColorWhite forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:14];
        }
        else
        {
            [button setTitleColor:DXColorWhiteGray forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:12];
        }
    }
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = _slideView.frame;
        // tag 0-100为系统保留，故按钮的tag加上100
        rect.origin.x = ScreenWidth/count*(clickBtn.tag-100);
        _slideView.frame =rect;
    }];
    int tag = clickBtn.tag-100;
    if(_clickTabBarCallBack)
        _clickTabBarCallBack(tag);
    
}

@end
