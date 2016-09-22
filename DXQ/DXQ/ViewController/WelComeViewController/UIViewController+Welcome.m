//
//  UIViewController+Welcome.m
//  DXQ
//
//  Created by rason on 9/3/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "UIViewController+Welcome.h"
#import "WelComeViewController.h"
@implementation UIViewController (Welcome)
-(UIViewController *)welcome{
    NSUserDefaults * setting = [NSUserDefaults standardUserDefaults];
    NSString * key = [NSString stringWithFormat:@"isNotFirst"];
    if ([setting valueForKey:key]) {
        return self;
    }
    else{
        WelComeViewController *viewController = [[WelComeViewController alloc]init];
        viewController.viewController = self;
        return viewController;
    }
    
}
@end
