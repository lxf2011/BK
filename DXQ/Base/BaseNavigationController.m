//
//  LWNavigationController.m
//  LinkWe
//
//  Created by mac on 15-5-7.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "BaseNavigationController.h"
#import "AppDelegate.h"
#import "ImageButton.h"
@implementation BaseNavigationController



#pragma mark-- controller 生命周期
- (void)viewDidLoad

{
    [super viewDidLoad];
    
    [self setNavigationBar];
}
#pragma mark--设置导航栏
-(void)setNavigationBar
{
    
    
    //设置整体navigationbar的颜色
    self.navigationBar.barTintColor  = DXColorBlueDark;
    self.navigationBar.translucent = YES;
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    
    //将title设置成白色
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    
    // 返回按钮
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    backBtn.backgroundColor = [UIColor redColor];
    [backBtn setImage:[UIImage imageNamed:@"login_back-38" ] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
//    //设置返回按钮的内容
//    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
//    [self.navigationItem setBackBarButtonItem:item];
}
#pragma mark - 按钮点击事件
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
