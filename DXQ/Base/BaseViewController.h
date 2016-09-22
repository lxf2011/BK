//
//  BaseViewController.h
//  LinkWe
//
//  Created by mac on 1/16/15.
//  Copyright (c) 2015 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Toast+UIView.h"
#import "HYBScrollRenderController.h"
//导航栏高度
# define navigationBarHeight self.navigationController.navigationBar.frame.size.height+20
# define tarbarHeight self.tabBarController.tabBar.frame.size.height

@class AppDelegate;
@interface BaseViewController : HYBScrollRenderController<UIGestureRecognizerDelegate>
-(void)setLeftBarButtonItem:(NSString *)title;
//navigationbar透明变化
-(void)setAlph;
//生成带特定颜色的
-(UIImage *) buttonImageFromColor:(UIColor *)color width:(CGFloat)width height:(CGFloat)height;
-(AppDelegate *)appDelegate;
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
//关闭sideMenu
-(void)closeSideMenu;
- (void)makeToast:(NSString *)message;
- (void)makeToastAtWindow:(NSString *)message;
-(void)deleteSelfFromNavigation;
//发送通知
-(void)postNotificationName:(NSString *)name;

@end
