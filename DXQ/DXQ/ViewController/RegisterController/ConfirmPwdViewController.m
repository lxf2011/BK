//
//  ComfirmPwdViewController.m
//  DXQ
//
//  Created by 做功课 on 15/8/24.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import "ConfirmPwdViewController.h"
#import "RSTextHelper.h"
#import "RSCheck.h"
#import "DXUserParam.h"
#import "WXUtil.h"

@interface ConfirmPwdViewController ()

@end

@implementation ConfirmPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *leftBtn = (UIButton *)self.navigationItem.leftBarButtonItem.customView;
    leftBtn.titleLabel.font = DXNavFont;
    [leftBtn setTitle:@"找回密码" forState:UIControlStateNormal];
    CGFloat width = [RSTextHelper getSizeFromFont:leftBtn.titleLabel.font AndText:leftBtn.currentTitle].width;
    leftBtn.frame = CGRectMake(0, 0, width, 30);
    leftBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];

}

- (void)confirmBtnClick:(UIButton *)sender{
    if (![RSCheck checkPSWWithTextField:self.textFieldPwd comfirmTextfield:self.textFieldConfirm]) {
        return;
    }
    
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = DXColorFindPwd;
    label.width = ScreenWidth;
    label.height = 35;
    label.text = @"密码设置成功！不要再忘记啦(≧ω≦)";
    label.textColor = [UIColor whiteColor];
    label.font = DXNavFont;
    label.y = 64 - label.height;
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    CGFloat duration = 1.0;
    [UIView animateWithDuration:duration animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
       [UIView animateWithDuration:duration delay:duration options:UIViewAnimationOptionCurveLinear animations:^{
           label.transform = CGAffineTransformIdentity;
       } completion:^(BOOL finished) {
           [label removeFromSuperview];
       }];
    }];
    
    [DXUserParam sharedInstance].LPSW = [WXUtil md5:self.textFieldConfirm.text];
}

@end
