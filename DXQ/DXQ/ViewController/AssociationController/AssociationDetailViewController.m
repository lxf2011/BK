//
//  AssociationDetailViewController.m
//  DXQ
//
//  Created by rason on 8/6/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "AssociationDetailViewController.h"
#import "DXPreferenceTool.h"
@implementation AssociationDetailViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self refresh];
    [self setupUI];
}

- (void)refresh{
    
    if ([self.type isEqualToString:@"msg"]) {
        DXGetMsgSumParam *param = [[DXGetMsgSumParam alloc]init];
        param.id = self.LTARID;
        [DXPreferenceTool getMsgSumWithParams:param success:^(DXGetMsgSumModel *result) {
            DXGetMsgSumReallyModel *model = result.data[0];
            NSString *praise = model.L_PRAISE;
            NSString *collect = model.L_COLLECT;
            NSString *comment = model.L_COMMENT_SUM;
            NSString *share = model.L_SHARE;
            [super refreshOptionViewWithCollect:collect comment:comment praise:praise share:share];
        } failure:^(NSError *error) {
            
        }];
    }
    else{
        DXGetActSumParam *param = [[DXGetActSumParam alloc]init];
        param.id = self.LTARID;
        [DXPreferenceTool getActSumWithParams:param success:^(DXGetActSumModel *result) {
            DXGetActSumReallyModel *model = result.data[0];
            NSString *praise = model.L_PRAISE;
            NSString *collect = model.L_COLLECT;
            NSString *comment = model.L_COMMENT_SUM;
            NSString *share = model.L_SHARE;
            [super refreshOptionViewWithCollect:collect comment:comment praise:praise share:share];
        } failure:^(NSError *error) {
            
        }];
    }
    
}

- (void)setupUI{
    [self setLeftBarButtonItem:@"社团活动详情"];
}

@end
