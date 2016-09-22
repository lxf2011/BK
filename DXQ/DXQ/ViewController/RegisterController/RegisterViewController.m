//
//  RegisterViewController.m
//  DXQ
//
//  Created by 做功课 on 15/7/22.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterPwdViewController.h"
#import "DXUserParam.h"
#import "RSCheck.h"
#import <SMS_SDK/SMS_SDK.h>

#define oneMinute 60

static int _countDown = oneMinute;

@interface RegisterViewController ()

@property (nonatomic, weak) NSTimer *timer;
- (IBAction)nextBtnClick:(UIButton *)sender;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"注 册";
    self.textFieldIDCode.keyboardType = UIKeyboardTypeNumberPad;
    self.textFieldTelephone.keyboardType = UIKeyboardTypeNumberPad;
    //自定义的适配方法，居中适配
    [self.scrollView adaptSubViewsToCenter];
    
}

- (NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateButton) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (void)updateButton{
    _countDown = (_countDown - 1 + oneMinute) % oneMinute;
    if (_countDown == 0) {
        self.timer.fireDate = [NSDate distantFuture];
        self.buttonGetIDCode.enabled = YES;
    }
    NSString *title = [NSString stringWithFormat:@"获取成功%d", _countDown];
    self.buttonGetIDCode.titleLabel.text = title;
    [self.buttonGetIDCode setTitle:title forState:UIControlStateDisabled];
}

#pragma mark - 按钮点击事件
- (IBAction)nextBtnClick:(UIButton *)sender {
//
//    [DXUserParam sharedInstance].LUSR = self.textFieldTelephone.text;
//    RegisterPwdViewController *registerPwdVc = [[RegisterPwdViewController alloc]init];
//    [self.navigationController pushViewController:registerPwdVc animated:YES];
//    return;
    if (![RSCheck checkPhone:self.textFieldTelephone]) {
        return;
    }
    if (![RSCheck checkIsNilForTextField:self.textFieldIDCode tip:@"验证码"]) {
        return ;
    }
    if (!_isAgree) {
        [[UIApplication sharedApplication].keyWindow makeToast:@"请同意使用协议"];
        return ;
    }
    [SMS_SDK commitVerifyCode:self.textFieldIDCode.text result:^(enum SMS_ResponseState state) {
        if (state == 0) {
            [self makeToast:@"><您输入了错误的验证码。"];
            return ;
        }
        [DXUserParam sharedInstance].LUSR = self.textFieldTelephone.text;
        RegisterPwdViewController *registerPwdVc = [[RegisterPwdViewController alloc]init];
        [self.navigationController pushViewController:registerPwdVc animated:YES];
        self.timer.fireDate = [NSDate distantFuture];

    }];
}
#pragma mark - 获取验证码
- (IBAction)getIDCode:(UIButton *)sender {
    
    if ([RSCheck checkPhone:self.textFieldTelephone]&&self.buttonGetIDCode.enabled) {
        self.buttonGetIDCode.enabled = NO;
        [SMS_SDK getVerificationCodeBySMSWithPhone:self.textFieldTelephone.text zone:@"86" result:^(SMS_SDKError *error) {
            if (!error) {
                [self makeToast:@"获取验证码成功"];
                self.timer.fireDate = [NSDate distantPast];
                
            }else{
                [self makeToast:@"获取验证码失败"];
                self.buttonGetIDCode.enabled = YES;
            }
        }];
    }
}
- (IBAction)agreeProtocol:(id)sender {
    self.isAgree = !self.isAgree;
    if (self.isAgree) {
        self.imageViewSelect.image = [UIImage imageNamed:@"ic_tk1"];
    }
    else{
        self.imageViewSelect.image = [UIImage imageNamed:@"ic_tk0"];
    }
}
@end
