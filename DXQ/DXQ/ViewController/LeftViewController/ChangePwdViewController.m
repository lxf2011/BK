//
//  ChangePwdViewController.m
//  DXQ
//
//  Created by rason on 15/12/1.
//  Copyright © 2015年 rason. All rights reserved.
//

#import "ChangePwdViewController.h"
#import "DXAuthTool.h"
#import "WXUtil.h"
#import "DXLoginHelp.h"
#import "DXUserParam.h"
@interface ChangePwdViewController ()

@end

@implementation ChangePwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftBarButtonItem:@"找回密码"];
    
    [self.scrollView adaptSubViewsToCenter];
    
    self.textFieldPwd.keyboardType = UIKeyboardTypeNamePhonePad;
    self.textFieldConfirm.keyboardType = UIKeyboardTypeNamePhonePad;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)confirmBtnClick:(UIButton *)sender{
    if (![[WXUtil md5:self.textFieldPwdOld.text] isEqualToString:[DXLoginHelp sharedInstance].passWord]) {
        [self.view makeToast:@"请输入正确的密码"];
        return;
    }
    if (![RSCheck checkPSWWithTextField:self.textFieldPwd comfirmTextfield:self.textFieldConfirm]) {
        return;
    }
    DXSetPswParam *param = [DXSetPswParam new];
    param.usr = [DXLoginHelp sharedInstance].phone;
    param.oldPsw = [WXUtil md5:self.textFieldPwdOld.text];
    param.newPsw = [WXUtil md5:self.textFieldPwd.text];
    
    [DXAuthTool getSetPswithParams:param success:^(DXEditPswModel *result) {
        
        [DXUserParam sharedInstance].LPSW = param.newPsw;
        [DXLoginHelp login:^{
            [[UIApplication sharedApplication].keyWindow makeToast:@"密码设置成功!"];
            [self.navigationController popViewControllerAnimated:YES];
        } :^{
            
        }];
        
    } failure:^(NSError *error) {
        
    }];
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
