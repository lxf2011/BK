//
//  DXNavigationController.m
//  DXQ
//
//  Created by rason on 7/22/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "DXNavigationController.h"

@interface DXNavigationController ()

@end

@implementation DXNavigationController
@synthesize alphaView;
-(id)initWithRootViewController:(UIViewController *)rootViewController{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        CGRect frame = self.navigationBar.frame;
        alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height+20)];
        alphaView.backgroundColor = [UIColor clearColor];
        [self.view insertSubview:alphaView belowSubview:self.navigationBar];
        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"bigShadow.png"] forBarMetrics:UIBarMetricsCompact];
        alphaView.alpha = 0.0;
//        self.navigationBar.layer.masksToBounds = YES;
        [self setNavigationBar];
    }
    return self;
}
#pragma mark--设置导航栏
-(void)setNavigationBar
{
    //设置整体navigationbar的颜色
    self.navigationBar.barTintColor  = DXColorBlueDark;
    self.navigationBar.translucent = YES;
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    
    //将title设置成白色
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,DXNavFont, NSFontAttributeName, nil]];
}
-(void)setAlph{
    if (_changing == NO) {
        _changing = YES;
        if (alphaView.alpha == 0.0 ) {
            [UIView animateWithDuration:0.5 animations:^{
                alphaView.alpha = 1.0;
            } completion:^(BOOL finished) {
                _changing = NO;
            }];
        }else{
            [UIView animateWithDuration:0.5 animations:^{
                alphaView.alpha = 0.0;
            } completion:^(BOOL finished) {
                _changing = NO;
                
            }];
        }
    }
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationBar.hidden = NO;
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
#pragma mark - ICSDrawerControllerPresenting

- (void)drawerControllerWillOpen:(ICSDrawerController *)drawerController
{
    if (self.navigationController!=nil) {
        NSLog(@"drawerControllerWillOpen");
        self.navigationBar.userInteractionEnabled = NO;
        self.navigationController.navigationBar.userInteractionEnabled = NO;
        self.view.userInteractionEnabled = NO;
    }
    
}

- (void)drawerControllerDidOpen:(ICSDrawerController *)drawerController
{
    if (self.navigationController!=nil) {
        NSLog(@"drawerControllerDidOpen");
        self.navigationBar.userInteractionEnabled = NO;
        self.navigationController.navigationBar.userInteractionEnabled = NO;
        self.view.userInteractionEnabled = NO;
    }
}

- (void)drawerControllerWillClose:(ICSDrawerController *)drawerController
{
    if (self.navigationController!=nil) {
        NSLog(@"drawerControllerWillClose");
        self.navigationBar.userInteractionEnabled = NO;
        self.navigationController.navigationBar.userInteractionEnabled = YES;
        self.view.userInteractionEnabled = YES;
    }
}

- (void)drawerControllerDidClose:(ICSDrawerController *)drawerController
{
    if (self.navigationController!=nil) {

        NSLog(@"drawerControllerWillOpen");
        if ([self.navigationController.viewControllers count]==1) {
            self.navigationController.navigationBar.hidden = YES;
        }
        else{
            self.navigationController.navigationBar.hidden = NO;
        }
        self.navigationBar.userInteractionEnabled = NO;
        self.navigationController.navigationBar.userInteractionEnabled = YES;
        self.view.userInteractionEnabled = YES;
    }
}
@end
