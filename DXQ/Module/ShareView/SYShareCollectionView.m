//
//  SYShareCollectionView.m
//  Rason-简单分享
//
//  Created by mac on 4/27/15.
//  Copyright (c) 2015 mac. All rights reserved.
//

#import "SYShareCollectionView.h"
#import "SYShareCollectionCell.h"
#import "Toast+UIView.h"
#import "RSTouMingUIView.h"
#import "NYControllerTools.h"
@implementation SYShareCollectionView

-(void)setCollectionView
{
    
//    self.nameArr = [NSArray arrayWithObjects:@"微信朋友圈",@"短信",@"电子邮件",@"微博",@"发送给好友",@"发送给朋友",@"加到微信收藏",@"发送到我的电脑",@"面对面快传（免流量）",@"保存到QQ收藏", nil];
    self.nameArr = [NSArray arrayWithObjects:@"QQ",@"微信好友",@"朋友圈",@"微博",nil];
    self.imgArr  = [NSArray arrayWithObjects:@"UMS_qq_icon.png",@"UMS_wechat_session_icon@2x.png",@"UMS_wechat_timeline_icon@2x.png",@"UMS_sina_icon",nil];
    UINib *cellNib = [UINib nibWithNibName:@"SYShareCollectionCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"SYShareCollectionCell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView reloadData];
    [self.collectionView flashScrollIndicators];
    
    
    self.dframe = self.frame;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(close:) name:@"NSNotificationCloseShareView" object:nil];
    
    
    self.source = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[self.dicShareInfo valueForKey:@"pic"]];
    
    self.actionArr = @[NSStringFromSelector(@selector(shareByQQ:)),NSStringFromSelector(@selector(shareByWX:)),NSStringFromSelector(@selector(shareByFriendCircle:)),NSStringFromSelector(@selector(shareByWB:))];
    
    
}
//行
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//列
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SYShareCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SYShareCollectionCell" forIndexPath:indexPath];
    if (indexPath.section*3+indexPath.row <[self.nameArr count]) {
        cell.backgroundColor = [UIColor whiteColor];
        
        [cell setContentWithName:self.nameArr[indexPath.section*3+indexPath.row] AndImageName:self.imgArr[indexPath.section*3+indexPath.row]];
    }
    else{
        [cell setContentWithName:@"" AndImageName:@""];
        cell.imageView.backgroundColor = [UIColor whiteColor];
    }
    
    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.layer.cornerRadius = 10;
    
    CGFloat jiange = (ScreenWidth-74*4)/8;
    cell.frame = CGRectMake(jiange+jiange*2*indexPath.row + 74*indexPath.row, 0, 74, 200);

    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self close:nil];
    NSString *sel = self.actionArr[indexPath.row];
    if(![self.own isKindOfClass:[UINavigationController class]]){
        self.own = self.own.navigationController;
    }
    
    [self performSelector:NSSelectorFromString(sel) withObject:nil afterDelay:0];
    
}
- (IBAction)close:(id)sender {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    RSTouMingUIView *view = (RSTouMingUIView * )self;
    int i = 0;
    while (![view isKindOfClass:[RSTouMingUIView class]]) {
        view = (RSTouMingUIView *)[view superview];
        i++;
        if (i>=20) {
            break;
        }
    }
    if (i<20) {
        [view removeFromSuperview];
    }
}


#pragma mark - 分享
- (IBAction)shareByWB:(UIButton *)sender {
    

    
//    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:[self.dicShareInfo valueForKey:@"pic"]];
//    [[UMSocialControllerService defaultControllerService] setShareText:[NSString stringWithFormat:@"%@%@",[self.dicShareInfo valueForKey:@"intro"],[self.dicShareInfo valueForKey:@"url"]] shareImage:nil socialUIDelegate:self];        //设置分享内容和回调对象
//    [self performSelector:@selector(shareWB) withObject:nil afterDelay:0.02];
    

    
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:[NSString stringWithFormat:@"%@%@",[self.dicShareInfo valueForKey:@"intro"],[self.dicShareInfo valueForKey:@"url"]] image:[UIImage imageNamed:@"myicon.png"] location:nil urlResource:self.source presentedController:self.own completion:^(UMSocialResponseEntity *shareResponse){
        if (shareResponse.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
            [self.own.view makeToast:@"分享成功"];
            [self postNotifacation:shareResponse];
        }
        if(shareResponse.responseCode == UMSResponseCodeCancel){
            [self.own.view makeToast:@"取消分享"];
        }
    }];
    
//    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:[self.dicShareInfo valueForKey:@"pic"]];
//
//    
//    //微博
//    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:[self.dicShareInfo valueForKey:@"pic"]];
//    
//    [UMSocialSnsService presentSnsIconSheetView:self.own
//                                         appKey:UMAPPKey
//                                      shareText:[NSString stringWithFormat:@"%@%@",[self.dicShareInfo valueForKey:@"intro"],[self.dicShareInfo valueForKey:@"url"]]
//                                     shareImage:nil
//                                shareToSnsNames:@[UMShareToSina]
//                                       delegate:self];
    
}
-(void)shareWB{
    UIViewController *viewController = [NYControllerTools getCurrentVC];
    UIViewController *own = self.own;
    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(own,[UMSocialControllerService defaultControllerService],YES);
}
- (IBAction)shareByWX:(UIButton *)sender {
    //微信好友
    [UMSocialData defaultData].extConfig.wechatSessionData.title = [self.dicShareInfo valueForKey:@"title"];
    [UMSocialData defaultData].extConfig.wechatSessionData.url = [self.dicShareInfo valueForKey:@"url"];
//    [UMSocialSnsService presentSnsIconSheetView:self.own
//                                         appKey:UMAPPKey
//                                      shareText:[NSString stringWithFormat:@"%@%@",[self.dicShareInfo valueForKey:@"intro"],[self.dicShareInfo valueForKey:@"url"]]
//                                     shareImage:nil
//                                shareToSnsNames:@[UMShareToWechatSession]
//                                       delegate:self];
    
    

    //应用分享类型点击分享内容后跳转到应用下载页面，下载地址自动抓取开发者在微信开放平台填写的应用地址，如果用户已经安装应用，则打开APP
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeWeb;
    //使用UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite分别代表微信好友、微信朋友圈、微信收藏
    UIImage *imageView = [UIImage imageNamed:@"myicon.png"];
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:[self.dicShareInfo valueForKey:@"intro"] image:imageView location:nil urlResource:self.source presentedController:self.own completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
            [self postNotifacation:response];
        }
        if(response.responseCode == UMSResponseCodeCancel){
            [self.own.view makeToast:@"取消分享"];
        }
    }];
}

- (IBAction)shareByQQ:(UIButton *)sender {
    //QQ
    [UMSocialData defaultData].extConfig.qqData.title = [self.dicShareInfo valueForKey:@"title"];
    [UMSocialData defaultData].extConfig.qqData.url = [self.dicShareInfo valueForKey:@"url"];
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:[self.dicShareInfo valueForKey:@"intro"] image:[UIImage imageNamed:@"myicon.png"] location:nil urlResource:self.source presentedController:self.own completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
            [self postNotifacation:response];
        }
        if(response.responseCode == UMSResponseCodeCancel){
            [self.own.view makeToast:@"取消分享"];
        }
    }];
}

- (IBAction)shareByFriendCircle:(UIButton *)sender {
    //微信朋友圈
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = [self.dicShareInfo valueForKey:@"title"];
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = [self.dicShareInfo valueForKey:@"url"];
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:[self.dicShareInfo valueForKey:@"intro"] image:[UIImage imageNamed:@"myicon.png"] location:nil urlResource:self.source presentedController:self.own completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
            [self postNotifacation:response];
        }
        if(response.responseCode == UMSResponseCodeCancel){
            [self.own.view makeToast:@"取消分享"];
        }
    }];
}
+(void)showInViewController:(UIViewController *)viewController shareInfo:(NSDictionary *)shareInfo{
    RSTouMingUIView *view = [[RSTouMingUIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [view addGestureToRemove];
    SYShareCollectionView *sYShareCollectionView = [[[NSBundle mainBundle] loadNibNamed:@"SYShareCollectionView" owner:self options:nil] lastObject];
    sYShareCollectionView.own = viewController;
    sYShareCollectionView.dicShareInfo = shareInfo;
    [sYShareCollectionView setCollectionView];
    [viewController.navigationController.view addSubview:view];
    [view addView:sYShareCollectionView];
    
    
    sYShareCollectionView.frame = CGRectMake(0, ScreenHeight-200, ScreenWidth, 200);
}
-(void)postNotifacation:(UMSocialResponseEntity *)response{
    [[NSNotificationCenter defaultCenter]postNotificationName:kNotificationUpdateShareInfo object:response];
}
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response{
    if (response.responseCode == UMSResponseCodeSuccess) {
        [self postNotifacation:response];
    }
    if(response.responseCode == UMSResponseCodeCancel){
        [self.own.view makeToast:@"取消分享"];
    }
}
-(void)didCloseUIViewController:(UMSViewControllerType)fromViewControllerType{
    [self.own.view makeToast:@"取消分享"];
}
@end
