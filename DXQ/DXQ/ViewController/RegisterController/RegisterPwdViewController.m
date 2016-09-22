//
//  RegisterPwdViewController.m
//  DXQ
//
//  Created by 做功课 on 15/7/22.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import "RegisterPwdViewController.h"
#import "RegisterNameViewController.h"
#import "RSCheck.h"
#import "DXUserParam.h"
#import "DXAuthTool.h"
#import "WXUtil.h"
#import "DXLoginHelp.h"
@interface RegisterPwdViewController ()
- (IBAction)nextBtnClick:(UIButton *)sender;
@end

@implementation RegisterPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //自定义的适配方法，居中适配
    [self.scrollView adaptSubViewsToCenter];
    // 标题
    self.navigationItem.title = @"注 册";
}


#pragma mark - 按钮点击事件
- (IBAction)nextBtnClick:(UIButton *)sender {
//    RegisterNameViewController *registerNameVc = [[RegisterNameViewController alloc]init];
//    [self.navigationController pushViewController:registerNameVc animated:YES];
//    return;
    if ([self checkForm]) {
        DXRegisterUserParam *param = [DXRegisterUserParam new];
        param.LPSW = [WXUtil md5:self.textFieldPassword.text];
        param.LUSR = [DXUserParam sharedInstance].LUSR;
        param.LSOCIALTYPE = @"phone";
        [DXAuthTool postRegisterWithParams:param success:^(DXRegisterUserModel *result) {
            [DXUserParam sharedInstance].LPSW = param.LPSW;
            [DXLoginHelp login:^{
                RegisterNameViewController *registerNameVc = [[RegisterNameViewController alloc]init];
                [self.navigationController pushViewController:registerNameVc animated:YES];
            } :^{
                
            }];
        } failure:^(NSError *error) {
            [self makeToast:@"注册失败，请检查当前网络情况"];
        }];
    }
    
}
-(BOOL)checkForm{
   return [RSCheck checkPSWWithTextField:self.textFieldPassword comfirmTextfield:self.textFieldConfiirmPassword];
}
- (IBAction)submitRegister:(id)sender {
    if ([self checkForm]) {
        DXRegisterUserParam *param = [DXRegisterUserParam new];
        param.LPSW = [WXUtil md5:self.textFieldPassword.text];
        param.LUSR = [DXUserParam sharedInstance].LUSR;
        param.LSOCIALTYPE = @"phone";
        
        [DXAuthTool postRegisterWithParams:param success:^(DXRegisterUserModel *result) {
            [DXUserParam sharedInstance].LPSW = param.LPSW;
            [self makeToastAtWindow:@"注册成功"];
            [DXLoginHelp login:^{
                
            } :^{
                
            }];
            [self.navigationController popToRootViewControllerAnimated:YES];
        } failure:^(NSError *error) {
            [self makeToast:@"注册失败，请检查当前网络情况"];
        }];
    }
}


@end
