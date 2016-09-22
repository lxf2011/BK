//
//  LoginViewController.h
//  DXQ
//
//  Created by rason on 7/21/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewControllerNormal.h"
@interface LoginViewController : BaseViewControllerNormal
@property (weak, nonatomic) IBOutlet UITextField *textFieldTelephone;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPassWord;
- (IBAction)forgetPassword:(UIButton *)sender;
- (IBAction)login:(UIButton *)sender;
- (IBAction)loginByWX:(UIButton *)sender;
- (IBAction)lognByWB:(UIButton *)sender;


@end
