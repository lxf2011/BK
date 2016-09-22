//
//  WelComeViewController.m
//  DXQ
//
//  Created by rason on 9/3/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "WelComeViewController.h"
#import "YYCycleScrollView.h"
#import "UIColor+ColorWithString.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
@interface WelComeViewController ()<UIScrollViewDelegate>{
    UIScrollView *_scrollView;
    UIPageControl *_control;
    NSArray *array;
    
}

@end

@implementation WelComeViewController

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [self initWecomeViewUI];
    _scrollView.backgroundColor = [UIColor colorWithString:array[0]];
}
//引导页的UI创建
-(void)initWecomeViewUI{
    //颜色
    array = @[@"#ff6cb6",@"#ff8500",@"#bbe520",@"#1082ff"];
    //    滑动图
    self.navigationController.navigationBarHidden =YES;
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.bounces = NO;
    _scrollView.pagingEnabled = YES;
    
    _scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    
    
    NSLog(@"%@",NSStringFromCGPoint(_scrollView.contentOffset));
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    CGFloat width = _scrollView.frame.size.width;
    CGFloat height = _scrollView.frame.size.height;
    
    [self.view addSubview:_scrollView];
    
    
    UITapGestureRecognizer *tapGR=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchDown)];
    int count = 4;
    for (int i = 0; i <count; i++) {
        NSString *imageName = [NSString  stringWithFormat:@"yd_%d.png",i+1];
        
        UIImage *image = [UIImage imageNamed: imageName];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = image;
        imageView.frame = CGRectMake(i*width, 0, width, height);
        if(i==3){
            UIImageView *tempImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"yd_btn.png"]];
            [tempImageView addGestureRecognizer:tapGR];
            tempImageView.userInteractionEnabled = YES;
            tempImageView.center = CGPointMake(width*0.5, height-50);
            
            imageView.userInteractionEnabled = YES;
            [imageView addSubview:tempImageView];
        }
        [_scrollView addSubview:imageView];
    }
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(count*width, height);
    _scrollView.pagingEnabled = YES;
    _scrollView.backgroundColor = [UIColor grayColor];
    _scrollView.delegate =self;
    
    //    页面控制器
    _control = [[UIPageControl alloc] init];
    _control.numberOfPages = count;
    _control.center = CGPointMake(width*0.5, height-50);
    _control.currentPage = 0;
    [_control addTarget:self action:@selector(onPointClick) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_control];
    
    
    //    第一次引导完成之后要写入信息
    NSUserDefaults * setting = [NSUserDefaults standardUserDefaults];
    NSString * key = [NSString stringWithFormat:@"isNotFirst"];
    [setting setObject:[NSString stringWithFormat:@"true"] forKey:key];
    [setting synchronize];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"contentOffset"])
    {
        CGPoint point = [[object valueForKey:@"contentOffset"]CGPointValue];
        int current = point.x/self.view.frame.size.width;
        CGFloat percent = ((int)point.x%(int)self.view.frame.size.width)*1.0/self.view.frame.size.width;
        
        if (current>=3) {
            _scrollView.backgroundColor = [UIColor colorWithString:array[3]];
        }
        else{
            _scrollView.backgroundColor = [self getCurrentBeforeColor:[UIColor colorWithString:array[current]] afterColor:[UIColor colorWithString:array[current+1]] percent:percent];
        }
        
    }
}
-(UIColor *)getCurrentBeforeColor:(UIColor *)beforeColor afterColor:(UIColor*)afterColor percent:(CGFloat)percent{
    CGFloat R, G, B;
    int numComponents = CGColorGetNumberOfComponents([beforeColor CGColor]);
    
    if (numComponents == 4)
    {
        const CGFloat *components = CGColorGetComponents([beforeColor CGColor]);
        R = components[0];
        G = components[1];
        B = components[2];
    }
    CGFloat R2, G2, B2;
    int numComponents2 = CGColorGetNumberOfComponents([afterColor CGColor]);
    
    if (numComponents2 == 4)
    {
        const CGFloat *components2 = CGColorGetComponents([afterColor CGColor]);
        R2 = components2[0];
        G2 = components2[1];
        B2 = components2[2];
    }
//    CGFloat currentR =
    return [UIColor colorWithRed:R+(R2-R)*percent green:G+(G2-G)*percent blue:B+(B2-B)*percent alpha:1.0];
}
//scrollView的滑动事件
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int pageNum = (int)(scrollView.contentOffset.x / scrollView.frame.size.width);
    _control.currentPage = pageNum;
    if (pageNum==3) {
        _control.hidden = YES;
    }
    else{
        _control.hidden = NO;
    }
}
//手势的点击时间
-(void)touchDown{
    NSLog(@"touchDown");
    [self presentViewController:self.viewController animated:NO completion:nil];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.window.rootViewController = self.viewController;
}
//UIPageControl的触发事件
- (void) onPointClick
{
    CGFloat offsetX = _control.currentPage * _scrollView.frame.size.width;
    [UIView animateWithDuration:0.3 animations:^{
        _scrollView.contentOffset = CGPointMake(offsetX, 0);
    }];
}



- (void)viewDidLoad {
    [super viewDidLoad];
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

@end
