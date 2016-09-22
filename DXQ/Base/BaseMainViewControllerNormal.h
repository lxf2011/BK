//
//  BaseMainViewControllerNormal.h
//  DXQ
//
//  Created by rason on 15/9/16.
//  Copyright © 2015年 rason. All rights reserved.
//

#import "BaseViewControllerNormal.h"
#import "RSTabBar.h"
#import "RSScrollView.h"
#import "TestView.h"
@interface BaseMainViewControllerNormal : BaseViewControllerNormal<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSString *searchText;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIView *viewSearchBar;

@property (nonatomic, strong) RSTabBar *bar;
@property (nonatomic, strong) RSScrollView *tableViews;
@property (nonatomic, strong) TestView *leftView;//左边位置禁止滚动
@property (nonatomic, strong) UIView *navigationBar;

@property (nonatomic, strong) NSString*tabBarStr;//取得网络标签参数
@property (nonatomic, strong) NSArray *arrayTabBar;//标签字符数组
@property (nonatomic, strong) NSMutableDictionary *results;//所有数据字典
@property int currentIndex;//标签点击位置
@property (nonatomic, strong) NSMutableDictionary *tableViewsDic;//所有tableview的字典
@property (nonatomic, strong) NSMutableArray *tableViewArray;
@property int currentPage;//当前页
@property BOOL indexIsChange;//判断是否跳到另一页

-(void)setLeftTitle:(NSString *)title;
-(void)openSideMenu;
-(UIView *)newTableView;
-(UITableView *)getCurrentTableView;
-(void)reloadCurrentTableView;
-(void)refresh:(UITableView *)tableView;
-(void)resetTabBar;//重设标签栏
-(void)setTabBar;
-(void)readStringToArrayTabBar:(NSString *)string;//读取标签记录
-(void)refreshTableView;//刷新当前tableview
@end
