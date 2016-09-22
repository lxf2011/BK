//
//  YYCycleScrollView.m
//  YYLunBoScrollView
//
//  Created by wangyuanyuan on 15/3/3.
//  Copyright (c) 2015年 wangyuanyuan. All rights reserved.
//

#import "YYCycleScrollView.h"
#import "NSTimer+YYFounction.h"

@interface YYCycleScrollView ()

@property (nonatomic , assign) NSInteger currentPageIndex;
@property (nonatomic , assign) NSInteger totalPageCount;
@property (nonatomic , strong) NSMutableArray *contentViews;
@property (nonatomic , strong) NSMutableArray *points;
@property (nonatomic , strong) NSMutableArray *imageViews;
@property (nonatomic , strong) UIScrollView *scrollView;

@property (nonatomic , strong) NSTimer *animationTimer;
@property (nonatomic , assign) NSTimeInterval animationDuration;
@property (nonatomic, strong) UIImageView *imageView1;
@property (nonatomic,strong) UIImageView *imageView2;
@property (nonatomic,strong) UIImageView *imageView3;

@end


@implementation YYCycleScrollView

- (void)setTotalPagesCount:(NSInteger (^)(void))totalPagesCount
{
    _totalPageCount = totalPagesCount();
    if (_totalPageCount > 0) {
        [self handleRoundPoint:0];
        [self configContentViews];
        [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
    }
}

- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration
{
    self = [self initWithFrame:frame];
    if (animationDuration > 0.0) {
        self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:(self.animationDuration = animationDuration)
                                                               target:self
                                                             selector:@selector(animationTimerDidFired:)
                                                             userInfo:nil
                                                              repeats:YES];
        [self.animationTimer pauseTimer];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:bg];
        
        self.autoresizesSubviews = YES;
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.autoresizingMask = 0xFF;
        self.scrollView.contentMode = UIViewContentModeCenter;
        self.scrollView.contentSize = CGSizeMake(3 * CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        self.scrollView.delegate = self;
        self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0);
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.scrollView];
        self.currentPageIndex = 0;
        
    }
    return self;
}

-(void)handleRoundPoint:(NSInteger)currentPageIndex{
    for (UIImageView *imageView in self.points) {
        [imageView removeFromSuperview];
    }
    self.points = [NSMutableArray array];
    if (_totalPageCount>=2) {
        //圆点半径
        int diameter = 5;
        for (int i=0; i<_totalPageCount; i++) {
            UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width-((_totalPageCount*2)-1)*diameter)/2+i*2*diameter, self.frame.size.height-diameter*4, diameter, diameter)];
            [self.points addObject:view];
            view.layer.borderColor = [[UIColor redColor]CGColor];
            view.layer.borderWidth = 0.5;
            view.layer.cornerRadius = diameter/2;
            if (i==currentPageIndex) {
                view.backgroundColor = [UIColor redColor];
            }
            else{
                view.backgroundColor = [UIColor clearColor];
            }
            view.layer.cornerRadius = view.frame.size.height/2;
            view.alpha = 1;
            [self addSubview:view];
        }
    }
    
}

#pragma mark - 私有函数

- (void)configContentViews
{
    //[self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self setScrollViewContentDataSource];
    
    NSInteger counter = 0;
    NSArray *imageArr = self.contentViews;

    for (int i=0 ; i<self.contentViews.count ;i++) {
        UIImageView *contentView = self.contentViews[i];
        contentView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewTapAction:)];
        [contentView addGestureRecognizer:tapGesture];
        CGRect rightRect = contentView.frame;
        rightRect.origin = CGPointMake(CGRectGetWidth(self.scrollView.frame) * (counter ++), 0);
        
        contentView.frame = rightRect;
        [self.scrollView addSubview:contentView];
       
        UIImageView *imageView = imageArr[i];
        imageView.frame = contentView.frame;
        imageView.image = contentView.image;
//        if(self.scrollView.subviews.count <3)
      //  [self.scrollView addSubview:imageView];
    }
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
}

/**
 *  设置scrollView的content数据源，即contentViews
 */
- (void)setScrollViewContentDataSource
{
    NSInteger previousPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
    NSInteger rearPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
    if (self.contentViews == nil) {
        self.contentViews = [@[] mutableCopy];
    }
    [self.contentViews removeAllObjects];
    
    if (self.fetchContentViewAtIndex) {
        
        [self.contentViews addObject:self.fetchContentViewAtIndex(previousPageIndex)];
        [self.contentViews addObject:self.fetchContentViewAtIndex(_currentPageIndex)];
        [self.contentViews addObject:self.fetchContentViewAtIndex(rearPageIndex)];
       
    }
}

- (NSInteger)getValidNextPageIndexWithPageIndex:(NSInteger)currentPageIndex;
{
    if(currentPageIndex == -1) {
        return self.totalPageCount - 1;
    } else if (currentPageIndex == self.totalPageCount) {
        return 0;
    } else {
        return currentPageIndex;
    }
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.animationTimer pauseTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int contentOffsetX = scrollView.contentOffset.x;
    if(contentOffsetX >= (2 * CGRectGetWidth(scrollView.frame))) {
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
        //        NSLog(@"next，当前页:%d",self.currentPageIndex);
        [self configContentViews];
    }
    if(contentOffsetX <= 0) {
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
        //        NSLog(@"previous，当前页:%d",self.currentPageIndex);
        [self configContentViews];
    }
    if(_totalPageCount!=0){
        [self handleRoundPoint:self.currentPageIndex%_totalPageCount];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [scrollView setContentOffset:CGPointMake(CGRectGetWidth(scrollView.frame), 0) animated:YES];
}


#pragma mark - 响应事件

- (void)animationTimerDidFired:(NSTimer *)timer
{
    CGPoint newOffset = CGPointMake(self.scrollView.contentOffset.x + CGRectGetWidth(self.scrollView.frame), self.scrollView.contentOffset.y);
    [self.scrollView setContentOffset:newOffset animated:YES];
}

- (void)contentViewTapAction:(UITapGestureRecognizer *)tap
{
    if (self.TapActionBlock) {
        self.TapActionBlock(self.currentPageIndex);
    }
}


@end