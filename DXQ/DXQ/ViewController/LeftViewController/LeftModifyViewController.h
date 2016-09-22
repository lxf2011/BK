//
//  LeftModifyViewController.h
//  DXQ
//
//  Created by 做功课 on 15/8/7.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface LeftModifyViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *textFieldName;
@property (weak, nonatomic) IBOutlet UIButton *buttonSchool;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewBackground;
@property (weak, nonatomic) IBOutlet UIButton *buttonSave;
@property (weak, nonatomic) IBOutlet UIButton *buttonBirthday;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewBackGround;
@property (weak, nonatomic) IBOutlet UILabel *labelSchool;
@property (weak, nonatomic) IBOutlet UILabel *labelBirthday;

- (IBAction)saveModify:(UIButton *)sender;
- (IBAction)chooseSchool:(UIButton *)sender;
- (IBAction)birthday:(UIButton *)sender;

#pragma mark 性别处理
@property (weak, nonatomic) IBOutlet UIButton *buttonMale;
@property (weak, nonatomic) IBOutlet UIButton *buttonFemale;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewSex;
@property (weak, nonatomic) IBOutlet UIView *viewBackground;
@property (nonatomic, assign) BOOL isMale;

- (IBAction)becomeMale:(id)sender;

- (IBAction)becomFemale:(id)sender;

@end
