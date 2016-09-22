//
//  ActivityCell.h
//  DXQ
//
//  Created by 做功课 on 15/7/24.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DXGetActivityItemModel.h"
#import "BaseTableCell.h"

@interface ActivityCell : BaseTableCell
@property (weak, nonatomic) IBOutlet UIButton *location;
@property (weak, nonatomic) IBOutlet UITextView *time;

@property (weak, nonatomic) IBOutlet UIImageView *imageViewDetail;
@property (weak, nonatomic) IBOutlet UIButton *buttonLocation;
@property (weak, nonatomic) IBOutlet UIButton *buttonTime;
@property (weak, nonatomic) IBOutlet UIButton *buttonLook;
/** 点赞 */
- (IBAction)like:(UIButton *)sender;
@property (nonatomic, assign) BOOL isLike;
@property (weak, nonatomic) IBOutlet UIButton *buttonLike;

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UIView *viewBackground;

- (void)setModel:(DXGetActivityItemModel *)model;

// 每个cell的id
@property (nonatomic, copy) NSString *L_ID;

@end
