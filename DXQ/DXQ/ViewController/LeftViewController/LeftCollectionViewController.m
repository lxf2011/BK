//
//  LeftCollectionViewController.m
//  DXQ
//
//  Created by 做功课 on 15/8/7.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import "LeftCollectionViewController.h"
#import "ImageButton.h"
#import "UniversityViewController.h"
#import "RSTabBar.h"
#import "MJRefresh.h"
#import "LeftCollectionCell.h"
#import "DXCollectionTool.h"
#import "InformationMainController.h"
#import "InformationDetailViewController.h"
#import "GiftDetailViewController.h"
#import "ActivityDetailViewController.h"
#import "AssociationDetailViewController.h"
@interface LeftCollectionViewController (){
    int currentIndex;
    NSArray *arrayTabBar;
    NSArray *arrayCollect;
    int currentOffset;
}
@property (nonatomic, weak) RSTabBar *tabBar;
@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;
@end

@implementation LeftCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavBtn];
    [self setupTabBar];
    self.tableView.tableFooterView = [UIView new];
    
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    

    [self refresh:0];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refresh) name:kNotificationCollectStatusChange object:nil];
}
-(void)loadMoreData{
    [self.tableView.footer endRefreshing];
    [self refresh:currentOffset+10];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)refresh:(int )offset{
    DXCollectionParam *param = [[DXCollectionParam alloc]init];
    param.cat = arrayTabBar[currentIndex%100]; //从100开始
    param.offset = offset;
    param.limit = 10;
    [DXCollectionTool getCollectionWithParams:param success:^(DXCollectionModel *model) {
        currentOffset = offset;
        if (offset!=0) {
            arrayCollect = [arrayCollect arrayByAddingObjectsFromArray:model.data];
        }
        else{
            arrayCollect = model.data;
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (arrayCollect.count==0) {
        self.centerImageView.hidden = NO;
        self.tableView.hidden = YES;
    }
    else{
        self.centerImageView.hidden = YES;
        self.tableView.hidden = NO;
    }
    return arrayCollect.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LeftCollectionCell *cell = [LeftCollectionCell cellWithTableView:tableView];
    [cell setModel:arrayCollect[indexPath.row] cat:arrayTabBar[currentIndex%100]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    NSArray *arrayClass = [[NSArray alloc] initWithObjects:[InformationDetailViewController class],[ActivityDetailViewController class],[GiftDetailViewController class],[AssociationDetailViewController class],nil];
    DXDetailViewController *detailViewController = [[arrayClass[currentIndex%100] alloc]initWithNibName:@"DXDetailViewController" bundle:nil];
    
    DXCollectionItemModel *model = arrayCollect[indexPath.row];
    detailViewController.LTARID = model.L_ID; //每条资讯id
    NSArray *array = @[@"L_MESSAGE", @"L_ACTIVITY", @"L_SPECIAL"];
    detailViewController.LTARGET = array[(currentIndex%100)%3]; // 评论类型
    detailViewController.html = model.L_CONTENT;
    detailViewController.hTitle = model.L_TITLE;
    detailViewController.model = model;
    if ([arrayTabBar[currentIndex%100]isEqualToString:@"精品"]) {
        detailViewController.urlStr = [NSString stringWithFormat:@"%@/static/spcDetail.html?id=%@",DXNetworkAddress,detailViewController.LTARID];

    }
    [self.navigationController pushViewController:detailViewController animated:YES];
}
#pragma mark - 手势
- (void)setupGesture{
    self.leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    
    self.leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    self.rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:self.leftSwipeGestureRecognizer];
    [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];
}

- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    // 左加右减。。
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        // tag 0-100为系统保留，故按钮的tag加上100
        if (currentIndex == 100+arrayTabBar.count) {
            return;
        }
        currentIndex = (currentIndex%100 + 1) % arrayTabBar.count + 100;
        UIButton *btn = (UIButton *)[self.tabBar viewWithTag:currentIndex];
        [btn sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        // tag 0-100为系统保留，故按钮的tag加上100
        if (currentIndex == 100) {
            return;
        }
        currentIndex = (currentIndex%100 - 1) % arrayTabBar.count + 100;
        UIButton *btn = (UIButton *)[self.tabBar viewWithTag:currentIndex];
        [btn sendActionsForControlEvents:UIControlEventTouchUpInside];
        
    }
}


#pragma mark--设置导航栏的按钮
-(void)setNavBtn
{
    [self setLeftBarButtonItem:@"我的收藏"];
}

- (void)setupTabBar{
    arrayTabBar = @[@"资讯", @"活动", @"精品", @"社团"];
    RSTabBar *tabBar = [[RSTabBar alloc]initWithY:64 withTabTitleArr:arrayTabBar withClickCallBack:^(int tag) {
        currentIndex = tag; // tag从100开始
        [self refresh:0];
    
    }];
    [self.view addSubview:tabBar];
    self.tabBar = tabBar;
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
