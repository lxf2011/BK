//
//  BaseViewControllerNormal.m
//  DXQ
//
//  Created by rason on 8/11/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "BaseViewControllerNormal.h"

@implementation BaseViewControllerNormal
#pragma mark--controller生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBlueView];
}
-(void)setBlueView{
    blueView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    blueView.backgroundColor = DXColorBlueDark;
    [self.view addSubview:blueView];
}
-(void)hidenBlueView{
    blueView.hidden = YES;
}
-(void)showBlueView{
    blueView.hidden = NO;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 开始时,标记置真
    self.isUserDrag = YES;
    // 记录一下开始滚动的offsetY
    self.startY = scrollView.contentOffset.y;
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    // 结束时,置flag还原
    self.isUserDrag = NO;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 只有用户drag时,才进行响应
    if(self.isUserDrag){
        // 判断一下
        CGFloat newY = scrollView.contentOffset.y;
        if(self.startY - newY >0){
            // 说明向上滚动
            if(!self.isNowUp){
                if (self.hideOrShow) {
                    self.hideOrShow(NO);
                }
                NSLog(@"qsdf显示");
                /*
                 在这里面做显示处理
                 */
                self.isNowUp = YES;
                self.isNowDown = NO;
                return;
            }
        }else if(self.startY - newY<0){
            // 说明向下滚动
            if(!self.isNowDown){
                
                if (self.hideOrShow) {
                    self.hideOrShow(YES);
                }
                NSLog(@"qsdf隐藏");
                /*
                 在这里面做隐藏处理
                 */
                
                self.isNowUp = NO;
                self.isNowDown = YES;
                return;
            }
        }
        self.startY = scrollView.contentOffset.y;
    }
    
}

@end
