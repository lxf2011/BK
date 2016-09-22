//
//  LeftFeedbackViewController.h
//  DXQ
//
//  Created by 做功课 on 15/8/24.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import "BaseViewControllerNormal.h"
#import "UITextViewPlaceholder.h"

@interface LeftFeedbackViewController : BaseViewControllerNormal
@property (weak, nonatomic) IBOutlet UITextViewPlaceholder *textViewFeedBack;
- (IBAction)sendText:(UIButton *)sender;

@end
