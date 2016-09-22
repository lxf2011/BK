//
//  RegisterViewController.h
//  DXQ
//
//  Created by 做功课 on 15/7/22.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewControllerNormal.h"
@interface RegisterViewController : BaseViewControllerNormal
@property (weak, nonatomic) IBOutlet UITextField *textFieldTelephone;
@property (weak, nonatomic) IBOutlet UITextField *textFieldIDCode;
- (IBAction)getIDCode:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *buttonGetIDCode;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewSelect;
- (IBAction)agreeProtocol:(id)sender;
@property(nonatomic,assign)BOOL isAgree;
@end
