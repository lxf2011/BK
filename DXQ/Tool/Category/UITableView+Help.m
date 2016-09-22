//
//  UITableView+Help.m
//  DXQ
//
//  Created by rason on 8/5/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "UITableView+Help.h"

@implementation UITableView (Help)
-(UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier owner:(UIViewController *)owner{
    NSString *cellIdentifier = identifier;
    UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        [self registerNib:[UINib nibWithNibName:cellIdentifier bundle:nil] forCellReuseIdentifier:cellIdentifier];
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
@end
