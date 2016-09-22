//
//  Comment.m
//  DXQ
//
//  Created by 做功课 on 15/8/17.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import "Comment.h"

@interface Comment()

@end

@implementation Comment

- (void)setAddCommnetModel:(DXAddCommetReallyModel *)model{
    self.userName = [NSString stringWithFormat:@"%zd", model.LOWNER];
    self.content = model.LCONTENT;
    self.praise = [NSString stringWithFormat:@"%zd", model.LSUMPRAISE];
    self.Id = model.Id;
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    [fmt setDateFormat:@"hh:mm"];
    self.time = [NSString stringWithFormat:@"今天 %@", [fmt stringFromDate:[NSDate date]]];
}

- (void)setModel:(DXGetCommetsItemModel *)model{
    self.userName = model.L_USR;
    self.time = model.L_TIME;
    self.content = model.L_CONTENT;    
    self.praise = [NSString stringWithFormat:@"%zd", model.L_SUM_PRAISE];
}

@end
