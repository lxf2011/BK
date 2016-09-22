//
//  LeftModifyViewController.m
//  DXQ
//
//  Created by 做功课 on 15/8/7.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import "LeftModifyViewController.h"
#import "DXAuthTool.h"
#import "DXSigleSelectViewController.h"
#import "RSFileHelp.h"
#import "DXLoginHelp.h"
@interface LeftModifyViewController ()
@end

@implementation LeftModifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBarButtonItem:@"修改信息"];
    
    //适配
    
    [self.scrollViewBackground adaptSubViews];
    [self.imageViewBackGround adaptHeight];
    [self.imageViewBackGround adaptSubViews];
    [self.viewBackground alignTopWithView:self.imageViewBackGround];
    [self.buttonSave alignTopWithView:self.viewBackground space:8];
    
    //初始化数据
    DXLoginUserReallyModel *model = [DXLoginHelp sharedInstance].loginUser;
    if (model!=nil) {
        self.labelSchool.text = [DXLoginHelp sharedInstance].school ? [DXLoginHelp sharedInstance].school : @"请选择学校";
        self.textFieldName.placeholder = [DXLoginHelp sharedInstance].nickName;
        if ([[DXLoginHelp sharedInstance].sex isEqualToString:@"男"]) {
            [self becomeMale:nil];
        }
        else{
            [self becomFemale:nil];
        }
        
    }
    else{
        [self becomeMale:nil];
    }
    
    
}


- (IBAction)saveModify:(UIButton *)sender {
    DXChangeUserParam *param = [[DXChangeUserParam alloc]init];
    NSString *LID = [NSString stringWithFormat:@"%ld",(long)[DXLoginHelp sharedInstance].loginUser.Id];
    param.LID = LID;
    param.LKEY = @"nickName";//代表修改的是昵称
    param.LSVALUE = self.textFieldName.text;
    param.LOTYPE = @"L_USR";//代表修改的是用户属性
    param.LTYPE = @"S";//代表字符串
    
    DXChangeUserParam *param2 = [[DXChangeUserParam alloc]init];
    param2.LID = LID;
    param2.LKEY = @"school";
    param2.LSVALUE = self.labelSchool.text;
    param2.LOTYPE = @"L_USR";//代表修改的是用户属性
    param2.LTYPE = @"S";//代表字符串
    
    DXChangeUserParam *param3 = [[DXChangeUserParam alloc]init];
    param3.LID = LID;
    param3.LKEY = @"sex";
    param3.LSVALUE = self.isMale ? @"男" : @"女";
    param3.LOTYPE = @"L_USR";//代表修改的是用户属性
    param3.LTYPE = @"S";//代表字符串
    
    BOOL checkName = self.textFieldName.text.length;
    BOOL checkSchool = ![self.labelSchool.text isEqualToString:@"请选择您的学校"];
    NSString *modifySuccess = @"修改成功";
    NSString *modifyFail = @"保存修改失败，请检查当前网络情况";
    
    if (checkName && checkSchool) {
        [DXAuthTool postChangeUserListWithParams:@[param, param2, param3] success:^(DXChangeUserListModel *result) {
            [self makeToastAtWindow:modifySuccess];
            [DXLoginHelp sharedInstance].sex = param3.LSVALUE;
            [DXLoginHelp sharedInstance].school = param2.LSVALUE;
            [DXLoginHelp sharedInstance].nickName = param.LSVALUE;
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationModifyPersonIfno object:nil];
        } failure:^(NSError *error) {
            [self makeToastAtWindow:modifyFail];
        }];
    }
    else if (checkSchool) {
        [DXAuthTool postChangeUserListWithParams:@[param2, param3] success:^(DXChangeUserListModel *result) {
            [self makeToastAtWindow:modifySuccess];
            [DXLoginHelp sharedInstance].sex = param3.LSVALUE;
            [DXLoginHelp sharedInstance].school = param2.LSVALUE;
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationModifyPersonIfno object:nil];
        } failure:^(NSError *error) {
            [self makeToastAtWindow:modifyFail];
        }];
    }
    else if (checkName) {
        [DXAuthTool postChangeUserListWithParams:@[param, param3] success:^(DXChangeUserListModel *result) {
            [self makeToastAtWindow:modifySuccess];
            [DXLoginHelp sharedInstance].sex = param3.LSVALUE;
            [DXLoginHelp sharedInstance].nickName = param.LSVALUE;
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationModifyPersonIfno object:nil];
        } failure:^(NSError *error) {
            [self makeToastAtWindow:modifyFail];
        }];
    }else{
        [DXAuthTool postChangeUserListWithParams:@[param3] success:^(DXChangeUserListModel *result) {
            [self makeToastAtWindow:modifySuccess];
            [DXLoginHelp sharedInstance].sex = param3.LSVALUE;
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationModifyPersonIfno object:nil];
        } failure:^(NSError *error) {
            [self makeToastAtWindow:modifyFail];
        }];
    }

}
- (IBAction)chooseSchool:(UIButton *)sender {
    DXSigleSelectViewController *controller = [[DXSigleSelectViewController alloc]init];
    NSString *schoolJson = [RSFileHelp getStringFromFile:@"School.json"];
    NSArray *arr = [schoolJson componentsSeparatedByString:@"\n"];
    controller.navigationTitle = @"选择学校";
    controller.dataSource = arr;
    controller.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)changeValue:(NSString *)value{
    self.labelSchool.text = value;
}

- (IBAction)birthday:(UIButton *)sender {
    CGRect datePickerF = CGRectMake(0, CGRectGetMaxY(self.buttonSave.frame), ScreenWidth, ScreenHeight - CGRectGetMaxY(self.buttonSave.frame));
    UIDatePicker *datePicker = [[UIDatePicker alloc]initWithFrame:datePickerF];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:datePicker];
    
}

- (void)dateChange:(UIDatePicker *)dp{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    df.dateFormat = @"yyyy-MM-dd";
    self.labelBirthday.text = [NSString stringWithFormat:@"生日 %@", [df stringFromDate:dp.date]];
}
- (IBAction)becomeMale:(id)sender {
    self.isMale = YES;
    self.imageViewSex.image = [UIImage imageNamed:@"male"];
}

- (IBAction)becomFemale:(id)sender {
    self.isMale = NO;
    self.imageViewSex.image = [UIImage imageNamed:@"female"];
}
@end
