//
//  AppDelegate.m
//  DXQ
//
//  Created by rason on 7/21/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "AppDelegate.h"
#import "IQKeyboardManager.h"
#import "BaseNavigationController.h"
#import "MainTabBarController.h"
#import "LoginViewController.h"
#import "ICSDrawerController.h"
#import "LeftViewController.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaHandler.h"
#import "UMSocialQQHandler.h"
#import "DXPublicModel.h"
#import <SMS_SDK/SMS_SDK.h>
#import "DXLoginHelp.h"
#import "RSCheck.h"
#import "UIViewController+Welcome.h"
#import "UMSocialConfig.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [SMS_SDK registerApp:ShareSDKAPPkey withSecret:ShareSDKAPPSecret];
    [SMS_SDK enableAppContactFriends:NO];
    
   [UMSocialData setAppKey:UMAPPKey];
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:WXAPPKey appSecret:WXAPPSecret url:@"http://www.umeng.com/social"];
//    [UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f" appSecret:@"db426a9829e4b49a0dcac7b4162da6b6" url:@"http://www.umeng.com/social"];

    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。若在新浪后台设置我们的回调地址，“http://sns.whalecloud.com/sina2/callback”，这里可以传nil
    [UMSocialSinaHandler openSSOWithRedirectURL:nil];
    //设置分享到QQ/Qzone的应用Id，和分享url 链接
    [UMSocialQQHandler setQQWithAppId:QQAPPKey appKey:QQAPPSecret url:@"http://www.umeng.com/social"];
    
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline]];
    
    
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    //键盘处理
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = NO;
    manager.enableAutoToolbar = NO;

    self.mainVc = [[MainTabBarController alloc]initWithNibName:@"MainTabBarController" bundle:nil];
    self.baseNavigationController = [[DXNavigationController alloc]initWithRootViewController:self.mainVc];

    LeftViewController *leftViewController = [[LeftViewController alloc]initWithNibName:@"LeftViewController" bundle:nil];
    
    ICSDrawerController *mainController =[[ICSDrawerController alloc] initWithLeftViewController:leftViewController centerViewController:self.baseNavigationController];
    self.mainVc.drawer = mainController;
        
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    self.dXTouMingNavigationController = [[DXTouMingNavigationController alloc]initWithRootViewController:mainController];
    self.window.rootViewController = [[[DXNavigationController alloc]initWithRootViewController:mainController]welcome];
    [self.window makeKeyAndVisible];

// 存储当前版本号
    NSString *key = @"CFBundleShortVersionString";
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (lastVersion == nil) {
        NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
//    [self.baseNavigationController addObserver:self forKeyPath:@"viewControllers" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld|NSKeyValueObservingOptionInitial context:NULL];
    
    
    
    
    return YES;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if([keyPath isEqualToString:@"viewControllers"])
    {
        if (self.baseNavigationController.viewControllers.count==1) {
            self.baseNavigationController.navigationBar.userInteractionEnabled = NO;
        }
        else{
            self.baseNavigationController.navigationBar.userInteractionEnabled = YES;
        }
    }
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}
@end
