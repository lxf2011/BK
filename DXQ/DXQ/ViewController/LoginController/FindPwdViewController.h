//
//  RegisterFindPwdViewController.h
//  DXQ
//
//  Created by 做功课 on 15/8/24.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import "BaseViewControllerNormal.h"

@interface FindPwdViewController : BaseViewControllerNormal
@property (weak, nonatomic) IBOutlet UITextField *textFieldTelephone;
@property (weak, nonatomic) IBOutlet UITextField *textFieldIDCode;
- (IBAction)getIDCode:(UIButton *)sender;
- (IBAction)nextBtnClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *buttonGetIDCode;
@end
