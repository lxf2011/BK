//
//  ChangePwdViewController.h
//  DXQ
//
//  Created by rason on 15/12/1.
//  Copyright © 2015年 rason. All rights reserved.
//

#import "BaseViewControllerNormal.h"

@interface ChangePwdViewController : BaseViewControllerNormal

@property (weak, nonatomic) IBOutlet UITextField *textFieldPwdOld;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPwd;
@property (weak, nonatomic) IBOutlet UITextField *textFieldConfirm;
- (IBAction)confirmBtnClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end
