//
//  LeftCollectionCell.h
//  DXQ
//
//  Created by 做功课 on 15/8/7.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DXCollectionItemModel.h"
@interface LeftCollectionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageViewContent;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
+ (LeftCollectionCell *)cellWithTableView:(UITableView *)tableView;
-(void)setModel:(DXCollectionItemModel *)model cat:(NSString *)cat;
@end
