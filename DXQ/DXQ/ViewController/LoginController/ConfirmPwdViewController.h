//
//  ComfirmPwdViewController.h
//  DXQ
//
//  Created by 做功课 on 15/8/24.
//  Copyright (c) 2015年 rason. All rights reserved.
//


#import "BaseViewControllerNormal.h"

@interface ConfirmPwdViewController : BaseViewControllerNormal
@property (weak, nonatomic) IBOutlet UITextField *textFieldPwd;
@property (weak, nonatomic) IBOutlet UITextField *textFieldConfirm;
- (IBAction)confirmBtnClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end
