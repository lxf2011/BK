//
//  RegisterPwdViewController.h
//  DXQ
//
//  Created by 做功课 on 15/7/22.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewControllerNormal.h"
@interface RegisterPwdViewController : BaseViewControllerNormal
@property (weak, nonatomic) IBOutlet UITextField *textFieldPassword;
@property (weak, nonatomic) IBOutlet UITextField *textFieldConfiirmPassword;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end
