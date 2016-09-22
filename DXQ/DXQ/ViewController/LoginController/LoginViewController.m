//
//  LoginViewController.m
//  DXQ
//
//  Created by rason on 7/21/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "UMSocial.h"
#import "DXUserParam.h"
#import "DXNavigationController.h"
#import "MainTabBarController.h"
#import "LeftViewController.h"
#import "WXUtil.h"
#import "DXAuthTool.h"
#import "DXLoginHelp.h"
#import "FindPwdViewController.h"
#import "PrintObject.h"
#import "DXAuthTool.h"
@interface LoginViewController ()<WXApiDelegate>
- (IBAction)registerBtnClick:(UIButton *)sender;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"布可";
    self.textFieldTelephone.keyboardType = UIKeyboardTypeNumberPad;
    self.textFieldPassWord.keyboardType = UIKeyboardTypeNamePhonePad;
//    [self setAlph];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)registerBtnClick:(UIButton *)sender {
    RegisterViewController *registerVc = [[RegisterViewController alloc]initWithNibName:@"RegisterViewController" bundle:nil];
    [self.navigationController pushViewController:registerVc animated:YES];
}

- (IBAction)forgetPassword:(UIButton *)sender {
    FindPwdViewController *findPwdVc = [[FindPwdViewController alloc]init];
    [self.navigationController pushViewController:findPwdVc animated:YES];
}

- (IBAction)login:(UIButton *)sender {
    if ([RSCheck checkIsNilForTextField:self.textFieldTelephone tip:@"用户名"]&&[RSCheck checkIsNilForTextField:self.textFieldPassWord tip:@"密码"]) {
            [DXUserParam sharedInstance].LUSR = @"lxf2200";
            [DXUserParam sharedInstance].LPSW = @"lxf2200";
            [DXLoginHelp login:^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            } :^{
                [self.navigationController popToRootViewControllerAnimated:YES];
                [self makeToast:@"登录失败"];
            }];
    }
    
    
}
- (IBAction)loginByWX:(UIButton *)sender {
    [self loginWithName:UMShareToWechatSession];
}
-(void)loginWithName:(NSString *)name{
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:name];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:name];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            DXThreeUserParam *param = [DXThreeUserParam new];
            param.LUSR = snsAccount.userName;
            param.LPSW = [WXUtil md5:@"123456"];//默认
            
            //得到的数据在回调Block对象形参respone的data属性
            [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToWechatSession  completion:^(UMSocialResponseEntity *response){
                NSLog(@"SnsInformation is %@",response.data);
            }];
            
            [DXAuthTool postThreeLoginWithParams:param success:^(DXThreeUserModel *result) {
                
                //获取用户属性
                [DXLoginHelp sharedInstance].nickName = param.LUSR;
                //                [DXLoginHelp sharedInstance].head = snsAccount.iconURL;
                
                DXThreeUserReallyModel *model = result.data;
                [DXUserParam sharedInstance].LUSR = model.LUSR;
                [DXUserParam sharedInstance].LPSW = model.LPSW;
                [DXLoginHelp login:^{
                    DXChangeUserParam *param = [[DXChangeUserParam alloc]init];
                    param.LID = [NSString stringWithFormat:@"%ld",(long)[DXLoginHelp sharedInstance].loginUser.Id];
                    param.LKEY = @"head";//代表修改的是昵称
                    param.LSVALUE = snsAccount.iconURL;
                    param.LOTYPE = @"L_USR";//代表修改的是用户属性
                    param.LTYPE = @"S";//代表字符串
                    [DXAuthTool postChangeUserWithParams:param success:^(DXChangeUserModel *result) {
                        [DXLoginHelp sharedInstance].head = param.LSVALUE;
                        [self postNotificationName:kNotificationModifyPersonIfno];
                    } failure:^(NSError *error) {
                        [self makeToastAtWindow:@"头像设置失败，请检查当前网络情况"];
                    }];
                    
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    // 发送通知，改变点赞等按钮的状态
                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationPreferenceStatusChange object:nil];
                } :^{
                    [self makeToast:@"登录失败"];
                }];
                
                
                
            } failure:^(NSError *error) {
                
            }];
            
        }
    });
    
}
- (IBAction)lognByWB:(UIButton *)sender {
    [self loginWithName:UMShareToSina];
}

- (IBAction)lognByQQ:(id)sender {
    [self loginWithName:UMShareToQQ];
}

/**
 *  删除新浪微博授权
 */
- (void)deleteWBAccessToken{
    [[UMSocialDataService defaultDataService] requestUnOauthWithType:UMShareToSina  completion:^(UMSocialResponseEntity *response){
        NSLog(@"response is %@",response);
    }];
}
@end
