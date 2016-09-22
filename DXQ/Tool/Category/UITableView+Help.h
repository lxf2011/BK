//
//  UITableView+Help.h
//  DXQ
//
//  Created by rason on 8/5/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Help)
-(UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier owner:(UIViewController *)owner;
@end
