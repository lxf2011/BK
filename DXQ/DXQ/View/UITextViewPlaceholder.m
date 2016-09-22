//
//  UITextViewPlaceholder.m
//  DXQ
//
//  Created by 做功课 on 15/8/25.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import "UITextViewPlaceholder.h"

@implementation UITextViewPlaceholder

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)textDidChange{
    [self setNeedsDisplay];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)setAttributedText:(NSAttributedString *)attributedText{
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font{
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text{
    [super setText:text];
    [self setNeedsDisplay];
}

- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = [placeholder copy];
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    
    if (self.hasText)   return;
    
    int x = 5;
    int y = 8;
    int w = self.frame.size.width - 2 * x;
    int h = self.frame.size.height - 2 * y;
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = self.placeholderColor ? self.placeholderColor : [UIColor lightGrayColor];
    ;
    attr[NSFontAttributeName] = self.font;
    [self.placeholder drawInRect:CGRectMake(x, y, w, h) withAttributes:attr];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = self.placeholderColor ? self.placeholderColor : [UIColor lightGrayColor];
    attrs[NSFontAttributeName] = self.placeholderBottomFont ? self.placeholderBottomFont : self.font;
    CGFloat width = [_placeholderBottom boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width;
    CGFloat height = [_placeholderBottom boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.height;
    int x1 = self.frame.size.width - x - width;
    int y1 = self.frame.size.height - y - height;
    [self.placeholderBottom drawInRect:CGRectMake(x1, y1, width, height) withAttributes:attrs];
}

@end
