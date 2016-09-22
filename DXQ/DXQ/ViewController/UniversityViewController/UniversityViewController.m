//
//  UniversityViewController.m
//  DXQ
//
//  Created by rason on 8/6/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "UniversityViewController.h"
#import "UniversityCell.h"
#import "DXMsgTool.h"
#import "InformationCell.h"
#import "GiftCell.h"
#import "ActivityCell.h"
#import "DXOrgTool.h"
#import "UIImageView+WebCache.h"
#import "OrgDetailViewController.h"
#import "RSTextHelper.h"
#import "ImageButton.h"
#import "DXSigleSelectViewController.h"
#import "RSFileHelp.h"
#import "UIImageView+DXWebCache.h"
#import "DXCfg.h"
static NSString *collectionCellID = @"UniversityCell";

@implementation UniversityViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    countUniversity = 0;
    [self.view adaptSubViews];
//    arrayCell = @[@"资讯", @"活动", @"礼物"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"UniversityCell" bundle:nil] forCellWithReuseIdentifier:collectionCellID];
    [self refreshBySchool:self.query];
    [self changeLeftButtonTitle:self.query];
}

- (void)changeLeftButtonTitle:(NSString *)title{
    
    CGFloat width = [RSTextHelper getSizeFromFont:DXNavFont AndText:title].width;
//    ImageButton *leftBtn = [[ImageButton alloc]initWithFrame:CGRectMake(0, 0, width, 50) withButtonType:leftImage withImage:[UIImage imageNamed:@"zx_-29"] withTitle:title];
    UIButton *titleBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, width, 50)];
    [titleBtn setTitle:title forState:UIControlStateNormal];
    titleBtn.titleLabel.font = DXNavFont;
//    [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleBtn;//[[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    [self setLeftBarButtonItem:nil];
}

#pragma mark - 按钮点击
- (void)titleBtnClick:(UIButton *)button{
    DXSigleSelectViewController *controller = [[DXSigleSelectViewController alloc]init];
    NSString *schoolJson = [RSFileHelp getStringFromFile:@"School.json"];
    NSArray *arr = [schoolJson componentsSeparatedByString:@"\n"];
    [controller.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : DXNavFont}];
    controller.dataSource = arr;
    controller.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)changeValue:(NSString *)value{
    [self changeLeftButtonTitle:value];
    [self refreshBySchool:value];
}


- (void)refreshBySchool:(NSString *)school{
    DXGetOrgsParam *param = [[DXGetOrgsParam alloc]init];
    param.offset = 0;
    param.limit = 30;
    if ([school isEqualToString:@"所有学校"]) {
        param.query = nil;
    }
    else{
        param.query = [NSString stringWithFormat:@"LSCHOOL:%@",school];//self.query;
    }
    [DXOrgTool getOrgsWithParams:param success:^(NSMutableArray *result) {
        arrayOrg = result;
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return arrayOrg.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UniversityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    DxGetOrgsItemModel *model = arrayOrg[indexPath.item];
    cell.labelTitle.text =model.LORGNAME;
    [cell.imageViewOrg sd_setImageWithURL_dx:model.LICON placeholderImage:[UIImage imageNamed:@"loading.jpg"]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    OrgDetailViewController *orgDetailVc = [[OrgDetailViewController alloc]init];
    [orgDetailVc setModel:arrayOrg[indexPath.item]];
    [self.navigationController pushViewController:orgDetailVc animated:YES];
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return (ScreenWidth-300)/4.0;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5,(ScreenWidth-300)/4.0,0 , (ScreenWidth-300)/4.0);
}
@end
/*
 #pragma mark - UITableViewDataSource
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 return arraySearchResult.count;
 }
 
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 NSUInteger arrayIndex = [arrayCell indexOfObject:self.cat];
 switch (arrayIndex) {
 case 0:{
 InformationCell *cell = (InformationCell *)[tableView dequeueReusableCellWithIdentifier:@"InformationCell" owner:self];
 //            InformationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InformationCell"];
 //            if (!cell) {
 //                cell = [[InformationCell alloc]init];
 //            }
 [cell setModel:arraySearchResult[indexPath.row]];
 return cell;
 }
 case 1:{
 ActivityCell *cell = (ActivityCell *)[tableView dequeueReusableCellWithIdentifier:@"ActivityCell" owner:self];
 [cell setModel:arraySearchResult[indexPath.row]];
 return cell;
 }
 case 2:{
 GiftCell *cell = (GiftCell *)[tableView dequeueReusableCellWithIdentifier:@"GiftCell" owner:self];
 [cell setModel:arraySearchResult[indexPath.row]];
 return cell;
 }
 }
 
 return nil;
 }
 
 - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 NSUInteger arrayIndex = [arrayCell indexOfObject:self.cat];
 switch (arrayIndex) {
 case 0:
 return 120;
 case 1:
 return 170;
 case 2:
 return 120;
 }
 return 170;
 }
 */

