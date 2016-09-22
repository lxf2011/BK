//
//  UIView+RSStyle.m
//  DXQ
//
//  Created by rason on 8/5/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "UIView+RSStyle.h"

@implementation UIView (RSStyle)
-(void)shashowGrayStyle{
    self.layer.masksToBounds = YES;
    self.clipsToBounds = YES;
    // 圆角
    self.layer.cornerRadius = 10;
    self.layer.borderColor = DXColorSeparator.CGColor;
    self.layer.borderWidth = 1;
    
    // 阴影
    self.layer.shadowColor = DXColorSeparator.CGColor;
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowRadius = 1.0;
    self.layer.shadowOffset = CGSizeMake(2, 2);
}
-(void)shashowGrayDarkStyle{
    
    // 圆角
    self.layer.cornerRadius = 10;
    // 阴影
    self.layer.shadowColor = DXColorGrayLight.CGColor;
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowRadius = 1.0;
    self.layer.shadowOffset = CGSizeMake(3, 3);
}
-(void)roundStyle10{
    self.layer.masksToBounds = YES;
    self.clipsToBounds = YES;
    // 圆角
    self.layer.cornerRadius = 10;
}
-(void)roundCornerStyle{
    [self roundCornerStyleWithRadius:3];
}
-(void)roundCornerStyleWithRadius:(float)radius{
    self.layer.borderWidth = 0;
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}
@end
