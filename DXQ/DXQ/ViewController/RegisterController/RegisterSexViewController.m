//
//  RegisterSexViewController.m
//  DXQ
//
//  Created by 做功课 on 15/7/22.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import "RegisterSexViewController.h"
#import "RegisterSchoolViewController.h"
#import "DXAuthTool.h"
#import "DXLoginHelp.h"
@interface RegisterSexViewController ()
- (IBAction)boyBtnClick:(UIButton *)sender;
- (IBAction)girBtnClick:(UIButton *)sender;


@end

@implementation RegisterSexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.scrollView adaptSubViews];
    self.navigationItem.title = @"个人信息";
}

#pragma mark - 按钮点击事件
- (IBAction)boyBtnClick:(UIButton *)sender {
    [self changeUser:@"男"];
}
- (IBAction)girBtnClick:(UIButton *)sender {
    [self changeUser:@"女"];
}
-(void)changeUser:(NSString *)sex{
//    RegisterSchoolViewController *registerSchoolVc = [[RegisterSchoolViewController alloc]init];
//    [self.navigationController pushViewController:registerSchoolVc animated:YES];
//    return;
    DXChangeUserParam *param = [[DXChangeUserParam alloc]init];
    param.LID = [NSString stringWithFormat:@"%ld",(long)[DXLoginHelp sharedInstance].loginUser.Id];
    param.LKEY = @"sex";//代表修改的是昵称
    param.LSVALUE =sex;
    param.LOTYPE = @"L_USR";//代表修改的是用户属性
    param.LTYPE = @"S";//代表字符串
    
    [DXAuthTool postChangeUserWithParams:param success:^(DXChangeUserModel *result) {
        [DXLoginHelp sharedInstance].sex = param.LSVALUE;
        RegisterSchoolViewController *registerSchoolVc = [[RegisterSchoolViewController alloc]init];
        [self.navigationController pushViewController:registerSchoolVc animated:YES];
    } failure:^(NSError *error) {
        [self makeToastAtWindow:@"性别设置失败，请检查当前网络情况"];
    }];

}
@end
