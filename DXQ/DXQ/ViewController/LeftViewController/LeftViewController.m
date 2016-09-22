//
//  LeftViewController.m
//  DXQ
//
//  Created by rason on 7/22/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "LeftViewController.h"
#import "LeftViewCell.h"
#import "LoginViewController.h"
#import "LeftSetupViewController.h"
#import "LeftCollectionViewController.h"
#import "DXNavigationController.h"
#import "ICSDrawerController.h"
#import "RFHttpTool.h"
#import "DXLoginHelp.h"
#import "RSCheckCaches.h"
#import "UMSocial.h"
#import "UIImageView+WebCache.h"
#import "DXUserPreferenceStatus.h"
#import "UIImageView+DXWebCache.h"
#import "ZXOperatePlist.h"
#import "DXCfg.h"
#import "SYShareCollectionView.h"
static NSString *ID = @"LeftViewCell";

@interface LeftViewController () <UITableViewDataSource, UITableViewDelegate>{
    BOOL isShowUpdate;
}
@property (weak, nonatomic) IBOutlet UIView *viewTop;
@property (weak, nonatomic) IBOutlet UIImageView *imageHead;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelSchool;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewBackground;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化控件
    [self setupUI];
    [self changeLoginStatus];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeLoginStatus) name:kNotificationModifyPersonIfno object:nil];
//    [self.view adaptSubViews];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    isShowUpdate = [[DXCfg readStringForKey:@"checkUpdate"]boolValue];
    [self changeLoginStatus];
    [self.tableView reloadData];
    
}
-(void)changeLoginStatus{
    DXLoginUserReallyModel *model = [DXLoginHelp sharedInstance].loginUser;
    if (model!=nil) {
        self.labelName.text =  [DXLoginHelp sharedInstance].nickName;
        self.labelName.hidden = NO;
        NSString *school = [DXLoginHelp sharedInstance].school ? [DXLoginHelp sharedInstance].school : @"暂无学校";
        self.labelSchool.text = school;
        self.labelSchool.hidden = NO;

        
        if ([DXLoginHelp sharedInstance].head.length>0) {
            // 第三方登录
            
            [self.imageHead sd_setImageWithURL_dx:[DXLoginHelp sharedInstance].head placeholderImage:[UIImage imageNamed:@"loading.jpg"]];
            
        }
        self.btnLogin.hidden = YES;
    }
    else{
        self.btnLogin.hidden = NO;
        self.labelName.hidden = YES;
        self.labelSchool.hidden = YES;
        if ([[DXLoginHelp sharedInstance].sex isEqualToString:@"男"]) {
            self.imageHead.image = [UIImage imageNamed:@"nan"];
        }
        else{
            self.imageHead.image = [UIImage imageNamed:@"nan"];
        }
    }
}
#pragma mark - 初始化控件
- (void)setupUI{
    
    self.imageHead.layer.cornerRadius = self.imageHead.width / 2;
    self.imageHead.clipsToBounds = YES;
    [self.tableView registerNib:[UINib nibWithNibName:ID bundle:nil] forCellReuseIdentifier:ID];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:nil];
    self.tableView.tableFooterView = [UIView new];
}

//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self setAlph];
//}
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    [self setAlph];
//}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (isShowUpdate) {
        return 5;
    }
    else{
        return 4;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LeftViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    int index = (int)indexPath.row;
    if (index>=1&&!isShowUpdate) {
        index++;//跳过检查更新
    }
    switch (index) {
        case 0:
            [self setupCell:cell withImage:@"1" withTitle:@"我的收藏" withDetail:@""];
            break;
        case 1:{
            NSString *appCurVersion = [NSString stringWithFormat:@"当前版本：%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"CFBundleShortVersionString"]];
            [self setupCell:cell withImage:@"2" withTitle:@"检查更新" withDetail:appCurVersion];
            break;
        }
        case 2:
            [self setupCell:cell withImage:@"3" withTitle:@"推荐给好友" withDetail:@""];
            break;
        case 3:{
            [self setupCell:cell withImage:@"4" withTitle:@"清除缓存" withDetail:@""];
            break;
        }
        case 4:
            [self setupCell:cell withImage:@"6" withTitle:@"设置" withDetail:@""];
            break;
        default:
            break;
    }
    return cell;
}

#pragma mark - 设置cell
- (LeftViewCell *)setupCell:(LeftViewCell *)cell withImage:(NSString *)image withTitle:(NSString *)title withDetail:(NSString *)detail{
    cell.imageview.image = [UIImage imageNamed:image];
    cell.labelTitle.text = title;
    cell.labelDetail.text = detail;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    int index = (int)indexPath.row;
    if (index>=1&&!isShowUpdate) {
        index++;
    }
    switch (index) {
        case 0:{
            if (![DXLoginHelp canRestoreState]) {
                [self makeToastAtWindow:@"请先登录"];
//                LoginViewController *loginViewController = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
//                [self.navigationController pushViewController:loginViewController animated:YES];
                return;
            }

            [self.drawer close];
            LeftCollectionViewController *leftCollectionViewController = [[LeftCollectionViewController alloc]initWithNibName:@"LeftCollectionViewController" bundle:nil];
            [self.navigationController pushViewController:leftCollectionViewController animated:YES];
            break;
        }
        case 1:{
            LeftViewCell *cell = (LeftViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            [self updateVersion:cell.labelDetail.text];
            break;
        }
        case 2:{
            [self.drawer close];
            [self share];
            break;
        }
        case 3:{
            [self.drawer close];
            CGFloat folderSize = [RSCheckCaches folderSizeAtPath];
            [RSCheckCaches clearCaches];
            LeftViewCell *cell = (LeftViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            cell.labelDetail.text = @"";
            [self makeToastAtWindow:[NSString stringWithFormat:@"已清除%.2fMB缓存", folderSize]];
            break;
        }
        case 4:
        {
            [self.drawer close];
            LeftSetupViewController *leftSetupViewController = [[LeftSetupViewController alloc]initWithNibName:@"LeftSetupViewController" bundle:nil];
            
            [self.navigationController pushViewController:leftSetupViewController animated:YES];
            break;
        }
    }
}

#pragma mark - 版本检测更新
- (void)updateVersion:(NSString *)version{
    NSString *versionKey = @"CFBundleShortVersionString";
    NSString *latestVersion = [DXCfg readStringForKey:@"latestVersion"];
    NSString *appCurVersion = [[NSBundle mainBundle].infoDictionary objectForKey:versionKey];
    if (latestVersion!=nil&&[latestVersion isEqualToString:appCurVersion]) {
        [self makeToastAtWindow:@"已经是最新版本"];
    }
    else{
        NSString *updateUrl = [DXCfg readStringForKey:@"updateUrl"];
        if (updateUrl!=nil&&updateUrl.length>0) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:updateUrl]];
        }
        else{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=1044132460&mt=8"]];
        }
        
        
    }
}
#pragma mark - 事件
- (void)share{
//    [UMSocialSnsService presentSnsIconSheetView:self
//                                         appKey:UMAPPKey
//                                      shareText:@"布可是一款专属学生的资讯平台，不仅为学生提供各种娱乐资讯，供学生闲暇时消磨时间；还为学生提供电影，校园，旅行，娱乐，户外等类型的活动资讯，供学生想约会时参考。另外还有精品资讯，供学生送礼时参考。社团也可以发布各种资讯到社团模块。http://www.ainibook.com"
//                                     shareImage:nil
//                                shareToSnsNames:@[UMShareToQQ, UMShareToSina, UMShareToWechatSession, UMShareToWechatTimeline]
//                                       delegate:self];
    
    if ([DXLoginHelp sharedInstance].loginUser) {
        [SYShareCollectionView showInViewController:self shareInfo:@{@"title":@"布可-最萌的资讯平台",@"url":@"http://www.ainibook.com/appDownload",@"intro":@"布可是一款专属学生的资讯平台，不仅为学生提供各种娱乐资讯，供学生闲暇时消磨时间；还为学生提供电影，校园，旅行，娱乐，户外等类型的活动资讯，供学生想约会时参考。另外还有精品资讯，供学生送礼时参考。社团也可以发布各种资讯到社团模块。"}];
    }
    else{
        LoginViewController *loginViewController = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
        //            UINavigationController *navigationController = [NYControllerTools getCurrentVC].navigationController;
        //            [navigationController pushViewController:loginViewController animated:YES];
        [self.navigationController pushViewController:loginViewController animated:YES];
    }
    
}

//实现回调方法（可选）：
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}


//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
//    //    if ([touch.view isKindOfClass:[BMKMapView class]])
//    //    {
//    //        return NO;
//    //    }
//    NSLog(@"测试开始:%@",NSStringFromClass([touch.view class]));
//    if ([NSStringFromClass([touch.view class]) isEqualToString:@"TapDetectingView"]) {
//        return NO;
//    }
//    return YES;
//}



- (IBAction)login:(id)sender {
    [self.drawer close];
    LoginViewController *loginViewController = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    [self.navigationController pushViewController:loginViewController animated:YES];
}

- (IBAction)setupPersonInfo:(UIButton *)sender {
    if ([DXLoginHelp canRestoreState]) {
        [self.drawer close];
        LeftSetupViewController *leftSetupViewController = [[LeftSetupViewController alloc]initWithNibName:@"LeftSetupViewController" bundle:nil];
        [self.navigationController pushViewController:leftSetupViewController animated:YES];
    }
    else {
        [self login:nil];
    }
   
}
@end
