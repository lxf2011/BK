//
//  BaseMainViewControllerNormal.m
//  DXQ
//
//  Created by rason on 15/9/16.
//  Copyright © 2015年 rason. All rights reserved.
//

#import "BaseMainViewControllerNormal.h"
#import "DXLoginHelp.h"
#import "UIImageView+WebCache.h"
#import "RSTextHelper.h"
#import "ImageButton.h"
#import "MainTabBarController.h"
#import "UIImageView+DXWebCache.h"
#import "DXCfg.h"
#import "MJRefreshNormalHeader.h"
#import "MJRefreshBackNormalFooter.h"
#import "TestView.h"
@interface BaseMainViewControllerNormal (){
    UIImageView *imageViewHead;
    UILabel *leftTitle;
}

@end

@implementation BaseMainViewControllerNormal

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentIndex = 0;
    self.indexIsChange = YES;
    self.currentPage = 0;
    
    [self setNavBtn];
    self.hideOrShow = ^(BOOL isHide){
        if (isHide) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.1];
            self.navigationBar.hidden = YES;
            [self.bar setY:20];
            [self.tableViews setY:self.bar.originY +self.bar.height];
            [self.tableViews setHeight:ScreenHeight-49-self.tableViews.originY];
            for (UITableView *tableView in self.tableViews.subviews) {
                if ([tableView isKindOfClass:[UITableView class]]) {
                    [tableView setHeight:self.tableViews.height];
                }
            }
            [self.leftView setY:self.tableViews.originY];
            [self.leftView setHeight:self.tableViews.height];
            [UIView commitAnimations];
        }
        else{
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.1];
            self.navigationBar.hidden = NO;
            [self.navigationBar setY:20];
            [self.bar setY:64];
            [self.tableViews setY:self.bar.originY +self.bar.height];
            [self.tableViews setHeight:ScreenHeight-49-self.tableViews.originY];
            for (UITableView *tableView in self.tableViews.subviews) {
                if ([tableView isKindOfClass:[UITableView class]]) {
                    [tableView setHeight:self.tableViews.height];
                }
            }
            [self.leftView setY:self.tableViews.originY];
            [self.leftView setHeight:self.tableViews.height];
            [UIView commitAnimations];
        }
        
        
    };

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(UITableView *)getCurrentTableView{
    return [self.tableViewsDic objectForKey:[NSString stringWithFormat:@"%d",self.currentIndex%100]];
}
-(void)reloadCurrentTableView{
    [[self getCurrentTableView] reloadData];
}
-(void)refresh:(UITableView *)tableView{
    
}
-(UIView *)newTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 104, ScreenWidth, ScreenHeight-104-49)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tableFooterView = [[UIView alloc]init];
    return tableView;
}

-(void)resetTabBar{
    self.bar = [[RSTabBar alloc]initWithY:64 withTabTitleArr:self.arrayTabBar withClickCallBack:^(int tag){
        self.currentIndex = tag +100; // tag 从100开始
        
        [self reloadCurrentTableView];
        NSArray *result = self.results[self.arrayTabBar[self.currentIndex%100]];
        if (result==nil) {
            [self refresh:[self getCurrentTableView]];
        }
        [self reloadCurrentTableView];
        [self.tableViews setContentOffset:CGPointMake(ScreenWidth*(self.currentIndex%100), 0) animated:YES];
    }];
    [self.view addSubview:self.bar];
}
-(void)setScrollView:(NSArray *)tableViewsArray{
    self.tableViews = [[RSScrollView alloc]initWithFrame:CGRectMake(0, 104, ScreenWidth, ScreenHeight-104-49)];
    self.tableViews.delegate = self;
    
    
    [self.tableViews initUI:tableViewsArray];
    [self.view addSubview:self.tableViews];
    self.leftView = [[TestView alloc]initWithFrame:CGRectMake(0, 104, 30, ScreenHeight-104-49)];
    self.leftView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:self.leftView];
//    self.leftView.tableViews = self.tableViews;
//    self.leftView.userInteractionEnabled = YES;
//
    [self.tableViews addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
}

-(void)setTabBar{
    [self readStringToArrayTabBar:self.tabBarStr];
    [self resetTabBar];
    int i = 0;
    UITableView *tableView = [self newTableView];
    if (self.tableViewsDic==nil) {
        self.tableViewsDic = [NSMutableDictionary dictionary];
    }
    [self.tableViewsDic setObject:tableView forKey:[NSString stringWithFormat:@"%d",i]];
    tableView.tag = i;
    [self refresh:tableView];
    tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self refresh:tableView];
        [tableView.header endRefreshing];
    }];
    tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    i++;
    
    for (int j=i; j<[self.arrayTabBar count]; j++) {
        UITableView *tempTableView = [self newTableView];
        tempTableView.tag = i;
        tempTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            [self refresh:tempTableView];
            [tempTableView.header endRefreshing];
        }];
        tempTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        
        
        [self.tableViewsDic setObject:tempTableView forKey:[NSString stringWithFormat:@"%d",j]];
    }
    self.tableViewArray = [NSMutableArray array];
    for (int j=0; j<[self.arrayTabBar count]; j++) {
        [self.tableViewArray addObject:[self.tableViewsDic objectForKey:[NSString stringWithFormat:@"%d",j]]];
    }
    [self setScrollView:self.tableViewArray];
    
};
#pragma mark 刷新界面
-(void)refreshTableView{
    [self reloadCurrentTableView];
}
-(void)readStringToArrayTabBar:(NSString *)string{
    NSArray *barArr = (NSArray *)[DXCfg readStringForKey:string];
    
    if (barArr!=nil&&barArr.count>0) {
        self.arrayTabBar = barArr;
    }
}
#pragma mark--设置导航栏的按钮
-(void)setNavBtn
{
    _navigationBar = [[UIView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 44)];
    
    
    //导航栏图标
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"btn_sz"]];
//    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:imageView];
    
    //    UIView *redView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    //    redView.backgroundColor = [UIColor redColor];
    [imageView setY:(_navigationBar.height-imageView.image.size.height)/2];
    
    [_navigationBar addSubview:imageView];
    [self.view addSubview:_navigationBar];
    //导航栏头像
    imageViewHead = [[UIImageView alloc]initWithFrame:CGRectMake(imageView.image.size.width+8,(44-32)/2.0, 32, 32)];
    imageViewHead.layer.cornerRadius = imageViewHead.width/2;
    imageViewHead.layer.masksToBounds = YES;
    [imageViewHead sd_setImageWithURL_dx:[DXLoginHelp sharedInstance].head placeholderImage:[UIImage imageNamed:@"nan"]];
    [[DXLoginHelp sharedInstance] addObserver:self forKeyPath:@"head" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    [_navigationBar addSubview:imageViewHead];
    
    //导航栏标题
    leftTitle = [[UILabel alloc]initWithFrame:CGRectMake(imageViewHead.originX+imageViewHead.width+8, (44-30)/2.0, 320, 44)];
    leftTitle.font = DXNavFont;
    leftTitle.textColor = [UIColor whiteColor];
    leftTitle.text = @"布可";
    [RSTextHelper labelHandleWithModeWordWrap:leftTitle];
    [leftTitle setY:(44-leftTitle.height)/2.0];
    [_navigationBar addSubview:leftTitle];
    
    
    
    //打开左侧事件
    UIButton *buttonOpenSide = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, leftTitle.originX+leftTitle.width, 44)];
    [buttonOpenSide addTarget:self action:@selector(openSideMenu) forControlEvents:UIControlEventTouchUpInside];
    [_navigationBar addSubview:buttonOpenSide];
    
    //右边搜索
    UIButton *rightBtn = [[UIButton alloc]init];
    [rightBtn setImage:[UIImage imageNamed:@"zx_-33"] forState:UIControlStateNormal];
    CGRect rightBtnFrame = CGRectMake(ScreenWidth-30-8, (44-30)/2, 30, 30);
    rightBtn.frame = rightBtnFrame;
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_navigationBar addSubview:rightBtn];
    
    //中间位置
    self.viewSearchBar = [[UIView alloc]initWithFrame:CGRectMake(leftTitle.width+leftTitle.originX+8, 0, rightBtn.originX-8-(leftTitle.width+leftTitle.originX+8), 44)];
    self.viewSearchBar.backgroundColor = [UIColor clearColor];
    [_navigationBar addSubview:self.viewSearchBar];
    
}
-(void)setLeftTitle:(NSString *)title{
    leftTitle.text = title;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setLeftTitle:@"布可"];
    NSLog(@"BaseMainViewControllerNormal隐藏");
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"BaseMainViewControllerNormal显示");
    self.navigationController.navigationBar.hidden = NO;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"BaseMainViewControllerNormal隐藏");
    self.navigationController.navigationBar.hidden = YES;
}
//-(void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"contentOffset"])
    {
        CGPoint point = [[object valueForKey:@"contentOffset"]CGPointValue];
        int current = point.x/self.view.frame.size.width;
        CGFloat percent = ((int)point.x%(int)self.view.frame.size.width)*1.0/self.view.frame.size.width;
        
        if ((int)point.x%(int)self.view.frame.size.width==0) {
            if (current == self.currentPage) {
                self.indexIsChange = NO;
            }
            else{
                self.indexIsChange = YES;
            }
            self.currentPage = current;
            if (self.indexIsChange) {
                NSLog(@"current :%d",current);
                UIButton *button =  [self.bar viewWithTag:current+100];
                [button sendActionsForControlEvents:UIControlEventTouchUpInside];
            }
            
        }
        
        
        //
    }
    if([keyPath isEqualToString:@"head"])
    {
        [imageViewHead sd_setImageWithURL_dx:[DXLoginHelp sharedInstance].head placeholderImage:[UIImage imageNamed:@"nan"]];
    }
}
#pragma mark - 按钮点击
-(void)openSideMenu
{
    NSLog(@"openSideMenu");
    MainTabBarController *mainTabBarController = (MainTabBarController *)self.tabBarController;
    [mainTabBarController.drawer open];
}



- (void)changeValue:(NSString *)value{
    ImageButton *leftBtn = [[ImageButton alloc]initWithFrame:CGRectMake(10, 5, 0, 40) withButtonType:leftImage withImage:[UIImage imageNamed:@"btn_25"] withTitle:value];
    leftBtn.buttonLabel.width = [RSTextHelper getSizeFromFont:leftBtn.buttonLabel.font AndText:value].width;
    leftBtn.width = [RSTextHelper getSizeFromFont:leftBtn.buttonLabel.font AndText:value].width + leftBtn.buttonLabel.originX;
    [leftBtn addTarget:self action:@selector(openSideMenu) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
}

- (void)rightBtnClick{
    NSLog(@"rightBtnClick");
//    NSString *cat = self.selectedViewController.tabBarItem.title;
//    if ([cat isEqualToString:@"社团"]) {
//        UniversityViewController *universityViewController = [[UniversityViewController alloc]init];
//        UIButton *leftBtn = (UIButton *)self.navigationItem.titleView;
//        universityViewController.query = leftBtn.titleLabel.text;
//        [self.selectedViewController.navigationController pushViewController:universityViewController animated:YES];
//        self.navigationItem.titleView = nil;
//        return;
//    }
    if ([self respondsToSelector:@selector(searchStart)]) {
        [self performSelector:@selector(searchStart)];
    }
    
}
-(void)searchStart{
    if (self.searchBar==nil) {
        self.searchBar= [[UISearchBar alloc]initWithFrame:self.viewSearchBar.frame];
        [self.searchBar setX:0];
        [self.searchBar setY:0];
        
        //        self.searchBar.backgroundColor = [UIColor blueColor];
        self.searchBar.translucent = YES;
        self.searchBar.placeholder = @"搜索...";
        for (UIView *view in self.searchBar.subviews) {
            // for before iOS7.0
            if ([view isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
                [view removeFromSuperview];
                break;
            }
            // for later iOS7.0(include)
            if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 0) {
                [[view.subviews objectAtIndex:0] removeFromSuperview];
                break;
            }
        }
        
        
        //        self.searchBar.barTintColor = [UIColor clearColor];
        
        for (UIView* subview in [[self.searchBar.subviews lastObject] subviews]) {
            subview.backgroundColor = [UIColor clearColor];
            if ([subview isKindOfClass:[UITextField class]]) {
                
                UITextField *textField = (UITextField*)subview;
                [textField setBackgroundColor:[UIColor clearColor]];
                [textField setTextColor:[UIColor whiteColor]];
                [textField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
                [textField setLeftViewMode:UITextFieldViewModeNever];
                
                //            UIButton *clearButton = [[UIButton alloc]initWithFrame:CGRectMake(200, 30, 30, 30)];
                //            [clearButton setImage:[UIImage imageNamed:@"st-47"] forState:UIControlStateNormal];
                //            textField.rightView = clearButton;
                //                textField.rightViewMode = UITextFieldViewModeWhileEditing;
                //            NSLog(@"----%@",textField.rightView);
            }
        }
        
        [self.viewSearchBar addSubview:self.searchBar];
    }
    [self.searchBar becomeFirstResponder];
    self.searchBar.delegate = self;
    
    self.searchBar.hidden = NO;
    //    self.tabBarController.navigationItem.titleView = self.searchBar;
    
}
@end
