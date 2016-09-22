//
//  OrgDetailViewController.m
//  DXQ
//
//  Created by 做功课 on 15/8/22.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import "OrgDetailViewController.h"
#import "RSTabBar.h"
#import "RSTextHelper.h"
#import "DXPreferenceTool.h"
#import "DXUserPreferenceStatus.h"
#import "DXOrgTool.h"
#import "AssociationCell.h"
@interface OrgDetailViewController (){
    NSMutableArray *arrayOrg;
    NSArray *arrayResult;
    NSMutableArray *arrayAtRow;
}

@end

@implementation OrgDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setModel:_model];
    [self.view adaptSubViews];
    [self setupTabBar];
    self.buttonPraise.hidden = NO;
    self.webView.hidden = NO;
    self.tableView.hidden = YES;
    
}

- (void)setModel:(DxGetOrgsItemModel *)model{
    _model = model;
    
    [self.webView loadHTMLString:model.LCONTENT baseURL:nil];
    
    UIButton *leftBtn = (UIButton *)self.navigationItem.leftBarButtonItem.customView;
    [self setLeftBarButtonItem:model.LORGNAME];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refresh) name:kNotificationPreferenceStatusChange object:nil];
    [self refresh];

}
-(void)refresh{
    NSArray *array = @[@"L_ORG", @"USR_ORG_COLLECT", [NSString stringWithFormat:@"%ld",(long)_model.Id]];
    self.buttonPraise.selected = [DXUserPreferenceStatus isPraise:array];
}
- (void)setupTabBar{
    RSTabBar *tabBar = [[RSTabBar alloc]initWithY:64 withTabTitleArr:@[@"主页", @"动态"] withClickCallBack:^(int tag) {
        NSLog(@"位置:%d",tag);
        if (tag == 0) {
            self.buttonPraise.hidden = NO;
            self.webView.hidden = NO;
            self.tableView.hidden = YES;
        }
        else{
            if (arrayAtRow==nil) {
                arrayAtRow = [NSMutableArray array];
            }
            if (arrayOrg==nil) {
                arrayOrg = [NSMutableArray array];
            }
            self.buttonPraise.hidden = YES;
            self.webView.hidden = YES;
            self.tableView.hidden = NO;
            DXGetOrgMsgsParam *param = [[DXGetOrgMsgsParam alloc]init];
            param.type = @"";
            param.lid = _model.Id;
            __block int i =0;
            [DXOrgTool getOrgMsgWithParams:param success:^(DXGetOrgMsgsModel *result) {
                for (DXGetOrgMsgsItemModel *obj in result.data) {
                    if (obj.Msg !=nil) {
                        [arrayOrg addObject:obj.Msg];
                    }
                    if (obj.Act!=nil) {
                        [arrayOrg addObject:obj.Act];
                    }
                    [arrayAtRow addObject:[NSString stringWithFormat:@"%d",i]];
                    i = i+1;
                }
                arrayResult = result.data;
                [self.tableView reloadData];
            } failure:^(NSError *error) {
                
            }];
        }
    }];
    [self.view addSubview:tabBar];
    
}
- (IBAction)praise:(UIButton *)sender {
    NSString *ltype = @"USR_ORG_COLLECT";
    
    NSArray *array = @[@"L_ORG", ltype, [NSString stringWithFormat:@"%ld",(long)_model.Id]];
    
    
    if (sender.selected) {
        DXDelPreferenceParam *param = [[DXDelPreferenceParam alloc]init];
        param.LTARGET = @"L_ORG";
        param.LTYPE = ltype;
        param.LTARID = (int)_model.Id;
        
        [DXPreferenceTool postDelPreferenceWithParams:param success:^(DXDelPreferenceModel *result) {
            [DXUserPreferenceStatus delPraiseStatus:array];
            sender.selected = NO;
        } failure:^(NSError *error) {
            [self makeToast:@"取消失败，请检查网络"];
        }];
    }
    else{
        DXAddPreferenceParam *param = [[DXAddPreferenceParam alloc]init];
        param.LTARGET = @"L_ORG";
        param.LTYPE = ltype;
        param.LTARID = (int)_model.Id;
        [DXPreferenceTool postAddPreferenceWithParams:param success:^(DXAddPreferenceModel *result) {
            [DXUserPreferenceStatus addPraiseStatus:array];
            sender.selected = YES;
        } failure:^(NSError *error) {
            [self makeToast:@"收藏失败，请检查网络"];
        }];
        
    }
}
#pragma mark UITableView代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [arrayOrg count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AssociationCell *cell = (AssociationCell *)[tableView dequeueReusableCellWithIdentifier:@"AssociationCell" owner:self];
    NSObject *obj = arrayOrg[indexPath.row];
    NSString *atRowStr = arrayAtRow[indexPath.row];
    [cell setModel:arrayResult[atRowStr.intValue] orgInfo:arrayOrg[atRowStr.intValue]];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 224;
}
@end
