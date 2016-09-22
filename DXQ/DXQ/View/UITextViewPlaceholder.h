//
//  UITextViewPlaceholder.h
//  DXQ
//
//  Created by 做功课 on 15/8/25.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextViewPlaceholder : UITextView 
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, copy) NSString *placeholderBottom;
@property (nonatomic, strong) UIFont *placeholderBottomFont;
@property (nonatomic, strong) UIColor *placeholderColor;
@end
