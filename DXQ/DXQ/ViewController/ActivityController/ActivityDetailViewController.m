//
//  ActivityDetailViewController.m
//  DXQ
//
//  Created by rason on 8/6/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import "DXPreferenceTool.h"
#import "DXGetActivityItemModel.h"
@implementation ActivityDetailViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self initView];
    [self refresh];
}

- (void)initView{
    [self setLeftBarButtonItem:@"活动详情"];
    
}

- (void)refresh{
    DXGetActSumParam *param = [[DXGetActSumParam alloc]init];
    param.id = self.LTARID;
    [DXPreferenceTool getActSumWithParams:param success:^(DXGetActSumModel *result) {
        DXGetActSumReallyModel *model = result.data[0];
        NSString *praise = model.L_PRAISE;
        NSString *collect = model.L_COLLECT;
        NSString *comment = model.L_COMMENT_SUM;
        NSString *share = model.L_SHARE;
        DXUpdateActViewParam *updateActViewParam = [[DXUpdateActViewParam alloc]init];
        DXGetActivityItemModel *tempModel = (DXGetActivityItemModel *)self.model;
        updateActViewParam.id = [tempModel.L_ID intValue];
        [DXPreferenceTool getUpdateActViewWithParams:updateActViewParam success:^(DXUpdateActViewModel *result){
            
        } failure:^(NSError *error) {
            
        }];
        [super refreshOptionViewWithCollect:collect comment:comment praise:praise share:share];
    } failure:^(NSError *error) {
        
    }];
}

@end
