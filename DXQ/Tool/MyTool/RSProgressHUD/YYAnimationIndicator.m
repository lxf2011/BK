//
//  YYAnimationIndicator.m
//  AnimationIndicator
//
//  Created by 王园园 on 14-8-26.
//  Copyright (c) 2014年 王园园. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "YYAnimationIndicator.h"

@implementation YYAnimationIndicator

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, frame.size.width,frame.size.height-10)];
        [self addSubview:imageView];
        //设置动画帧
        self.images = [NSMutableArray array];
        self.currentIndex = -1;
        for (int i=0; i<9; i++) {
            [self.images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"loading_anim0%d.png",i]]];
        }
        imageView.image = self.images[0];
        self.layer.hidden = YES;
    }
    return self;
}


- (void)startAnimation:(NSNumber *)status
{
    if (self.stop==YES) {
        self.stop = NO;
        self.isRuning = NO;
        return; 
    }
    if ([status intValue]==0) {
        self.isRuning = NO;
        return;
    }
    if ([status intValue]==1) {
        if (self.isRuning == YES) {
            return;
        }else{
            self.isRuning = YES;
        }
    }
    
    self.layer.hidden = NO;
    
    self.currentIndex ++;
    self.currentIndex %= 9;
    
    imageView.image = self.images[self.currentIndex];
    
    if (self.currentIndex==0||self.currentIndex==3||self.currentIndex==6) {
        
        [self performSelector:@selector(startAnimation:) withObject:[NSNumber numberWithInt:2] afterDelay:0.2];
    }
    else{
        [self performSelector:@selector(startAnimation:) withObject:[NSNumber numberWithInt:2] afterDelay:0.02];
    }
    
}
- (void)stopAnimation
{
    if (self.layer.hidden == NO) {
        self.layer.hidden = YES;
        self.stop = YES;
    }
    
}

@end
