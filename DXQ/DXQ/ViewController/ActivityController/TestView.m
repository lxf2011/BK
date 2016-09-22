//
//  TestView.m
//  DXQ
//
//  Created by rason on 15/11/1.
//  Copyright © 2015年 rason. All rights reserved.
//

#import "TestView.h"

@implementation TestView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
//    UIView *view = [self nextResponder];
//    UIView *desView;
//    for (UIView *subView in view.subviews) {
//        if ([subView isKindOfClass:[UIScrollView class]]) {
//            desView = subView;
//        }
//    }
//    //if(!self.dragging)
//        [desView touchesBegan:touches withEvent:event];
////    [[self nextResponder] touchesBegan:touches withEvent:event];
    [self.tableViews touchesBegan:touches withEvent:event];
    [super touchesBegan:touches withEvent:event];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //if(!self.dragging)
    [self.tableViews touchesMoved:touches withEvent:event];
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.tableViews touchesEnded:touches withEvent:event];
    [super touchesBegan:touches withEvent:event];
}
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{

    return NO;
}
//-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    return self.tableViews;
//}
//-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
//    return NO;
//}
@end
