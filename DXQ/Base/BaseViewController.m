//
//  BaseViewController.m
//  LinkWe
//
//  Created by mac on 1/16/15.
//  Copyright (c) 2015 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"
#import "BaseTableCell.h"
#import "Toast+UIView.h"
#import "RSTextHelper.h"
@interface BaseViewController ()

@end

@implementation BaseViewController
#pragma mark--controller生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 返回按钮
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    backBtn.contentMode = UIViewContentModeLeft;
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backBtn setImage:[UIImage imageNamed:@"login_back-38" ] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
//    self.navigationController.navigationBar.backgroundColor = DXColorBlueLight;
    
    
    // Do any additional setup after loading the view.
}
-(void)setLeftBarButtonItem:(NSString *)title{
    UIButton *leftBtn = (UIButton *)self.navigationItem.leftBarButtonItem.customView;
    leftBtn.titleLabel.font = DXNavFont;
    [leftBtn setTitle:title forState:UIControlStateNormal];
    CGFloat width = [RSTextHelper getSizeFromFont:DXNavFont AndText:title].width;
//    leftBtn.titleLabel.frame = CGRectMake(0, 0, width, 30);
    leftBtn.frame = CGRectMake(0, 0, width + leftBtn.currentImage.size.width + 5, 30);
    leftBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (self.navigationController.viewControllers.count == 1){//关闭主界面的右滑返回
        return NO;
    }
    else{
        return YES;
    }
}
//-(UINavigationController *)navigationController{
//    if (super.navigationController==nil) {
//        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
//        return delegate.baseNavigationController;
//    }
//    else{
//        return super.navigationController;
//    }
//}
-(void)setAlph{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    DXNavigationController *controller = delegate.baseNavigationController;
    [controller setAlph];
}
#pragma mark - 按钮点击事件
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    NSString *name = NSStringFromClass([self class]);
    NSLog(@"className=%@", name);
    
          self.navigationController.navigationBarHidden = NO;
        
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    [self.view endEditing:YES];
    [self.navigationController.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *) buttonImageFromColor:(UIColor *)color width:(CGFloat)width height:(CGFloat) height {
    CGRect rect = CGRectMake(0, 0, width, height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
-(AppDelegate *)appDelegate{
    return [UIApplication sharedApplication].delegate;
}
-(void)closeSideMenu{
    AppDelegate *delegate = self.appDelegate;
    [delegate.mainVc.drawer close];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseTableCell *cell = (BaseTableCell *)[tableView cellForRowAtIndexPath:indexPath];
    if([cell respondsToSelector:@selector(onSelected)]){
        [cell onSelected];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)makeToast:(NSString *)message{
    [self.view makeToast:message duration:1.0 position:@"center"];
}
- (void)makeToastAtWindow:(NSString *)message{
    [[UIApplication sharedApplication].keyWindow makeToast:message duration:1.0 position:@"center"];
}
-(void)deleteSelfFromNavigation{
    NSMutableArray *tempArr = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [tempArr removeObject:self];
    UIBarButtonItem *barButtonItenBack = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.backBarButtonItem = barButtonItenBack;
    [self.navigationController setViewControllers:tempArr animated:NO];
}

-(void)postNotificationName:(NSString *)name{
    [[NSNotificationCenter defaultCenter]postNotificationName:name object:nil];
}
@end
