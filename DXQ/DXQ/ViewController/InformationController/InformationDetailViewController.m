//
//  InformationDetailViewController.m
//  DXQ
//
//  Created by rason on 8/6/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "InformationDetailViewController.h"
#import "DXPreferenceTool.h"
#import "DXMsgItemModel.h"
@interface InformationDetailViewController()
{
    
}
@end

@implementation InformationDetailViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self refresh];
    [self setupUI];
}

- (void)refresh{
    DXGetMsgSumParam *param = [[DXGetMsgSumParam alloc]init];
    param.id = super.LTARID;
    [DXPreferenceTool getMsgSumWithParams:param success:^(DXGetMsgSumModel *result) {
        DXGetMsgSumReallyModel *model = result.data[0];
        NSString *praise = model.L_PRAISE;
        NSString *collect = model.L_COLLECT;
        NSString *comment = model.L_COMMENT_SUM;
        NSString *share = model.L_SHARE;
        DXUpdateMsgViewParam *updateMsgViewParam = [[DXUpdateMsgViewParam alloc]init];
        updateMsgViewParam.id = [super.LTARID intValue];
        [DXPreferenceTool getUpdateMsgViewWithParams:updateMsgViewParam success:^(DXUpdateMsgViewModel *result) {
            
        } failure:^(NSError *error) {
            
        }];
        [super refreshOptionViewWithCollect:collect comment:comment praise:praise share:share];
    } failure:^(NSError *error) {
        
    }];
}

- (void)setupUI{
    [self setLeftBarButtonItem:@"资讯详情"];
}


@end
