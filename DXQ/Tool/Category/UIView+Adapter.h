//
//  UIView+Adapter.h
//  NanYueTong
//
//  Created by rason on 7/20/15.
//  Copyright (c) 2015 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Adapter)
-(void)setWidth:(float )width;
-(void)adaptWidth;
-(void)adaptHeight;
-(void)adaptY;
-(void)setHeight:(float )height;
-(void)setX:(float )x;
-(void)setY:(float )y;
-(float)originX;
-(float)originY;
-(float)width;
-(float)height;
-(void)setAlignRight:(float)alignRight;
-(void)setAdaptRight:(float)adaptRight;
-(void)setAlignLeft:(float)alignLeft;
-(void)setAdaptLeft:(float)adaptLeft;
-(void)setAlignTop:(float)alignTop;
-(void)setAlignBottom:(float)alignBottom;
-(void)setAlignBottomToSuperView:(float)alignBottom;
-(void)adaptLeft;
-(void)setAlignRightToSuperView:(float)alignRight;
-(void)adapt;
//居中适配
-(void)adaptSubViewsToCenter;
//从左到右百分比适配，间距和宽度等比例放大
-(void)adaptSubViews;
//使宽度与父视图一样
-(void)fillWidth;
#pragma mark 下面是根据其它View进行适配
-(void)alignTopWithView:(UIView *)topView;
-(void)alignTopWithView:(UIView *)topView space:(CGFloat )space;
-(void)inBottomWithView:(UIView *)bottomView space:(CGFloat )space;
@end
