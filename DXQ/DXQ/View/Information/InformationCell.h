//
//  InformationCell.h
//  DXQ
//
//  Created by 做功课 on 15/7/24.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableCell.h"
#import "DXMsgItemModel.h"
#import "UITextViewBottomLine.h"

@interface InformationCell : BaseTableCell
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewDetail;
@property (weak, nonatomic) IBOutlet UITextView *textViewContent;
@property (strong, nonatomic)DXMsgItemModel *model;

@property (weak, nonatomic) IBOutlet UIButton *buttonCollect;

@property (weak, nonatomic) IBOutlet UIButton *buttonLike;
- (IBAction)like:(UIButton *)sender;
@property (nonatomic) BOOL isLike;//点赞状态

@property (weak, nonatomic) IBOutlet UIView *viewBackground;
@property (weak, nonatomic) IBOutlet UILabel *labelTime;

-(void)setModel:(DXMsgItemModel *)model;

// 每条资讯的id
@property (nonatomic, copy) NSString *L_ID;
@end
