//
//  ActivityMainController.m
//  DXQ
//
//  Created by 做功课 on 15/7/22.
//  Copyright (c) 2015年 rason. All rights reserved.
//


#import "ActivityMainController.h"
#import "ActivityCell.h"
#import "RSTabBar.h"
#import "MJRefresh.h"
#import "ActivityDetailViewController.h"
#import "DXActTool.h"
#import "DXOtherTool.h"
#import "DXCfg.h"
@interface ActivityMainController () <UITableViewDataSource, UITableViewDelegate>
{
    int count;
    NSMutableArray *arrayAct;
    NSMutableDictionary *results;
    
}

@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;
@end

@implementation ActivityMainController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.tabBarStr = @"actBarArr";
    self.arrayTabBar = @[@"最新",@"最热",@"电影",@"校园",@"旅行",@"娱乐",@"户外"];//setTabBar的方法中可能覆盖
    [self setTabBar];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshTableView) name:kNotificationPreferenceStatusChange object:nil];

}
-(void)loadMoreData{
    [[self getCurrentTableView].footer endRefreshing];
    NSMutableArray *currentResult = results[self.arrayTabBar[self.currentIndex%100]];
    
    DXGetActivityParam *params = [self getGetActivityParamWithSearchText:self.searchText offset:currentResult.count];

    
    
    
    [DXActTool getActWithParams:params success:^(DXGetActivityModel *result) {
        if (result.data!=nil) {
            [currentResult addObjectsFromArray:result.data];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.navigationItem.titleView = nil;
    [DXOtherTool getLabelWithUrl:@"actlabel" withSuccess:^(NSArray *result) {
        NSMutableArray *finalArr = [NSMutableArray array];
        for (NSDictionary *model in result) {
            [finalArr addObject:[model objectForKey:@"LVALUE"]];
        }
        NSArray *actBarArr = (NSArray *)[DXCfg readObjectForKey:@"actBarArr"];
        BOOL isSame = YES;
        for (int i=0; i<[actBarArr count]; i++) {
            if (i<[finalArr count]) {
                if (![finalArr[i] isEqualToString:actBarArr[i]]) {
                    isSame = NO;
                }
            }
        }
        if (actBarArr==nil||!isSame) {
            [DXCfg saveObjectWithKey:@"actBarArr" value:finalArr];
            [self setTabBar];
        }
    } failure:^(NSError *error) {
        
    }];
    
}
-(DXGetActivityParam *)getGetActivityParamWithSearchText:(NSString *)search offset:(int)offset{
    DXGetActivityParam *param = [[DXGetActivityParam alloc]init];
    
    param.offset = offset;
    param.limit = 10;
    if (search.length!=0) {
        param.search = search;
    }
    else{
        param.search = @"";
    }
    
    NSString *cat = self.arrayTabBar[self.currentIndex%100];
    if ([cat isEqualToString:@"最新"]) {
        
    }else if([cat isEqualToString:@"最热"]){
        param.order = @"hot";
    }else{
        param.cat = self.arrayTabBar[self.currentIndex%100];//tag 从100开始
    }
    return param;
}
- (void)refresh:(UITableView *)tableView{
    DXGetActivityParam *param = [self getGetActivityParamWithSearchText:self.searchText offset:0];
    NSString *cat = self.arrayTabBar[self.currentIndex%100];
    
    [DXActTool getActWithParams:param success:^(DXGetActivityModel *result) {
        if (results==nil) {
            results = [NSMutableDictionary dictionary];
        }
        if (result.data==nil) {
            [results setValue:[NSMutableArray array] forKey:cat];
        }
        else{
            [results setValue:[NSMutableArray arrayWithArray:result.data] forKey:cat];
        }
        [tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - Table view data source
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    ActivityDetailViewController *activityDetailViewController = [[ActivityDetailViewController alloc]initWithNibName:@"DXDetailViewController" bundle:nil];
    DXGetActivityItemModel *model = arrayAct[indexPath.row];
    activityDetailViewController.model = model;
    activityDetailViewController.hTitle = model.L_TITLE;
    activityDetailViewController.LTARID = model.L_ID;
    activityDetailViewController.LTARGET = @"L_ACTIVITY";
    activityDetailViewController.L_INTRO = model.L_INTRO;
    activityDetailViewController.html = model.L_CONTENT;
    activityDetailViewController.urlStr = [NSString stringWithFormat:@"%@/static/actDetail.html?id=%@",DXNetworkAddress,activityDetailViewController.LTARID];
    [self.navigationController pushViewController:activityDetailViewController animated:YES];
    
    //点击量
    model.L_CLICK = [NSString stringWithFormat:@"%d",[model.L_CLICK intValue]+1];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    arrayAct = results[self.arrayTabBar[self.currentIndex%100]];
    return arrayAct.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ActivityCell *cell = (ActivityCell *)[tableView dequeueReusableCellWithIdentifier:@"ActivityCell" owner:self];
    [cell setModel:arrayAct[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 170;
    
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    self.searchText = searchBar.text;
    DXGetActivityParam *param = [self getGetActivityParamWithSearchText:searchBar.text offset:0];

    NSString *cat = self.arrayTabBar[self.currentIndex%100];
    [DXActTool getActWithParams:param success:^(DXGetActivityModel *result) {
        if (results==nil) {
            results = [NSMutableDictionary dictionary];
        }
        if (result.data==nil) {
            [results setValue:[NSMutableArray array] forKey:cat];
        }
        else{
            [results setValue:[NSMutableArray arrayWithArray:result.data] forKey:cat];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    if(searchBar.text.length==0){
        searchBar.hidden = YES;
        self.searchText = @"";
    }
}
@end

