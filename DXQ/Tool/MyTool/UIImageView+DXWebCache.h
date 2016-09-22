//
//  UIImageView+DXWebCache.h
//  DXQ
//
//  Created by rason on 15/9/19.
//  Copyright © 2015年 rason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (DXWebCache)
- (void)sd_setImageWithURL_dx:(NSString *)urlStr placeholderImage:(UIImage *)placeholder;
@end
