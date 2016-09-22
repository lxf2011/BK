//
//  LeftViewController.h
//  DXQ
//
//  Created by rason on 7/22/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ICSDrawerController.h"
@interface LeftViewController : BaseViewController
@property(nonatomic, weak) ICSDrawerController *drawer;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *viewReally;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
- (IBAction)setupPersonInfo:(UIButton *)sender;
@end
