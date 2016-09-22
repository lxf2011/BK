//
//  AssociationMainController.m
//  DXQ
//
//  Created by 做功课 on 15/7/22.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import "AssociationMainController.h"
#import "AssociationCell.h"
#import "RSTabBar.h"
#import "MJRefresh.h"
#import "AssociationDetailViewController.h"
#import "YYCycleScrollView.h"
#import "DXOrgTool.h"
#import "RSCheckCaches.h"
#import "UIImageView+WebCache.h"
#import "DXMsgTool.h"
#import "RSTextHelper.h"
#import "DXSigleSelectViewController.h"
#import "RSFileHelp.h"
#import "UIImageView+DXWebCache.h"
#import "UniversityViewController.h"
#import "DXCfg.h"
#import "DXOtherTool.h"
@interface AssociationMainController (){
    int count;
    NSArray *arrayTempNow;
    NSString *type;
    UIButton *buttonTitle;
    NSMutableArray *arrayAll;
    NSMutableArray *arrayOrg;
}
@property (strong ,nonatomic) NSMutableDictionary *showArr;
@property (strong ,nonatomic) NSMutableArray *arrayAvt;
@property (nonatomic, weak) YYCycleScrollView *cycleScrollView;
@property (weak, nonatomic) UIView *viewButtonBackground;
@property (weak, nonatomic) UIButton *buttonRed;
@property (weak, nonatomic) UIButton *buttonYellow;
@property (weak, nonatomic) UIButton *buttonAttention;
@property (weak, nonatomic) UIButton *buttonRanking;

@end

@implementation AssociationMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrayTabBar = @[@"所有",@"资讯",@"活动"];
    [self setTitle];
    [self setTabBar];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshTableView) name:kNotificationPreferenceStatusChange object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeSchoolName:) name:kNotificationSchoolNameChange object:nil];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setLeftTitle:@""];
    if (buttonTitle==nil) {
        buttonTitle = [[UIButton alloc]initWithFrame:CGRectMake((ScreenWidth-self.viewSearchBar.width)/2-self.viewSearchBar.originX, 0, self.viewSearchBar.width, self.viewSearchBar.height)];
        [buttonTitle addTarget:self action:@selector(selectSchool) forControlEvents:UIControlEventTouchUpInside];
        if ([DXCfg readStringForKey:@"selectedScholl"].length==0) {
            [buttonTitle setTitle:@"所有学校" forState:UIControlStateNormal];
        }
        else{
            [buttonTitle setTitle:[DXCfg readStringForKey:@"selectedScholl"] forState:UIControlStateNormal];
        }
        
        buttonTitle.font = [UIFont boldSystemFontOfSize:19];
    }
    [self.viewSearchBar addSubview:buttonTitle];
}
-(void)setTitle{
    self.navigationController.title = @"呵呵";
}
- (void)selectSchool{
    [DXOtherTool getSchoolWithSuccess:^(NSArray *result) {
        NSArray *arr = result;
        DXSigleSelectViewController *controller = [[DXSigleSelectViewController alloc]init];
        controller.navigationTitle = @"选择学校";
        controller.dataSource = arr;
        controller.delegate = self;
        [self.navigationController pushViewController:controller animated:YES];
    } failure:^(NSError *error) {
        
    }];
//
//    NSString *schoolJson = [RSFileHelp getStringFromFile:@"School.json"];
    
}
#pragma mark 改变学校名字
- (void)changeValue:(NSString *)value{
    [DXCfg saveStringWithKey:@"selectedScholl" value:value];
    [buttonTitle setTitle:value forState:UIControlStateNormal];
    [self refresh:[self getCurrentTableView]];
}
#pragma mark 显示数组
-(NSMutableArray *)showArr{
    
    arrayAll = self.results[self.arrayTabBar[self.currentIndex%100]];
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    NSMutableArray *arrayTemp = [[NSMutableArray alloc]initWithArray:arrayAll];
    arrayOrg = [[NSMutableArray alloc]init];
    for (DXGetOrgMsgsItemModel *model in arrayTemp) {
        switch (self.currentIndex%100) {
            case 0:{
                if (model.Act!=nil) {
                    [array addObject:model.Act];
                }
                if (model.Msg!=nil) {
                    [array addObject:model.Msg];
                }
                break;
            }
            case 1:{
                if (model.Msg!=nil) {
                    [array addObject:model.Msg];
                }
                break;
            }
            case 2:{
                if (model.Act!=nil) {
                    [array addObject:model.Act];
                }
                break;
            }
        }
        [arrayOrg addObject:model.OrgInfo];
    }

    return array;
    
}
#pragma mark 刷新界面

- (void)refresh:(UITableView *)tableView{
    DXGetOrgMsgsParam *param = [self getParamWithOffset:0];
    NSString *cat = self.arrayTabBar[self.currentIndex%100];
    [DXOrgTool getOrgMsgWithParams:param success:^(DXGetOrgMsgsModel *result) {
        if (self.results==nil) {
            self.results = [NSMutableDictionary dictionary];
        }
        if (result.data==nil) {
            [self.results setValue:[NSArray array] forKey:cat];
        }
        else{
            [self.results setValue:result.data forKey:cat];
        }
        [tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
-(void)loadMoreData{
    [[self getCurrentTableView].footer endRefreshing];
    NSMutableArray *currentResult = self.results[self.arrayTabBar[self.currentIndex%100]];
    
    DXGetOrgMsgsParam *params = [self getParamWithOffset:(int)arrayAll.count];
    [DXOrgTool getOrgMsgWithParams:params success:^(DXGetOrgMsgsModel *result) {
        if (result.data!=nil) {
            [currentResult addObjectsFromArray:result.data];
        }
        [[self getCurrentTableView] reloadData];
    } failure:^(NSError *error) {
        DXLog(@"%@", error);
    }];
}
-(DXGetOrgMsgsParam *)getParamWithOffset:(int)offset{
    DXGetOrgMsgsParam *param = [[DXGetOrgMsgsParam alloc]init];
    param.status = 0;
    param.oid = 0;
    NSString *cat = self.arrayTabBar[self.currentIndex%100];
    switch (self.currentIndex%100) {
        case 1:
            param.type = @"msg";
            break;
        case 2:
            param.type = @"act";
            break;
        default:
            break;
    }
    param.offset = offset;
    param.limit = 10;
    if (![buttonTitle.titleLabel.text isEqualToString:@"所有学校"]) {
        param.school = buttonTitle.titleLabel.text;
    }
    return param;
}


- (void)setupCycleScrollView{
     UIView *viewButtonBackground = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 180 * ScreenRatio)];
    //图片浏览
    
    DXMsgAvtListParam *param = [[DXMsgAvtListParam alloc]init];
    param.avtType = @"msg";
    [DXMsgTool getAvtWithParams:param success:^(DXMsgAvtListModel *result) {
        self.arrayAvt = [NSMutableArray array];
        for (DXMsgAvtItemModel *model in result.data.msg) {
            [self.arrayAvt addObject:[NSString stringWithFormat:@"%@%@",DXNetworkAddress,model.L_PIC]];
        }
        YYCycleScrollView *view = [[YYCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 130 * ScreenRatio) animationDuration:3];
        [view setFetchContentViewAtIndex:^UIView *(NSInteger(pageIndex)) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 130 * ScreenRatio)];
            
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            [imageView sd_setImageWithURL_dx:self.arrayAvt[pageIndex] placeholderImage:[UIImage imageNamed:@"loading.jpg"]];            return imageView;
        }];
        
        [view setTotalPagesCount:^NSInteger{
            return self.arrayAvt.count;
        }];
        
        [viewButtonBackground addSubview:view];
        
        // 按钮
        CGFloat x = 30 * ScreenRatio;
        CGFloat margin = 20 * ScreenRatio;
        CGFloat wh = 50 * ScreenRatio;
        CGFloat y = 4 + CGRectGetMaxY(view.frame);
        
        UIButton *buttonAttention = [[UIButton alloc]initWithFrame:CGRectMake(x, y, wh, wh)];
        [buttonAttention addTarget:self action:@selector(attention:) forControlEvents:UIControlEventTouchUpInside];
        [buttonAttention setImage:[UIImage imageNamed:@"ic-26"] forState:UIControlStateNormal];
        [viewButtonBackground addSubview:buttonAttention];
        self.buttonAttention = buttonAttention;
        
        UIButton *buttonRanking = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(buttonAttention.frame) + margin, y, wh, wh)];
        [buttonRanking addTarget:self action:@selector(ranking:) forControlEvents:UIControlEventTouchUpInside];
        [buttonRanking setImage:[UIImage imageNamed:@"ic-27"] forState:UIControlStateNormal];
        [viewButtonBackground addSubview:buttonRanking];
        self.buttonRanking = buttonRanking;
        
        UIButton *buttonRed = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(buttonRanking.frame) + margin, y, wh, wh)];
        buttonRed.backgroundColor = [UIColor colorWithRed:0.988 green:0.412 blue:0.376 alpha:1.000];
        buttonRed.layer.cornerRadius = 20;
        buttonRed.clipsToBounds = YES;
        [viewButtonBackground addSubview:buttonRed];
        self.buttonRed = buttonRed;
        
        UIButton *buttonYellow = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(buttonRed.frame) + margin, y, wh, wh)];
        buttonYellow.backgroundColor = [UIColor colorWithRed:0.996 green:0.792 blue:0.329 alpha:1.000];
        buttonYellow.layer.cornerRadius = 20;
        buttonYellow.clipsToBounds = YES;
        [viewButtonBackground addSubview:buttonYellow];
        self.buttonYellow = buttonYellow;
        
        self.viewButtonBackground = viewButtonBackground;
        self.cycleScrollView = view;
        [self getCurrentTableView].tableHeaderView = viewButtonBackground;
    } failure:^(NSError *error) {
        
    }];
    
}

#warning 文字宽度可能有问题
-(void)resetTabBar{
    self.bar = [[RSTabBar alloc]initWithY:64 withTabTitleArr:self.arrayTabBar withClickCallBack:^(int tag){
        self.currentIndex = tag+100; //tag从100开始
        [self reloadCurrentTableView];
        switch (tag%100) {
            case 0:{
                //                [UIView animateWithDuration:0.25 animations:^{
                //                    [self setupCycleScrollView];
                //                }];
                break;
            }
            case 1:
            {
                type = @"msg";
                break;
            }
            case 2:
            {
                type = @"act";
                break;
            }
            default:{
                break;
            }
        }
        NSArray *result = self.results[self.arrayTabBar[self.currentIndex%100]];
        if (result==nil) {
            [self refresh:[self getCurrentTableView]];
        }
        [self reloadCurrentTableView];
        [self.tableViews setContentOffset:CGPointMake(ScreenWidth*(self.currentIndex%100), 0) animated:YES];
    }];
    [self.view addSubview:self.bar];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    arrayTempNow = [NSMutableArray arrayWithArray:self.showArr];
    return arrayTempNow.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AssociationCell *cell = (AssociationCell *)[tableView dequeueReusableCellWithIdentifier:@"AssociationCell" owner:self];
    //self.currentIndex从100开始；
    [cell setModel:arrayTempNow[indexPath.row] orgInfo:arrayOrg[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 230;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DXLog(@"缓存大小:%f",[RSCheckCaches folderSizeAtPath]);
    AssociationDetailViewController *detailViewController = [[AssociationDetailViewController alloc]initWithNibName:@"DXDetailViewController" bundle:nil];
    NSObject *tempModel = arrayTempNow[indexPath.row];
    if ([tempModel isKindOfClass:[DXGetOrgMsgsActModel class]]) {
        DXGetOrgMsgsActModel *model = (DXGetOrgMsgsActModel *)tempModel;
        detailViewController.model = model;
        detailViewController.LTARID = [NSString stringWithFormat:@"%ld",(long)model.Id]; //每条资讯id
        detailViewController.LTARGET = @"L_ACTIVITY"; // 评论类型
        detailViewController.html = model.LCONTENT;
        detailViewController.hTitle = model.LTITLE;
        detailViewController.L_INTRO = model.LINTRO;
        detailViewController.urlStr = [NSString stringWithFormat:@"%@/static/actDetail.html?id=%@",DXNetworkAddress,detailViewController.LTARID];
        detailViewController.type = @"act";
    }
    else if ([tempModel isKindOfClass:[DXGetOrgMsgsMsgModel class]]) {
        DXGetOrgMsgsMsgModel *model = (DXGetOrgMsgsMsgModel *)tempModel;
        
        detailViewController.model = model;
        detailViewController.LTARID = [NSString stringWithFormat:@"%ld",(long)model.Id]; //每条资讯id
        detailViewController.LTARGET = @"L_MESSAGE"; // 评论类型
        detailViewController.html = model.LCONTENT;
        detailViewController.hTitle = model.LTITLE;
        detailViewController.L_INTRO = model.LINTRO;
        detailViewController.urlStr = [NSString stringWithFormat:@"%@/static/webview.html?id=%@",DXNetworkAddress,detailViewController.LTARID];
        detailViewController.type = @"msg";
    }
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}

//- (IBAction)attention:(UIButton *)sender {
//    AssociationAttentionController *attentionVc = [[AssociationAttentionController alloc]initWithNibName:@"AssociationAttentionController" bundle:nil];
//    [self.navigationController pushViewController:attentionVc animated:YES];
//}
//
//- (IBAction)ranking:(UIButton *)sender {
//    AssocaitonRankingListController *rankingListVc = [[AssocaitonRankingListController alloc]init];
//    [self.navigationController pushViewController:rankingListVc animated:YES];
//}

-(void)searchStart{
    UniversityViewController *universityViewController = [[UniversityViewController alloc]init];
    universityViewController.query = buttonTitle.titleLabel.text;
    [self.navigationController pushViewController:universityViewController animated:YES];
    self.navigationItem.titleView = nil;
    
}


@end
