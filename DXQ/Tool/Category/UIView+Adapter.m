//
//  UIView+Adapter.m
//  NanYueTong
//
//  Created by rason on 7/20/15.
//  Copyright (c) 2015 mac. All rights reserved.
//

#import "UIView+Adapter.h"

@implementation UIView (Adapter)
-(void)setWidth:(float )width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
-(void)adaptWidth{
    CGRect frame = self.frame;
    frame.size.width *=ScreenRatio;
    self.frame = frame;
}
-(void)adaptHeight{
    CGRect frame = self.frame;
    frame.size.height *=ScreenRatio;
    self.frame = frame;
}
-(void)adaptY{
    CGRect frame = self.frame;
    frame.origin.y *= ScreenRatio;
    self.frame = frame;
}
-(void)setHeight:(float )height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
-(void)setX:(float )x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
-(void)setY:(float )y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
-(float)originX{
    return self.frame.origin.x;
}
-(float)originY{
    return self.frame.origin.y;
}
-(float)width{
    return self.frame.size.width;
}
-(float)height{
    return self.frame.size.height;
}
-(void)setAlignRight:(float)alignRight{
    [self setX:ScreenWidth-self.width-alignRight];
}
-(void)setAdaptRight:(float)adaptRight{
    [self adaptWidth];
    [self setAlignRight:adaptRight];
}
-(void)setAlignLeft:(float)alignLeft{
    [self setX:alignLeft];
}
-(void)setAdaptLeft:(float)adaptLeft{
    [self adaptWidth];
    [self setAlignLeft:adaptLeft];
}
-(void)setAlignTop:(float)alignTop{
    [self setY:alignTop];
}
-(void)setAlignBottom:(float)alignBottom{
    [self setY:(ScreenHeight- self.height-alignBottom)];
}
-(void)setAlignBottomToSuperView:(float)alignBottom{
    UIView *superView = [self superview];
    [self setY:superView.height-self.height-alignBottom];
}
-(void)setAlignLeftToSuperView:(float)alignLeft{
    [self setX:alignLeft];
}

-(void)setAlignRightToSuperView:(float)alignRight{
    UIView *superView = [self superview];
    [self setX:superView.width-self.width-alignRight];
}
-(void)adaptLeft{
    [self setAlignLeftToSuperView:self.originX];
    [self adaptWidth];
}
-(void)adapt{
    [self setAlignLeftToSuperView:self.originX*ScreenRatio];
    [self adaptWidth];
}
-(void)adaptSubViewsToCenter{
    for (UIView *subView in [self subviews]) {
        
        CGPoint center = subView.center;
        center.x += self.frame.size.width*(ScreenRatio-1)/2;
        subView.center = center;
    }
}
-(void)adaptSubViews{
    [self adapt];
    for (UIView *subView in [self subviews]) {
//        [subView setAlignLeftToSuperView:subView.originX*ScreenRatio];
//        [subView adaptWidth];
        [subView adaptSubViews];
    }
}
-(void)fillWidth{
    [self setAlignLeftToSuperView:0];
    [self setWidth:ScreenWidth];
}
#pragma mark 下面是根据其它View进行适配
-(void)alignTopWithView:(UIView *)topView{
    [self setY:topView.height+topView.originY];
}
-(void)alignTopWithView:(UIView *)topView space:(CGFloat )space{
    [self setY:topView.height+topView.originY+space];
}
-(void)inBottomWithView:(UIView *)bottomView space:(CGFloat )space{
    [self setY:bottomView.height+bottomView.originY-self.height-space];
}
@end
