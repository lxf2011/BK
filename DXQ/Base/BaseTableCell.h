//
//  SYBaseTableCell.h
//  zhixingHC
//
//  Created by li jian on 13-3-20.
//  Copyright (c) 2013年 li jian. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface BaseTableCell : UITableViewCell
@property (strong, nonatomic) UIViewController *owner;
@property (strong, nonatomic) NSString *valueInCell;
+ (id)cellWithOwner:(UIViewController *)owner xib:(NSString *)xib;
-(void) onSelected;
@end


