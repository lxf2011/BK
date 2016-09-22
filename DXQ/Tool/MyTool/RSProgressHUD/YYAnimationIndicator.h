//
//  YYAnimationIndicator.h
//  AnimationIndicator
//
//  Created by 王园园 on 14-8-26.
//  Copyright (c) 2014年 王园园. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import <UIKit/UIKit.h>

@interface YYAnimationIndicator : UIView

{
    UIImageView *imageView;
    UILabel *Infolabel;
}
@property (nonatomic, assign) BOOL isRuning;//1.运行中  0.是停止
@property (nonatomic, assign) BOOL stop;
@property (nonatomic, assign) int currentIndex;
@property (nonatomic, strong) NSMutableArray *images;


- (void)startAnimation:(NSNumber *)status;
- (void)stopAnimation;


@end
