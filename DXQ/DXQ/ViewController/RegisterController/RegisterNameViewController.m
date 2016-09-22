//
//  RegisterNameViewController.m
//  DXQ
//
//  Created by 做功课 on 15/7/22.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import "RegisterNameViewController.h"
#import "RegisterSexViewController.h"
#import "RSCheck.h"
#import "DXAuthTool.h"
#import "DXLoginHelp.h"
@interface RegisterNameViewController ()
- (IBAction)nextBtnClick:(UIButton *)sender;

@end

@implementation RegisterNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //自定义的适配方法，居中适配
    [self.scrollView adaptSubViewsToCenter];
    [self.labelTip fillWidth];
    
    // 标题
    self.navigationItem.title = @"个人信息";
    
}

#pragma mark - 按钮点击事件
- (IBAction)nextBtnClick:(UIButton *)sender {
//    RegisterSexViewController *registerSexVc = [[RegisterSexViewController alloc]init];
//    [self.navigationController pushViewController:registerSexVc animated:YES];
//    return;
    if ([RSCheck checkIsNilForTextField:self.textFieldName tip:@"昵称"]) {
        DXChangeUserParam *param = [[DXChangeUserParam alloc]init];
        param.LID = [NSString stringWithFormat:@"%ld",(long)[DXLoginHelp sharedInstance].loginUser.Id];
        param.LKEY = @"nickName";//代表修改的是昵称
        param.LSVALUE = self.textFieldName.text ;
        param.LOTYPE = @"L_USR";//代表修改的是用户属性
        param.LTYPE = @"S";//代表字符串
        [DXAuthTool postChangeUserListWithParams:@[param] success:^(DXChangeUserListModel *result) {
            [DXLoginHelp sharedInstance].nickName = param.LSVALUE;
            RegisterSexViewController *registerSexVc = [[RegisterSexViewController alloc]init];
            [self.navigationController pushViewController:registerSexVc animated:YES];
        } failure:^(NSError *error) {
            [self makeToastAtWindow:@"昵称设置失败，请检查当前网络情况"];
        }];
    }
    
}
@end
