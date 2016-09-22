//
//  RegisterFindPwdViewController.m
//  DXQ
//
//  Created by 做功课 on 15/8/24.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import "FindPwdViewController.h"
#import <SMS_SDK/SMS_SDK.h>
#import "ConfirmPwdViewController.h"
#import "RSCheck.h"
#import "DXEditPswParam.h"
#define oneMinute 60
static int _countDown = oneMinute;

@interface FindPwdViewController ()
@property (nonatomic, weak) NSTimer *timer;
@end

@implementation FindPwdViewController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBarButtonItem:@"找回密码"];
    
    [self.scrollView adaptSubViewsToCenter];
    
    self.textFieldIDCode.keyboardType = UIKeyboardTypeNumberPad;
    self.textFieldTelephone.keyboardType = UIKeyboardTypeNumberPad;
}

- (void)getIDCode:(UIButton *)sender{
    
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

- (IBAction)nextBtnClick:(UIButton *)sender {
    if (![RSCheck checkPhone:_textFieldTelephone]) {
        return;
    }
    if (![RSCheck checkIsNilForTextField:self.textFieldIDCode tip:@"验证码"]) {
        return ;
    }
    [SMS_SDK commitVerifyCode:self.textFieldIDCode.text result:^(enum SMS_ResponseState state) {
        if (state == 0) {
            [self makeToast:@"><您输入了错误的验证码。"];
            return ;
        }
        [DXEditPswParam sharedInstance].LUSR = self.textFieldTelephone.text;
        ConfirmPwdViewController *confirmPwdViewController = [[ConfirmPwdViewController alloc]init];
        [self.navigationController pushViewController:confirmPwdViewController animated:YES];
        self.timer.fireDate = [NSDate distantFuture];
        
    }];
}
@end
