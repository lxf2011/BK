//
//  GiftDetailViewController.m
//  DXQ
//
//  Created by rason on 8/6/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "GiftDetailViewController.h"
#import "DXPreferenceTool.h"

@implementation GiftDetailViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self initView];
    [self refresh];
}

- (void)initView{
    [self setLeftBarButtonItem:@"攻略详情"];

}

- (void)refresh{
    DXGetSpcSumParam *param = [[DXGetSpcSumParam alloc]init];
    param.id = super.LTARID.intValue;
    [DXPreferenceTool getSpcSumWithParams:param success:^(DXGetSpcSumModel *result) {
        DXGetSpcSumReallyModel *model = result.data[0];
        NSString *praise = model.L_PRAISE;
        NSString *collect = model.L_COLLECT;
        NSString *comment = model.L_COMMENT_SUM;
        NSString *share = model.L_SHARE;
        [super refreshOptionViewWithCollect:collect comment:comment praise:praise share:share];
    } failure:^(NSError *error) {
        
    }];
}

@end
