//
//  SYBaseTableCell.m
//  zhixingHC
//
//  Created by li jian on 13-3-20.
//  Copyright (c) 2013年 li jian. All rights reserved.
//

#import "BaseTableCell.h"

@implementation BaseTableCell
+ (id)cellWithOwner:(UIViewController *)owner xib:(NSString *)xib{
    BaseTableCell *cell = [[NSBundle mainBundle] loadNibNamed:xib owner:owner options:nil][0];
    cell.owner = owner;
    return cell;
}
-(void) onSelected{
    //点击时执行
    
}
@end
