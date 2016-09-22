//
//  InformationMainController.m
//  DXQ
//
//  Created by rason on 8/3/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "InformationMainController.h"
#import "InformationCell.h"
#import "RSTabBar.h"
#import "YYCycleScrollView.h"
#import "MJRefresh.h"
#import "InformationDetailViewController.h"
#import "RSCheckCaches.h"
#import "DXMsgTool.h"
#import "PrintObject.h"
#import "SDWebImageDownloader.h"
#import "UIImageView+WebCache.h"
#import "DXLoginHelp.h"
#import "DXAuthTool.h"
#import "DXNavigationController.h"
#import "MainTabBarController.h"
#import "UIImageView+DXWebCache.h"
#import "DXOtherTool.h"
#import "ZXOperatePlist.h"
#import "DXCfg.h"
#import "RSScrollView.h"
#import "RSTouMingUIView.h"
#import "SYShareCollectionView.h"
#define deheight 44
@interface InformationMainController () <UISearchBarDelegate>{
    NSString *IdentifierInformationCell;
    int count;
    
    NSMutableArray *arrayMsg;
    UIBarButtonItem *rightBarButtonItem;
    NSArray *leftBarButtonItems;
    

}

@property (strong, nonatomic) NSMutableArray *arrayModelCycleScrollView;
@property (strong, nonatomic) NSMutableArray *arrayAvt;

@property (nonatomic, weak) YYCycleScrollView *cycleScrollView;

@end

@implementation InformationMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrayTabBar = @[@"推荐",@"最热",@"搞笑",@"娱乐",@"美食",@"其他"];//setTabBar的方法中可能覆盖
    self.tabBarStr = @"msgBarArr";
    
//    [DXLoginHelp autologinTest];
    
    
    [self setTabBar];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshTableView) name:kNotificationPreferenceStatusChange object:nil];
    //不要把下面删除了，有登录的必须让登录请求先跑，不然会出问题
    [DXLoginHelp restoreState:^{
        [self setPicScrollViewToTableView:[self.tableViewsDic objectForKey:@"0"]];
        [self reloadCurrentTableView];
    } :^{
        [self setPicScrollViewToTableView:[self.tableViewsDic objectForKey:@"0"]];
        [self reloadCurrentTableView];
    }];
    NSString *userName = [[NSUserDefaults standardUserDefaults]stringForKey:@"userName"];
    if(userName.length==0){
        [self setPicScrollViewToTableView:[self.tableViewsDic objectForKey:@"0"]];
        [self reloadCurrentTableView];
    }
    
    //获取配置信息
    [DXOtherTool getConfigWithSuccess:^(NSDictionary *result) {
        for (NSString *key in result.keyEnumerator) {
            NSString *value = result[key];
            [DXCfg saveStringWithKey:key value:value];
        }
    } failure:^(NSError *error) {
        
    }];
    
//    UITableView *tableView = self.tableViewsDic[[NSString stringWithFormat:@"%d",currentPage]];
//    [self followScrollView:tableView];
    

    
    
}



-(void)loadMoreData{
    [[self getCurrentTableView].footer endRefreshing];
    
    NSMutableArray *currentResult = self.results[self.arrayTabBar[self.currentIndex%100]];
    
    
    DXMsgListParam *params = [self getParamWithSearchText:self.searchText offset:(int)currentResult.count];
    
    [DXMsgTool getMsgByCatWithParams:params success:^(DXMsgListModel *result) {
        if (result.data!=nil) {
            [currentResult addObjectsFromArray:result.data];
        }
        
        [[self getCurrentTableView] reloadData];
    } failure:^(NSError *error) {
        DXLog(@"%@", error);
    }];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.tabBarController.navigationItem.titleView = nil;
    
    [self refreshTableView];
    [DXOtherTool getLabelWithUrl:@"msglabel" withSuccess:^(NSArray *result) {
        NSMutableArray *finalArr = [NSMutableArray array];
        for (NSDictionary *model in result) {
            [finalArr addObject:[model objectForKey:@"LVALUE"]];
        }
        NSArray *msgBarArr = (NSArray *)[DXCfg readObjectForKey:@"msgBarArr"];
        BOOL isSame = YES;
        for (int i=0; i<[msgBarArr count]; i++) {
            if (i<[finalArr count]) {
                if (![finalArr[i] isEqualToString:msgBarArr[i]]) {
                    isSame = NO;
                }
            }
        }
        if (msgBarArr==nil||!isSame) {
            [DXCfg saveObjectWithKey:@"msgBarArr" value:finalArr];
            [self setTabBar];
        }
    } failure:^(NSError *error) {
        
    }];
//    [self searchStart];
//    if (self.isNowDown) {
//        self.navigationController.navigationBar.hidden = NO;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.tabBarController.navigationItem.leftBarButtonItems = leftBarButtonItems;
//            self.tabBarController.navigationItem.rightBarButtonItem = rightBarButtonItem;
//        });
//        
//        [self.view setY:0];
//        [self.view setHeight:[UIScreen mainScreen].bounds.size.height];
//        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//
//    }
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}
-(DXMsgListParam *)getParamWithSearchText:(NSString *)search offset:(int)offset{
    DXMsgListParam *param = [[DXMsgListParam alloc]init];
    param.offset = offset;
    param.limit = 10;
    
    param.search = @"";
    if (search.length!=0) {
        param.search = search;
    }
    else{
        param.search = @"";
    }
    
    NSString *cat = self.arrayTabBar[self.currentIndex%100];
    if ([cat isEqualToString:@"推荐"]) {
        
    }else if([cat isEqualToString:@"最热"]){
        param.order = @"hot";
    }else{
        param.cat = self.arrayTabBar[self.currentIndex%100];//tag 从100开始
    }
    return param;
}

#pragma mark - 初始化

-(void)refresh:(UITableView *)tableView{
    DXMsgListParam *params = [self getParamWithSearchText:self.searchText offset:0];
    NSString *cat = self.arrayTabBar[self.currentIndex%100];
    [DXMsgTool getMsgByCatWithParams:params success:^(DXMsgListModel *result) {
        if (self.results==nil) {
            self.results = [NSMutableDictionary dictionary];
        }
        if (result.data==nil) {
            [self.results setValue:[NSMutableArray array] forKey:cat];
        }
        else{
            [self.results setValue:[NSMutableArray arrayWithArray:result.data] forKey:cat];
        }
        [tableView reloadData];
    } failure:^(NSError *error) {
        DXLog(@"%@", error);
    }];
    if(tableView.tag==0){
        [self setPicScrollViewToTableView:[self.tableViewsDic objectForKey:@"0"]];
    }
}

-(void)setPicScrollViewToTableView:(UITableView *)tableView{
    DXMsgAvtListParam *param = [[DXMsgAvtListParam alloc]init];
    param.avtType = @"msg";
    [DXMsgTool getAvtWithParams:param success:^(DXMsgAvtListModel *result) {
        self.arrayAvt = [NSMutableArray array];
        self.arrayModelCycleScrollView = [NSMutableArray array];
        for (DXMsgAvtItemModel *model in result.data.msg) {
            [self.arrayModelCycleScrollView addObject:model];
            [self.arrayAvt addObject:model.L_PIC];
        }
        if (self.cycleScrollView==nil) {
            self.cycleScrollView = [[YYCycleScrollView alloc]initWithFrame:CGRectMake(0,30, ScreenWidth, 150*ScreenRatio) animationDuration:3];
        }
        
        [self.cycleScrollView setFetchContentViewAtIndex:^UIView *(NSInteger(pageIndex)) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, ScreenWidth, 150*ScreenRatio)];
            
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            [imageView sd_setImageWithURL_dx:self.arrayAvt[pageIndex] placeholderImage:[UIImage imageNamed:@"loading.jpg"]];
            
            return imageView;
        }];
        [self.cycleScrollView setTapActionBlock:^(NSInteger pageIndex) {
            DXMsgAvtItemModel *model = self.arrayModelCycleScrollView[pageIndex];
            InformationDetailViewController *informationDetailViewController = [[InformationDetailViewController alloc]initWithNibName:@"DXDetailViewController" bundle:nil];
            informationDetailViewController.model = model;
            informationDetailViewController.LTARID = model.L_OID; //每条资讯id
            informationDetailViewController.LTARGET = @"L_MESSAGE"; // 评论类型
            informationDetailViewController.L_INTRO = model.L_TITLE;
//            informationDetailViewController.html = model.L_CONTENT;
            informationDetailViewController.urlStr = [NSString stringWithFormat:@"%@/static/webview.html?id=%@",DXNetworkAddress,model.L_OID];
            informationDetailViewController.hTitle = model.L_TITLE;
            [self.navigationController pushViewController:informationDetailViewController animated:YES];
            
        }];
        [self.cycleScrollView setTotalPagesCount:^NSInteger{
            return self.arrayAvt.count;
        }];
        tableView.tableHeaderView = self.cycleScrollView;
        self.cycleScrollView.hidden = NO;
    } failure:^(NSError *error) {
        
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    arrayMsg = self.results[self.arrayTabBar[self.currentIndex%100]];
    return [arrayMsg count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier=@"InformationCell";
    InformationCell *cell = (InformationCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier owner:self];
    DXMsgItemModel *model = arrayMsg[indexPath.row];
    [cell setModel:model];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    DXLog(@"缓存大小:%f",[RSCheckCaches folderSizeAtPath]);
    InformationDetailViewController *informationDetailViewController = [[InformationDetailViewController alloc]initWithNibName:@"DXDetailViewController" bundle:nil];
    
    DXMsgItemModel *model = arrayMsg[indexPath.row];
    informationDetailViewController.model = model;
    informationDetailViewController.LTARID = model.L_ID; //每条资讯id
    informationDetailViewController.LTARGET = @"L_MESSAGE"; // 评论类型
    informationDetailViewController.html = model.L_CONTENT;
    informationDetailViewController.hTitle = model.L_TITLE;
    informationDetailViewController.L_INTRO = model.L_INTRO;
    informationDetailViewController.urlStr = [NSString stringWithFormat:@"%@/static/webview.html?id=%@",DXNetworkAddress,model.L_ID];
    [self.navigationController pushViewController:informationDetailViewController animated:YES];
    
    //点击量
    model.L_CLICK = [NSString stringWithFormat:@"%d",[model.L_CLICK intValue]+1];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 130;
    
}




#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    
    self.searchText = searchBar.text;
    DXMsgListParam *params = [self getParamWithSearchText:searchBar.text offset:0];
    
    NSString *cat = self.arrayTabBar[self.currentIndex%100];
    
    [DXMsgTool getMsgByCatWithParams:params success:^(DXMsgListModel *result) {
        if (self.results==nil) {
            self.results = [NSMutableDictionary dictionary];
        }
        [self.results setValue:result.data forKey:cat];
        
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
