//
//  LeftSetupTableViewCell.m
//  DXQ
//
//  Created by rason on 15/12/1.
//  Copyright © 2015年 rason. All rights reserved.
//

#import "LeftSetupTableViewCell.h"

@implementation LeftSetupTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
//- (void)layoutSubviews{
////    [super layoutSubviews];
//    for (UIView *view in self.subviews) {
//        // Hack! hidden the separator.
//        if ([NSStringFromClass([view class]) hasSuffix:@"UITableViewCellSeparatorView"]) {
//            view.hidden = YES;
//        }
//    }
//    for (UIView *view in self.contentView.subviews) {
//        // Hack! hidden the separator.
//        if ([NSStringFromClass([view class]) hasSuffix:@"UITableViewCellSeparatorView"]) {
//            view.hidden = YES;
//        }
//    }
//}
@end
