//
//  AppDelegate.h
//  DXQ
//
//  Created by rason on 7/21/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DXNavigationController.h"
#import "MainTabBarController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) DXNavigationController *baseNavigationController;
@property (strong, nonatomic) MainTabBarController *mainVc;

@end