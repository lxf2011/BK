//
//  UITextViewBottomLine.h
//  DXQ
//
//  Created by 做功课 on 15/8/7.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextViewBottomLine : UITextView
- (CGRect)textRectForBounds:(CGRect)bounds;
- (CGRect)editingRectForBounds:(CGRect)bounds;
@end
