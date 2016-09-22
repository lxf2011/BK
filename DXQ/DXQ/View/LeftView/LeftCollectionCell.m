//
//  LeftCollectionCell.m
//  DXQ
//
//  Created by 做功课 on 15/8/7.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import "LeftCollectionCell.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+DXWebCache.h"
static NSString *ID = @"LeftCollectionCell";

@implementation LeftCollectionCell

- (void)awakeFromNib {
    self.imageViewContent.layer.masksToBounds = YES;
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
-(void)setModel:(DXCollectionItemModel *)model cat:(NSString *)cat{
    _model = model;
    if ([cat isEqualToString:@"精品"]) {
        self.labelTitle.text = model.L_SPECIAL_NAME;
        [self.imageViewContent sd_setImageWithURL_dx:model.L_PIC placeholderImage:[UIImage imageNamed:@"link"]];
    }
    else if ([cat isEqualToString:@"社团"]) {
        self.labelTitle.text = model.L_ORG_NAME;
        [self.imageViewContent sd_setImageWithURL_dx:model.L_ICON placeholderImage:[UIImage imageNamed:@"link"]];
    }
    else{
        
        self.labelTitle.text = model.L_TITLE;
        [self.imageViewContent sd_setImageWithURL_dx:model.L_PIC placeholderImage:[UIImage imageNamed:@"link"]];
    }
}
@end
