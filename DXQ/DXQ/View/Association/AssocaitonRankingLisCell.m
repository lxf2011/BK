//
//  AssocaitonRankingLisCell.m
//  DXQ
//
//  Created by 做功课 on 15/8/8.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import "AssocaitonRankingLisCell.h"
static NSString *ID = @"AssocaitonRankingLisCell";

@implementation AssocaitonRankingLisCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (AssocaitonRankingLisCell *)cellWithTableView:(UITableView *)tableView{
    AssocaitonRankingLisCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:ID owner:nil options:nil] lastObject];
    }
    return cell;
}
- (IBAction)like:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(cell:didClickButton:)]) {
        [self.delegate cell:self didClickButton:sender];
    }
}
@end
