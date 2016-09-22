//
//  GiftMainController.m
//  DXQ
//
//  Created by 做功课 on 15/7/22.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import "GiftMainController.h"
#import "GiftCell.h"
#import "RSTabBar.h"
#import "MJRefresh.h"
#import "GiftDetailViewController.h"
#import "DXGiftTool.h"
#import "RSCheckCaches.h"
#import "PrintObject.h"
#import "DXOtherTool.h"
#import "DXCfg.h"
@interface GiftMainController (){
    int count;
    NSMutableArray *arrayGift;
    NSMutableDictionary *results;
}

@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;
@end

@implementation GiftMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.arrayTabBar = @[@"最新",@"最热",@"精选",@"科技范",@"萌属性",@"美物",@"DIY"];
    self.tabBarStr = @"spcBarArr";
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshTableView) name:kNotificationPreferenceStatusChange object:nil];
    [self setTabBar];
    
}
-(void)loadMoreData{
    [[self getCurrentTableView].footer endRefreshing];
    
    
    NSMutableArray *currentResult = results[self.arrayTabBar[self.self.currentIndex%100]];

    DXGetGiftsParam *params = [self getParamWithSearchText:self.searchText offset:(int)currentResult.count];
    
    [DXGiftTool getGiftsWithParams:params success:^(DXGetGiftsModel *result) {
        if (result.data!=nil) {
            [currentResult addObjectsFromArray:result.data];
        }
        [[self getCurrentTableView] reloadData];
    } failure:^(NSError *error) {
        
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.navigationItem.titleView = nil;
    [self refreshTableView];
    [DXOtherTool getLabelWithUrl:@"spclabel" withSuccess:^(NSArray *result) {
        NSMutableArray *finalArr = [NSMutableArray array];
        for (NSDictionary *model in result) {
            [finalArr addObject:[model objectForKey:@"LVALUE"]];
        }
        NSArray *spcBarArr = (NSArray *)[DXCfg readObjectForKey:@"spcBarArr"];
        BOOL isSame = YES;
        for (int i=0; i<[spcBarArr count]; i++) {
            if (i<[finalArr count]) {
                if (![finalArr[i] isEqualToString:spcBarArr[i]]) {
                    isSame = NO;
                }
            }
        }
        if (spcBarArr==nil||!isSame) {
            [DXCfg saveObjectWithKey:@"spcBarArr" value:finalArr];
            [self setTabBar];
        }
    } failure:^(NSError *error) {
        
    }];
    
}
-(DXGetGiftsParam *)getParamWithSearchText:(NSString *)search offset:(int)offset{
    DXGetGiftsParam *params = [[DXGetGiftsParam alloc]init];
    
    
    params.offset = offset;
    params.limit = 10;
    
    params.search = @"";
    
    
    if (search.length!=0) {
        params.search = search;
    }
    else{
        params.search = @"";
    }
    
    NSString *cat = self.arrayTabBar[self.currentIndex%100];
    if ([cat isEqualToString:@"最新"]) {
        
    }else if([cat isEqualToString:@"最热"]){
        params.order = @"hot";
    }else{
        params.cat = self.arrayTabBar[self.currentIndex%100];//tag 从100开始
    }
    return params;
    
    
}


- (void)refresh:(UITableView *)tableView{
    
    
    DXGetGiftsParam *param = [self getParamWithSearchText:self.searchText offset:0];
    NSString *cat = self.arrayTabBar[self.currentIndex%100];
    [DXGiftTool getGiftsWithParams:param success:^(DXGetGiftsModel *result) {
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    arrayGift = results[self.arrayTabBar[self.currentIndex%100]];
    return arrayGift.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    DXLog(@"缓存大小:%f",[RSCheckCaches folderSizeAtPath]);
    GiftDetailViewController *giftDetailViewController = [[GiftDetailViewController alloc]initWithNibName:@"DXDetailViewController" bundle:nil];
    DXGetGiftsItemModel *model = arrayGift[indexPath.row];
    giftDetailViewController.model = model;
    giftDetailViewController.LTARID = model.L_ID;
    giftDetailViewController.hTitle = model.L_SPECIAL_NAME;
    giftDetailViewController.L_INTRO = model.L_INTRO;
    giftDetailViewController.LTARGET = @"L_SPECIAL";
    giftDetailViewController.urlStr = [NSString stringWithFormat:@"%@/static/spcDetail.html?id=%@",DXNetworkAddress,giftDetailViewController.LTARID];
    [self.navigationController pushViewController:giftDetailViewController animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GiftCell *cell = (GiftCell *)[tableView dequeueReusableCellWithIdentifier:@"GiftCell" owner:self];
    [cell setModel:arrayGift[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130*ScreenRatio;
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    
    self.searchText = searchBar.text;
    
    
    DXGetGiftsParam *params = [self getParamWithSearchText:searchBar.text offset:0];
    
    NSString *cat = self.arrayTabBar[self.currentIndex%100];
    
    [DXGiftTool getGiftsWithParams:params success:^(DXGetGiftsModel *result) {
        if (results==nil) {
            results = [NSMutableDictionary dictionary];
        }
        [results setValue:result.data forKey:cat];
        
        [self reloadCurrentTableView];

    } failure:^(NSError *error) {
        DXLog(@"%@", error);
    }];
}


- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    if(searchBar.text.length==0){
        searchBar.hidden = YES;
        self.searchText = @"";
    }
}

@end
