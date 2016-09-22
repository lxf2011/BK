//
//  RSProgressHUD.m
//  AnimationIndicator
//
//  Created by rason on 15/12/4.
//  Copyright © 2015年 王园园. All rights reserved.
//

#import "RSProgressHUD.h"

@implementation RSProgressHUD
static RSProgressHUD *sharedInstance = nil;
+ (instancetype)sharedInstance
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        [sharedInstance setUI];
    });
    return sharedInstance;
}
-(void)setUI{
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    _tmView = [[RSTouMingUIView alloc]initWithFrame:window.frame];
    [window addSubview:_tmView];
    
    _indicator = [[YYAnimationIndicator alloc]initWithFrame:CGRectMake(0,0, 140, 140)];
    [_tmView addView:_indicator];
}
+(void)initialize{
    [self sharedInstance];
}
+(void)show
{
    sharedInstance.tmView.hidden = NO;
    [sharedInstance.indicator startAnimation:[NSNumber numberWithInt:1]];  //开始转动
}

+(void)dismiss
{
    [sharedInstance.indicator stopAnimation];//加载失败
    sharedInstance.tmView.hidden = YES;
}
@end
