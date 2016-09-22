//
//  UITextFieldBottomLine.h
//  DXQ
//
//  Created by rason on 8/2/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextFieldBottomLine : UITextField
- (CGRect)textRectForBounds:(CGRect)bounds;
- (CGRect)editingRectForBounds:(CGRect)bounds;
@end
