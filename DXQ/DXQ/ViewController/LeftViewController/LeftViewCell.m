//
//  LeftViewCell.m
//  DXQ
//
//  Created by 做功课 on 15/7/23.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import "LeftViewCell.h"

static NSString *ID = @"LeftViewCell";

@implementation LeftViewCell

- (void)awakeFromNib {
    self.labelTitle.textColor = DXColorGrayMiddle;
    self.labelDetail.textColor = DXColorGrayLight;
    [self adaptSubViews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
