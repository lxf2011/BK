//
//  ComfirmPwdViewController.m
//  DXQ
//
//  Created by 做功课 on 15/8/24.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import "ConfirmPwdViewController.h"
#import "RSCheck.h"
#import "DXUserParam.h"
#import "WXUtil.h"
#import "DXAuthTool.h"
@interface ConfirmPwdViewController ()

@end

@implementation ConfirmPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBarButtonItem:@"找回密码"];
    
    [self.scrollView adaptSubViewsToCenter];
    
    self.textFieldPwd.keyboardType = UIKeyboardTypeNamePhonePad;
    self.textFieldConfirm.keyboardType = UIKeyboardTypeNamePhonePad;
}

- (void)confirmBtnClick:(UIButton *)sender{
    if (![RSCheck checkPSWWithTextField:self.textFieldPwd comfirmTextfield:self.textFieldConfirm]) {
        return;
    }
    [DXEditPswParam sharedInstance].LPSW = [WXUtil md5:self.textFieldPwd.text];
    [DXAuthTool postEditPswithParams:[DXEditPswParam sharedInstance] success:^(DXEditPswModel *result) {
        UILabel *label = [[UILabel alloc]init];
        label.backgroundColor = DXColorFindPwd;
        label.width = ScreenWidth;
        label.height = 35;
        label.text = @" 密码设置成功！不要再忘记啦(≧ω≦)";
        label.textColor = [UIColor whiteColor];
        label.font = DXNavFont;
        label.contentMode = UIViewContentModeCenter;
        label.y = 64 - label.height;
        [self.view insertSubview:label atIndex:1];
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
        
    } failure:^(NSError *error) {
        
    }];
    
    
}

@end
