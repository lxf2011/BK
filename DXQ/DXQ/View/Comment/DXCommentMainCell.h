//
//  DXCommentMainCell.h
//  DXQ
//
//  Created by 做功课 on 15/8/6.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DXGetCommetsItemModel.h"
#import "DXAddCommetReallyModel.h"
#import "CommentFrame.h"
typedef void (^Replay)();
@interface DXCommentMainCell : UITableViewCell

@property (nonatomic, strong) CommentFrame *commentFrame;

/** 回复 */
- (IBAction)reply:(UIButton *)sender;
/** 点赞 */
@property (weak, nonatomic) IBOutlet UIButton *buttonLike;
- (IBAction)like:(UIButton *)sender;
@property (nonatomic, assign) BOOL isLike;

@property (strong, nonatomic) Replay replay;

/** 模型 */
@property (nonatomic, strong)DXGetCommetsItemModel *model;

/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *labelTime;
/** 内容 */
@property (weak, nonatomic) IBOutlet UILabel *labelContent;
/** 用户头像 */
@property (weak, nonatomic) IBOutlet UIImageView *imageViewUser;
/** 用户名 */
@property (weak, nonatomic) IBOutlet UILabel *labelUserName;
/** 背景 */
@property (weak, nonatomic) IBOutlet UIView *viewBackground;

@property (weak, nonatomic) IBOutlet UIView *viewBackGroundGray;

/** 回复背景 */
@property (weak, nonatomic) IBOutlet UIView *viewReply;
/** 回复用户头像 */
@property (weak, nonatomic) IBOutlet UIImageView *imageViewReply;
/** 回复用户名 */
@property (weak, nonatomic) IBOutlet UILabel *labelUserReply;
/** 回复内容 */
@property (weak, nonatomic) IBOutlet UILabel *labelContentReply;
//分割线
@property (weak, nonatomic) IBOutlet UIView *viewLine;

/** 此条评论的id */
@property (nonatomic, assign) NSInteger Id;

- (void)setModel:(DXGetCommetsItemModel *)model commetsItemModels:(NSArray *)commetsItemModels;
- (void)setAddCommnetModel:(DXAddCommetReallyModel *)model;

@end
