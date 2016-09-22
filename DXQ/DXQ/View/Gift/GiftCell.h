//
//  GiftCell.h
//  DXQ
//
//  Created by 做功课 on 15/7/24.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DXGetGiftsItemModel.h"
#import "BaseTableCell.h"

@interface GiftCell : BaseTableCell
@property (weak, nonatomic) IBOutlet UIView *viewShadow;
@property (nonatomic) BOOL isLike;//点赞状态
@property (weak, nonatomic) IBOutlet UIButton *buttonLike;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
- (IBAction)like:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelTime;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHeight;

- (void)setModel:(DXGetGiftsItemModel *)model;

// 每个cell的id
@property (nonatomic, copy) NSString *L_ID;

@end
