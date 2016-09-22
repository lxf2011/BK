//
//  DXCommentViewController.h
//  DXQ
//
//  Created by 做功课 on 15/8/6.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewControllerNormal.h"
#import "PlaceholderTextView.h"
@interface DXCommentViewController : BaseViewControllerNormal <UITableViewDataSource, UITableViewDelegate, UITextViewDelegate>
/** 输入框 */
@property (weak, nonatomic) IBOutlet PlaceholderTextView *textViewInput;
/** 发送 */
@property (weak, nonatomic) IBOutlet UIButton *buttonSend;
- (IBAction)send:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *viewBottomLine;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *viewBottomBackground;
@property (weak, nonatomic) IBOutlet UIButton *buttonAddComment;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHeightSendView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintBottomSpace;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewBackground;

- (IBAction)addComment:(UIButton *)sender;

// 评论类型
@property (nonatomic, copy) NSString *LTARGET;
// 目标id
@property (nonatomic, copy) NSString *LTRAID;

@end
