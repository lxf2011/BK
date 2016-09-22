//
//  RSProgressHUD.h
//  AnimationIndicator
//
//  Created by rason on 15/12/4.
//  Copyright © 2015年 王园园. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYAnimationIndicator.h"
#import "RSTouMingUIView.h"
@interface RSProgressHUD : NSObject
@property (strong, nonatomic)  YYAnimationIndicator *indicator;
@property (strong, nonatomic)  RSTouMingUIView * tmView;
+(void)show;
+(void)dismiss;
@end
