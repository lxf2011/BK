//
//  MainTabBarController.m
//  NanYueTong
//
//  Created by rason on 6/27/15.
//  Copyright (c) 2015 mac. All rights reserved.
//

#import "MainTabBarController.h"
#import "ActivityMainController.h"
#import "AssociationMainController.h"
#import "InformationMainController.h"
#import "GiftMainController.h"
#import "ImageButton.h"
#import "DXNavigationController.h"
#import "UniversityViewController.h"
#import "DXSigleSelectViewController.h"
#import "RSFileHelp.h"
#import "RSTextHelper.h"

#import "DXLoginHelp.h"
#import "AssociationMainController.h"
#import "BaseViewControllerNormal.h"
@interface MainTabBarController (){
    UIImageView *imageViewHead;
    NSArray *leftBarButtonItems;
    UIBarButtonItem *rightBarButtonItem;
}

@property (nonatomic, weak) ImageButton *leftBtn;

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
   
//    [self setNavigationBar];
  //  [self setSwipe];
    [self setupViewControllers];
    
//    //自定义的按钮
//    [self setNavBtn];
}

#pragma mark - 初始化子控制器
- (void)setupViewControllers{
    self.delegate = self;
    
    InformationMainController *informationVc = [[InformationMainController alloc]init];
    [self addChildVc:informationVc title:@"资讯" image:@"btn_43" selectedImage:@"btn_42"];

    ActivityMainController *activityVc = [[ActivityMainController alloc] init];
    [self addChildVc:activityVc title:@"活动" image:@"btn_44" selectedImage:@"btn_39"];
    
    GiftMainController *giftVc = [[GiftMainController alloc] init];
    [self addChildVc:giftVc title:@"精品" image:@"btn_45" selectedImage:@"btn_40"];
    
    AssociationMainController *associationVc = [[AssociationMainController alloc] init];
    [self addChildVc:associationVc title:@"社团" image:@"btn_46" selectedImage:@"btn_41"];
    
}

/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字
    childVc.tabBarItem.title = title;
    // 设置子控制器的图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 添加为子控制器
    [self addChildViewController:childVc];
}


- (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
    
}
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
//    [self updateImage];
//    self.navigationController.navigationBar.hidden = NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        BaseViewControllerNormal *temp = (BaseViewControllerNormal *)viewController;
    });
    
    return YES;
}
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
//    if ([viewController isKindOfClass:[AssociationMainController class] ]) {
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 0)];
//        label.text = @"广州大学";
//        [RSTextHelper labelHandleWithModeWordWrap:label];
//        self.navigationItem.titleView = label;
//    }
//    else{
//        self.navigationItem.titleView = nil;
//    }
    
}

-(void)updateImage{
    NSArray *imageArr1 = [NSArray arrayWithObjects:@"tabBar_buyTicket_normal",@"tabBar_myTicket_normal",@"tabBar_personalCenter_normal",nil];
    NSArray *imageArr2 = [NSArray arrayWithObjects:@"tabBar_buyTicket_highLight",@"tabBar_myTicket_highLight",@"tabBar_personalCenter_highLight",nil];
    for (int i=0; i<[imageArr1 count]; i++) {
        UIImage *image2=[UIImage imageNamed:imageArr1[i]];
        //        if (version>=7) {
        [image2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //        }
        
        //设置选中时的图标
        UIImage *selectedImage2=[UIImage imageNamed:imageArr2[i]];
        // 声明这张图片用原图(别渲染)
        //        if (version>=7) {
        selectedImage2 = [selectedImage2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //        }
        CGSize size = CGSizeMake(18.6875, 23);
        if (i==1) {
            size = CGSizeMake(43, 36);
        }
        selectedImage2 = [self reSizeImage:selectedImage2 toSize:size];
        image2 = [self reSizeImage:image2 toSize:size];
        
        //    [self.navigationController tabBarItem]set
        //        UITabBarItem * tabBarItem = [[UITabBarItem alloc]initWithTitle:@"" image:image2 selectedImage:selectedImage2];
        //        self.tabBar.items[
        UITabBarItem *item = self.tabBar.items[i];
        [item setImage:image2];
        [item setSelectedImage:selectedImage2];
    //    [item setFinishedSelectedImage:selectedImage2 withFinishedUnselectedImage:image2];
        
    }
    
}

@end
