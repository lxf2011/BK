//
//  MainTabBarController.h
//  NanYueTong
//
//  Created by rason on 6/27/15.
//  Copyright (c) 2015 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICSDrawerController.h"
@interface MainTabBarController : UITabBarController<ICSDrawerControllerPresenting,UITabBarControllerDelegate,UIGestureRecognizerDelegate>
@property(nonatomic, weak) ICSDrawerController *drawer;
-(void)hideOrShow;
@end
