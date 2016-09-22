//
//  LeftCollectionCell.m
//  DXQ
//
//  Created by 做功课 on 15/8/7.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import "LeftCollectionCell.h"

static NSString *ID = @"LeftCollectionCell";

@implementation LeftCollectionCell

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (LeftCollectionCell *)cellWithTableView:(UITableView *)tableView{
    LeftCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:ID owner:nil options:nil] lastObject];
    }
    return cell;
}
@end
