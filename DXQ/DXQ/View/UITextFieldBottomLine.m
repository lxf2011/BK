//
//  UITextFieldBottomLine.m
//  DXQ
//
//  Created by rason on 8/2/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "UITextFieldBottomLine.h"

@implementation UITextFieldBottomLine
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor lightGrayColor].CGColor);
    CGContextFillRect(context, CGRectMake(0, CGRectGetHeight(self.frame) - 0.5, CGRectGetWidth(self.frame), 0.5));
}
//控制文本所在的的位置，左右缩 10
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 10 , 0 );
}

//控制编辑文本时所在的位置，左右缩 10

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 10 , 0 );
    
}
@end
