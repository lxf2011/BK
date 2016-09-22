//
//  SYShareCollectionView.h
//  Rason-简单分享
//
//  Created by mac on 4/27/15.
//  Copyright (c) 2015 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "WXApi.h"
#import "UMSocial.h"
@interface SYShareCollectionView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,WXApiDelegate,UMSocialUIDelegate>
@property (nonatomic, strong) NSDictionary* dicShareInfo;//分享信息
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) UIViewController *own;
-(void)setCollectionView;
@property (strong, nonatomic) NSArray *imgArr;
@property (strong, nonatomic) NSArray *nameArr;
@property (strong, nonatomic) NSArray *actionArr;
@property (strong, nonatomic) UMSocialUrlResource *source;
@property (strong, nonatomic) UMSocialUrlResource *sourcePic;
@property (nonatomic)  CGRect dframe;
- (IBAction)close:(id)sender;
+(void)showInViewController:(UIViewController *)viewController shareInfo:(NSDictionary *)shareInfo;
@end
