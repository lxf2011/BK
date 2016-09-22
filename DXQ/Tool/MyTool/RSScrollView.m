//
//  RSScrollView.m
//  DXQ
//
//  Created by rason on 15/10/24.
//  Copyright © 2015年 rason. All rights reserved.
//

#import "RSScrollView.h"
@interface RSScrollView ()<UIScrollViewDelegate>{
    NSArray *array;
}

@end
@implementation RSScrollView
//引导页的UI创建
-(void)initUI:(NSArray *)views{
    self.bounces = NO;
    self.pagingEnabled = YES;
    NSLog(@"%@",NSStringFromCGPoint(self.contentOffset));
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    UITapGestureRecognizer *tapGR=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchDown)];
    int count = views.count;
    for (int i = 0; i <count; i++) {
        UIView *view = views[i];
        view.frame = CGRectMake(i*width, 0, width, height);
        
        [self addSubview:view];
    }
    self.showsHorizontalScrollIndicator = NO;
    self.contentSize = CGSizeMake(count*width, height);
    self.pagingEnabled = YES;
    
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    
    //    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    //    UINavigationController *navigationController = delegate.baseNavigationController;
    //    NSParameterAssert([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]);
    CGPoint velocity = [(UIPanGestureRecognizer *)gestureRecognizer velocityInView:self];
    CGPoint location = [gestureRecognizer locationInView:self];
    
    NSLog(@"velocity.x:%f----location.x:%d----location.x:%d",velocity.x,(int)location.x%(int)[UIScreen mainScreen].bounds.size.width,(int)location.x);
    if (velocity.x > 0.0f&&(int)location.x%(int)[UIScreen mainScreen].bounds.size.width<50&&velocity.y>-220.0f && velocity.y<220.0f) {
        return NO;
    }
    return YES;
}
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"touchesBegan - touch count = %lu", (unsigned long)[touches count]);
//    
//}
//-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"touchesBegan - touch count = %lu", (unsigned long)[touches count]);
//}
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    //    // 当touch point是在_btn上，则hitTest返回_btn
//    //    CGPoint btnPointInA = [_btn convertPoint:point fromView:self];
//    //    if ([_btn pointInside:btnPointInA withEvent:event]) {
//    //        return _btn;
//    //    }
//    NSLog(@"touchesEnded - touch count = %d", [event.allTouches count]);
//    for(UITouch *touch in event.allTouches) {
//        [self logTouchInfo:touch];
//    }
//    
//    NSLog(@"死定了空间%f-----%f-----%@",point.x,point.y,event);
//    if (((int)point.x)%(int)ScreenWidth<=30) {
//        return nil;
//    }
//    else{
//        return [super hitTest:point withEvent:event];
//    }
//    
//    
//    // 否则，返回默认处理
//    //    return [super hitTest:point withEvent:event];
//    
//}

- (void)logTouchInfo:(UITouch *)touch {
    CGPoint locInSelf = [touch locationInView:self];
    CGPoint locInWin = [touch locationInView:nil];
    NSLog(@"    touch.locationInView = {%2.3f, %2.3f}", locInSelf.x, locInSelf.y);
    NSLog(@"    touch.locationInWin = {%2.3f, %2.3f}", locInWin.x, locInWin.y);
    NSLog(@"    touch.phase = %d", touch.phase);
    NSLog(@"    touch.tapCount = %d", touch.tapCount);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
