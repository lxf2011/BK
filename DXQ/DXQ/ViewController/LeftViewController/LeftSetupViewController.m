//
//  LeftSetupViewController.m
//  DXQ
//
//  Created by 做功课 on 15/8/7.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import "LeftSetupViewController.h"
#import "LeftModifyViewController.h"
#import "LeftAboutWeViewController.h"
#import "AppDelegate.h"
#import "UMSocial.h"
#import "DXAuthTool.h"
#import "UIImageView+WebCache.h"
#import "DXLoginHelp.h"
#import "LeftFeedbackViewController.h"
#import "LoginViewController.h"
#import "DXLoginHelp.h"
#import "UIImageView+DXWebCache.h"
#import "ChangePwdViewController.h"
#import "LeftSetupTableViewCell.h"
@interface LeftSetupViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate>

@end

@implementation LeftSetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 初始化控件
    [self setupUI];
    
}

- (void)setupUI{
    self.scrollViewBackground.contentSize = CGSizeMake(ScreenWidth, CGRectGetMaxY(self.buttonLogout.frame));
    self.buttonIcon.layer.cornerRadius = self.buttonIcon.width * 0.5;
    self.buttonIcon.clipsToBounds = YES;
    self.imageViewHead.layer.cornerRadius = self.imageViewHead.width * 0.5;
    self.imageViewHead.clipsToBounds = YES;
    
    [self.buttonLogout roundCornerStyle];
    
    [self updateHeadIcon];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateHeadIcon) name:kNotificationModifyPersonIfno object:nil];
    
    [self setLeftBarButtonItem:@"设置"];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 19)];
    view.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = view;
    
    UIView *view2 = [UIView new];
    view2.backgroundColor =  [UIColor colorWithString:@"#EBEBF1"];
    self.tableView.tableFooterView = view2;
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)updateHeadIcon{
    if ([DXLoginHelp sharedInstance].head.length>0) {
        // 第三方
        [self.imageViewHead sd_setImageWithURL_dx:[DXLoginHelp sharedInstance].head placeholderImage:[UIImage imageNamed:@"loading.jpg"]];
        
    }
    else{
        self.imageViewHead.image = [[DXLoginHelp sharedInstance].sex isEqualToString:@"男"] ? [UIImage imageNamed:@"nan"] : [UIImage imageNamed:@"nan"];
    }
}

-(void)setAlph{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    DXNavigationController *controller = delegate.baseNavigationController;
    [controller setAlph];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LeftSetupTableViewCell *cell = [LeftSetupTableViewCell cellWithOwner:self xib:@"LeftSetupTableViewCell"];
    
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 1) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if(indexPath.row==0){
            [self setupCell:cell withImage:@"ggdog" withTitle:@"应用推荐"];
            return cell;
        }
        else{
            cell.accessoryType = UITableViewCellAccessoryNone;
            [self setupCell:cell withImage:nil withTitle:nil];
            return cell;
        }
    }
    switch (indexPath.row) {
        case 0:
            [self setupCell:cell withImage:@"xgzl" withTitle:@"修改个人信息"];
            break;
        case 1:
            [self setupCell:cell withImage:@"xgmm" withTitle:@"修改密码"];
            break;
        case 2:
            [self setupCell:cell withImage:@"fankui" withTitle:@"意见反馈"];
            break;
        case 3:
            [self setupCell:cell withImage:@"5" withTitle:@"关于我们"];
            break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        if (![DXLoginHelp canRestoreState]) {
            [self makeToastAtWindow:@"请先登录"];
            LoginViewController *loginViewController = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
            [self.navigationController pushViewController:loginViewController animated:YES];
            return;
        }
        LeftModifyViewController *leftModifyViewController = [[LeftModifyViewController alloc]initWithNibName:@"LeftModifyViewController" bundle:nil] ;
        [self.navigationController pushViewController:leftModifyViewController animated:YES];
    }
    else if (indexPath.section == 0 && indexPath.row == 1){
        if (![DXLoginHelp canRestoreState]) {
            [self makeToastAtWindow:@"请先登录"];
            LoginViewController *loginViewController = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
            [self.navigationController pushViewController:loginViewController animated:YES];
            return;
        }
        ChangePwdViewController *controller = [[ChangePwdViewController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if (indexPath.section == 0 && indexPath.row == 2){
        if (![DXLoginHelp canRestoreState]) {
            [self makeToastAtWindow:@"请先登录"];
            LoginViewController *loginViewController = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
            [self.navigationController pushViewController:loginViewController animated:YES];
            return;
        }
        LeftFeedbackViewController *feedBackVc = [[LeftFeedbackViewController alloc]init];
        [self.navigationController pushViewController:feedBackVc animated:YES];
    }
    else if (indexPath.section == 0 && indexPath.row == 3){
        LeftAboutWeViewController *leftAboutWeViewController = [[LeftAboutWeViewController alloc]initWithNibName:@"LeftAboutWeViewController" bundle:nil];
        [self.navigationController pushViewController:leftAboutWeViewController animated:YES];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
#pragma mark - 设置cell
- (UITableViewCell *)setupCell:(LeftSetupTableViewCell *)cell withImage:(NSString *)image withTitle:(NSString *)title{
    cell.leftImageView.image = [UIImage imageNamed:image];
    cell.rightLabel.text = title;
    cell.rightLabel.textColor = DXColorGrayDark;
    return cell;
}

#pragma mark 退出登录
- (IBAction)logout:(UIButton *)sender {
    if (![DXLoginHelp canRestoreState]) {
        [self makeToastAtWindow:@"未登录"];
        LoginViewController *loginViewController = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
        [self.navigationController pushViewController:loginViewController animated:YES];
        return;
    }
    [[[UIAlertView alloc]initWithTitle:@"提示" message:@"确定退出？" delegate:self cancelButtonTitle:nil otherButtonTitles:@"取消",@"确定", nil] show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    DXLog(@"buttonIndex:%zd",buttonIndex);
    if (buttonIndex == 1) {
        [DXLoginHelp cancelLogin:^{
            [self.navigationController popViewControllerAnimated:YES];
            [self makeToastAtWindow:@"退出成功"];
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationPreferenceStatusChange object:nil];
        } :^{
            [self makeToastAtWindow:@"退出失败,请检查当前网络情况"];
        } ];
    }
}

#pragma mark - 改头像

- (IBAction)changeHeadIcon:(UIButton *)sender {
    if (![DXLoginHelp canRestoreState]) {
        [self makeToastAtWindow:@"请先登录"];
        LoginViewController *loginViewController = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
        [self.navigationController pushViewController:loginViewController animated:YES];
        return;
    }
    UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
    ipc.delegate = self;
    ipc.allowsEditing = YES;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:ipc animated:YES completion:nil];

    }
    else{
        [self makeToastAtWindow:@"相册不可用"];
    }
}

- (IBAction)changeIconByCamera:(UIButton *)sender {
    if (![DXLoginHelp canRestoreState]) {
        [self makeToastAtWindow:@"请先登录"];
        LoginViewController *loginViewController = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
        [self.navigationController pushViewController:loginViewController animated:YES];
        return;
    }
    UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
    ipc.delegate = self;
    ipc.allowsEditing = YES;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:ipc animated:YES completion:nil];
    }else{
        [self makeToastAtWindow:@"相机不可用"];
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
//当选择一张图片后进入这里
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        
        
        
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil)
        {
            data = UIImageJPEGRepresentation(image, 1.0);
        }
        else
        {
            data = UIImagePNGRepresentation(image);
        }
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        NSString *str = [NSString stringWithFormat:@"/%@.png",@"upload"];
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:str] contents:data attributes:nil];
        
        //得到选择后沙盒中图片的完整路径
        NSString *filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,str];
        
        
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:nil];
        
        
        
        [DXAuthTool postUploadConstructingBldyWithBlock:filePath success:^(DXUploadModel *result) {
            DXChangeUserParam *param = [[DXChangeUserParam alloc]init];
            param.LID = [NSString stringWithFormat:@"%ld",(long)[DXLoginHelp sharedInstance].loginUser.Id];
            param.LKEY = @"head";//代表修改的是昵称
            param.LSVALUE = [NSString stringWithFormat:@"/download/%@%@",result.data.LMD5,result.data.LEXT];
            param.LOTYPE = @"L_USR";//代表修改的是用户属性
            param.LTYPE = @"S";//代表字符串
            [DXAuthTool postChangeUserWithParams:param success:^(DXChangeUserModel *result) {
                [DXLoginHelp sharedInstance].head = param.LSVALUE;
                [self postNotificationName:kNotificationModifyPersonIfno];
                [self makeToastAtWindow:@"头像设置成功"];
                [self.buttonIcon setImage:image forState:UIControlStateNormal];
            } failure:^(NSError *error) {
                [self makeToastAtWindow:@"头像设置失败，请检查当前网络情况"];
            }];
        } failure:^(NSError *error) {
            
        }];
    }

    
}

#pragma mark - 分享
- (IBAction)shareByWB:(UIButton *)sender {
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:@"分享内嵌文字" image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
        if (shareResponse.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
        }
    }];
}

- (IBAction)shareByWX:(UIButton *)sender {
    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"微信好友title";
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"微信朋友圈title";
    //应用分享类型点击分享内容后跳转到应用下载页面，下载地址自动抓取开发者在微信开放平台填写的应用地址，如果用户已经安装应用，则打开APP
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeApp;
    //使用UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite分别代表微信好友、微信朋友圈、微信收藏
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:@"分享内嵌文字" image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
        }
    }];
}

- (IBAction)shareByQQ:(UIButton *)sender {
    [UMSocialData defaultData].extConfig.qqData.url = @"http://baidu.com";
    [UMSocialData defaultData].extConfig.qqData.title = @"QQ分享title";
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:@"分享文字" image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
        }
    }];
}

- (IBAction)shareByFriendCircle:(UIButton *)sender {
    [UMSocialData defaultData].extConfig.qzoneData.url = @"http://baidu.com";
    [UMSocialData defaultData].extConfig.qzoneData.title = @"Qzone分享title";

    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:@"分享文字" image:[UIImage imageNamed:@"loading"] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
        }
    }];
}


/**
 *  回调
 */
- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
    
}

//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
//{
//    return NO;
//}
@end
