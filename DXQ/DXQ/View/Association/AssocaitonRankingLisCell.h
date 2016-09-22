//
//  AssocaitonRankingLisCell.h
//  DXQ
//
//  Created by 做功课 on 15/8/8.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AssocaitonRankingLisCell;
@protocol AssocaitonRankingLisCellDelegate <NSObject>
@optional
- (void)cell:(AssocaitonRankingLisCell *)cell didClickButton:(UIButton *)button;
@end


@interface AssocaitonRankingLisCell : UITableViewCell
/** 赞 */
@property (weak, nonatomic) IBOutlet UIButton *buttonLike;
- (IBAction)like:(UIButton *)sender;
@property (nonatomic) BOOL isLike;

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewContent;

@property (nonatomic, weak) id<AssocaitonRankingLisCellDelegate>delegate;

+ (AssocaitonRankingLisCell *)cellWithTableView:(UITableView *)tableView;

@end
