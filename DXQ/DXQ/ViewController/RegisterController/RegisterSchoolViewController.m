//
//  RegisterSchoolViewController.m
//  DXQ
//
//  Created by 做功课 on 15/7/22.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import "RegisterSchoolViewController.h"
#import "MainTabBarController.h"
#import "DXNavigationController.h"
#import "LeftViewController.h"
#import "RegisterSchoolCell.h"
#import "DXSigleSelectViewController.h"
#import "RSFileHelp.h"
#import "DXAuthTool.h"
#import "DXLoginHelp.h"
static NSString *ID = @"RegisterSchoolCell";

@interface RegisterSchoolViewController () <UITableViewDataSource, UITableViewDelegate>{
    RegisterSchoolCell *cell;
}
- (IBAction)finishBtnClick:(UIButton *)sender;
- (IBAction)notAdmitBtnClick:(UIButton *)sender;


@end

@implementation RegisterSchoolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人信息";
    [_tableViewSelectSchool registerNib:[UINib nibWithNibName:ID bundle:nil] forCellReuseIdentifier:ID];
    [self.scrollView adaptSubViewsToCenter];
}

#pragma mark - 按钮点击事件

- (IBAction)finishBtnClick:(UIButton *)sender {
    if([cell.labelSchool.text rangeOfString:@"请选择您的学校"].location!=NSNotFound){
        [self makeToastAtWindow:@"请选择您的学校"];
        return;
    }
    DXChangeUserParam *param = [[DXChangeUserParam alloc]init];
    param.LID = [NSString stringWithFormat:@"%ld",(long)[DXLoginHelp sharedInstance].loginUser.Id];
    param.LKEY = @"school";//代表修改的是昵称
    param.LSVALUE = cell.labelSchool.text;
    param.LOTYPE = @"L_USR";//代表修改的是用户属性
    param.LTYPE = @"S";//代表字符串
    [DXAuthTool postChangeUserWithParams:param success:^(DXChangeUserModel *result) {
        [DXLoginHelp sharedInstance].school= param.LSVALUE;
        [self.navigationController popToRootViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationPreferenceStatusChange object:nil];
    } failure:^(NSError *error) {
        [self makeToastAtWindow:@"学校设置失败，请检查当前网络情况"];
    }];
    
}

- (IBAction)notAdmitBtnClick:(UIButton *)sender {    
    [self.navigationController popToRootViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationPreferenceStatusChange object:nil];
}


#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (cell==nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:ID];
    }
    NSLog(@"学校:%@",cell.labelSchool.text);
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DXSigleSelectViewController *controller = [[DXSigleSelectViewController alloc]init];
    NSString *schoolJson = [RSFileHelp getStringFromFile:@"School.json"];
    NSArray *arr = [schoolJson componentsSeparatedByString:@"\n"];
    controller.navigationTitle = @"选择学校";
    controller.dataSource = arr;
    controller.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
}
-(void)changeValue:(NSString *)value{
    cell.labelSchool.text = value;
    cell.labelSchool.textColor = [UIColor blackColor];
    [self.tableViewSelectSchool reloadData];
}

@end
