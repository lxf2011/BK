//
//  AssociationCell.h
//  DXQ
//
//  Created by 做功课 on 15/7/24.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DXGetOrgMsgsItemModel.h"
#import "BaseTableCell.h"

@interface AssociationCell : BaseTableCell
@property (weak, nonatomic) IBOutlet UILabel *labelTime;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewDetail;
@property (weak, nonatomic) IBOutlet UILabel *labelAssociation;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet NSObject *modelMark;
/** 看过 */
@property (weak, nonatomic) IBOutlet UIButton *buttonLook;
@property (nonatomic, assign) BOOL isLook;

/** 点赞 */
@property (weak, nonatomic) IBOutlet UIButton *buttonLike;
- (IBAction)like:(UIButton *)sender;
@property (nonatomic, assign) BOOL isLike;

@property (weak, nonatomic) IBOutlet UIButton *buttonLocation;
@property (weak, nonatomic) IBOutlet UIButton *buttonTime;
@property (weak, nonatomic) IBOutlet UIView *viewBackground;

//模型
@property (strong, nonatomic) DXGetOrgMsgsMsgModel *modelMsg;
@property (strong, nonatomic) DXGetOrgMsgsMsgModel *modelAct;
// 每条消息的id
@property (nonatomic, copy) NSString *Id;
- (void)setModel:(NSObject *)model orgInfo:(DXGetOrgMsgsItemInfoModel *)orgInfo;
//- (void)setModel:(DXGetOrgMsgsItemModel *)model cat:(NSString *)cat;
@end
