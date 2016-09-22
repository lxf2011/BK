//
//  ICSDrawerController.m
//
//  Created by Vito Modena
//
//  Copyright (c) 2014 ice cream studios s.r.l. - http://icecreamstudios.com
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "ICSDrawerController.h"
#import "ICSDropShadowView.h"
#import "DXNavigationController.h"
#import "AppDelegate.h"
#define kICSDrawerControllerDrawerDepth [UIScreen mainScreen].bounds.size.width*0.825
static const CGFloat kICSDrawerControllerLeftViewInitialOffset = -60.0f;
static const NSTimeInterval kICSDrawerControllerAnimationDuration = 0.1;
static const CGFloat kICSDrawerControllerOpeningAnimationSpringDamping = 0.7f;
static const CGFloat kICSDrawerControllerOpeningAnimationSpringInitialVelocity = 0.1f;
static const CGFloat kICSDrawerControllerClosingAnimationSpringDamping = 1.0f;
static const CGFloat kICSDrawerControllerClosingAnimationSpringInitialVelocity = 0.5f;

typedef NS_ENUM(NSUInteger, ICSDrawerControllerState)
{
    ICSDrawerControllerStateClosed = 0,
    ICSDrawerControllerStateOpening,
    ICSDrawerControllerStateOpen,
    ICSDrawerControllerStateClosing
};



@interface ICSDrawerController () <UIGestureRecognizerDelegate,UINavigationControllerDelegate>

//@property(nonatomic, strong, readwrite) UIViewController<ICSDrawerControllerChild, ICSDrawerControllerPresenting> *leftViewController;
//@property(nonatomic, strong, readwrite) UIViewController<ICSDrawerControllerChild, ICSDrawerControllerPresenting> *centerViewController;

@property(nonatomic, strong) UIView *leftView;
@property(nonatomic, strong) ICSDropShadowView *centerView;

@property(nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
@property(nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property(nonatomic, assign) CGPoint panGestureStartLocation;

@property(nonatomic, assign) ICSDrawerControllerState drawerState;

@end



@implementation ICSDrawerController

- (id)initWithLeftViewController:(UIViewController<ICSDrawerControllerChild, ICSDrawerControllerPresenting> *)leftViewController
            centerViewController:(UIViewController<ICSDrawerControllerChild, ICSDrawerControllerPresenting> *)centerViewController
{
    NSParameterAssert(leftViewController);
    NSParameterAssert(centerViewController);
    
    self = [super init];
    if (self) {
        _leftViewController = leftViewController;
        _centerViewController = centerViewController;
        
        if ([_leftViewController respondsToSelector:@selector(setDrawer:)]) {
            _leftViewController.drawer = self;
        }
        if ([_centerViewController respondsToSelector:@selector(setDrawer:)]) {
            _centerViewController.drawer = self;
        }
    }
    
    return self;
}

- (void)addCenterViewController
{
    NSParameterAssert(self.centerViewController);
    NSParameterAssert(self.centerView);
    
    [self addChildViewController:self.centerViewController];
    self.centerViewController.view.frame = self.view.bounds;
    [self.centerView addSubview:self.centerViewController.view];
    [self.centerViewController didMoveToParentViewController:self];
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if ( viewController ==  self ) {
        
        [navigationController setNavigationBarHidden:YES animated:animated];
        
    } else if ( [navigationController isNavigationBarHidden] ) {
        
        [navigationController setNavigationBarHidden:NO animated:animated];
        
    } 
    
}
#pragma mark - Managing the view

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    // Initialize left and center view containers
    self.leftView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.centerView = [[ICSDropShadowView alloc] initWithFrame:self.view.bounds];    
    self.leftView.autoresizingMask = self.view.autoresizingMask;
    self.centerView.autoresizingMask = self.view.autoresizingMask;
    
    // Add the center view container
    [self.view addSubview:self.centerView];

    // Add the center view controller to the container
    [self addCenterViewController];

    [self setupGestureRecognizers];
//    self.navigationController.navigationBar.hidden = YES;
    _pan=@"yes";
}
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
//    if (self.navigationController.viewControllers.count == 1){//关闭主界面的右滑返回
//        return NO;
//    }
//    else{
//        return YES;
//    }
//}
#pragma mark - Configuring the view’s layout behavior

- (UIViewController *)childViewControllerForStatusBarHidden
{
    NSParameterAssert(self.leftViewController);
    NSParameterAssert(self.centerViewController);
    
    if (self.drawerState == ICSDrawerControllerStateOpening) {
        return self.leftViewController;
    }
    return self.centerViewController;
}

- (UIViewController *)childViewControllerForStatusBarStyle
{
    NSParameterAssert(self.leftViewController);
    NSParameterAssert(self.centerViewController);
    
    if (self.drawerState == ICSDrawerControllerStateOpening) {
        return self.leftViewController;
    }
    return self.centerViewController;
}

#pragma mark - Gesture recognizers

- (void)setupGestureRecognizers
{
    NSParameterAssert(self.centerView);
    
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognized:)];
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)];
    self.panGestureRecognizer.maximumNumberOfTouches = 1;
    self.panGestureRecognizer.delegate = self;
    
    [self.centerView addGestureRecognizer:self.panGestureRecognizer];
    
//    UISwipeGestureRecognizer *recognizer;
//    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
//    [recognizer setDirection:UISwipeGestureRecognizerDirectionRight];
//    
//    [self.centerView addGestureRecognizer:recognizer];
//    
//    UISwipeGestureRecognizer *recognizer2;
//    recognizer2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
//    [recognizer2 setDirection:UISwipeGestureRecognizerDirectionLeft];
//    [self.centerView addGestureRecognizer:recognizer2];
    
    
}
//-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
//    NSLog(@"")
//    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
//        [self close];
//        
//    }
//    else{
//        [self animateOpening];
//    }
//    
//}
- (void)addClosingGestureRecognizers
{
    NSParameterAssert(self.centerView);
    NSParameterAssert(self.panGestureRecognizer);
    
    [self.centerView addGestureRecognizer:self.tapGestureRecognizer];
}

- (void)removeClosingGestureRecognizers
{
    NSParameterAssert(self.centerView);
    NSParameterAssert(self.panGestureRecognizer);

    [self.centerView removeGestureRecognizer:self.tapGestureRecognizer];
}

#pragma mark Tap to close the drawer
- (void)tapGestureRecognized:(UITapGestureRecognizer *)tapGestureRecognizer
{
    NSLog(@"1");
    if (tapGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [self close];
    }
}


#pragma mark Pan to open/close the drawer
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    UINavigationController *navigationController = delegate.baseNavigationController;
    NSParameterAssert([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]);
    CGPoint velocity = [(UIPanGestureRecognizer *)gestureRecognizer velocityInView:self.view];
    CGPoint location = [gestureRecognizer locationInView:self.view];
    NSLog(@"velocity.y:%f",velocity.y);
    if (self.drawerState == ICSDrawerControllerStateClosed && velocity.x > 0.0f&&location.x<50 &&navigationController.viewControllers.count==1&&velocity.y>-220.0f && velocity.y<220.0f) {
        return YES;
    }
    else if (self.drawerState == ICSDrawerControllerStateOpen && velocity.x < 0.0f &&navigationController.viewControllers.count==1) {
        return YES;
    }
    return NO;
}

- (void)panGestureRecognized:(UIPanGestureRecognizer *)panGestureRecognizer
{
    NSParameterAssert(self.leftView);
    NSParameterAssert(self.centerView);
    int version=   [[[UIDevice currentDevice] systemVersion] intValue];
    
    UIGestureRecognizerState state = panGestureRecognizer.state;
    CGPoint location = [panGestureRecognizer locationInView:self.view];
    CGPoint velocity = [panGestureRecognizer velocityInView:self.view];
    
    switch (state) {

        case UIGestureRecognizerStateBegan:
            self.panGestureStartLocation = location;
            if (self.drawerState == ICSDrawerControllerStateClosed) {
//               if([_pan isEqualToString:@"yes"])
                   [self willOpen];
//               else{
//                   panGestu
//               }
            }
            else {
                [self willClose];
            }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            CGFloat delta = 0.0f;
            if (self.drawerState == ICSDrawerControllerStateOpening) {
                delta = location.x - self.panGestureStartLocation.x;
            }
            else if (self.drawerState == ICSDrawerControllerStateClosing) {
                delta = kICSDrawerControllerDrawerDepth - (self.panGestureStartLocation.x - location.x);
            }
            
            CGRect l = self.leftView.frame;
            CGRect c = self.centerView.frame;
            if (delta > kICSDrawerControllerDrawerDepth) {
                l.origin.x = 0.0f;
                c.origin.x = kICSDrawerControllerDrawerDepth;
            }
            else if (delta < 0.0f) {
                l.origin.x = kICSDrawerControllerLeftViewInitialOffset;
                c.origin.x = 0.0f;
            }
            else {
                // While the centerView can move up to kICSDrawerControllerDrawerDepth points, to achieve a parallax effect
                // the leftView has move no more than kICSDrawerControllerLeftViewInitialOffset points
                l.origin.x = kICSDrawerControllerLeftViewInitialOffset
                           - (delta * kICSDrawerControllerLeftViewInitialOffset) / kICSDrawerControllerDrawerDepth;

                c.origin.x = delta;
            }
            
            self.leftView.frame = l;
            self.centerView.frame = c;
            
            break;
        }
            
        case UIGestureRecognizerStateEnded:

            if (self.drawerState == ICSDrawerControllerStateOpening) {
                CGFloat centerViewLocation = self.centerView.frame.origin.x;
                if (centerViewLocation == kICSDrawerControllerDrawerDepth) {
                    // Open the drawer without animation, as it has already being dragged in its final position
                    NSLog(@"version%d",version);
                    if(version==6
                       )
                    {}
                    else{
                    [self setNeedsStatusBarAppearanceUpdate];
                    }
                    [self didOpen];
                }
                else if (centerViewLocation > self.view.bounds.size.width / 3
                         && velocity.x > 0.0f) {
                    // Animate the drawer opening
                    [self animateOpening];
                }
                else {
                    // Animate the drawer closing, as the opening gesture hasn't been completed or it has
                    // been reverted by the user
                    [self didOpen];
                    [self willClose];
                    [self animateClosing];
                }

            } else if (self.drawerState == ICSDrawerControllerStateClosing) {
                CGFloat centerViewLocation = self.centerView.frame.origin.x;
                if (centerViewLocation == 0.0f) {
                    // Close the drawer without animation, as it has already being dragged in its final position
                    NSLog(@"version%d",version);
                    if (version==6) {
                        
                    }
                    else{
                    [self setNeedsStatusBarAppearanceUpdate];
                    }
                    [self didClose];
                }
                else if (centerViewLocation < (2 * self.view.bounds.size.width) / 3
                         && velocity.x < 0.0f) {
                    // Animate the drawer closing
                    [self animateClosing];
                }
                else {
                    // Animate the drawer opening, as the opening gesture hasn't been completed or it has
                    // been reverted by the user
                    [self didClose];

                    // Here we save the current position for the leftView since
                    // we want the opening animation to start from the current position
                    // and not the one that is set in 'willOpen'
                    CGRect l = self.leftView.frame;
                    [self willOpen];
                    self.leftView.frame = l;
                    
                    [self animateOpening];
                }
            }
            break;
            
        default:
            break;
    }
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
//    if ([touch.view isKindOfClass:[BMKMapView class]])
//    {
//        return NO;
//    }
//    NSLog(@"点击了%@",NSStringFromClass([touch.view class]));
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"TapDetectingView"]) {
        return NO;
    }
    return YES;
}
#pragma mark - Animations
#pragma mark Opening animation
- (void)animateOpening
{
   

     int version=   [[[UIDevice currentDevice] systemVersion] intValue];
    
    NSParameterAssert(self.drawerState == ICSDrawerControllerStateOpening);
    NSParameterAssert(self.leftView);
    NSParameterAssert(self.centerView);
    
    // Calculate the final frames for the container views
    CGRect leftViewFinalFrame = self.view.bounds;
    CGRect centerViewFinalFrame = self.view.bounds;
    centerViewFinalFrame.origin.x = kICSDrawerControllerDrawerDepth;
    [UIView animateWithDuration:kICSDrawerControllerAnimationDuration animations:^{
        self.centerView.frame = centerViewFinalFrame;
        self.leftView.frame = leftViewFinalFrame;
        NSLog(@"version%f",version);
        if(version==6)
        {}
        else
        [self setNeedsStatusBarAppearanceUpdate];
    }
                     completion:^(BOOL finished) {
                         [self didOpen];
                     }];
    
    
//        [UIView animateWithDuration:kICSDrawerControllerAnimationDuration
//                          delay:0
//         usingSpringWithDamping:kICSDrawerControllerOpeningAnimationSpringDamping
//          initialSpringVelocity:kICSDrawerControllerOpeningAnimationSpringInitialVelocity
//                        options:UIViewAnimationOptionCurveLinear
//                     animations:^{
//                         self.centerView.frame = centerViewFinalFrame;
//                         self.leftView.frame = leftViewFinalFrame;
//                         
//                         [self setNeedsStatusBarAppearanceUpdate];
//                     }
//                     completion:^(BOOL finished) {
//                         [self didOpen];
//                     }];
}
#pragma mark Closing animation
- (void)animateClosing
{
    NSParameterAssert(self.drawerState == ICSDrawerControllerStateClosing);
    NSParameterAssert(self.leftView);
    NSParameterAssert(self.centerView);
    int version=[[[UIDevice currentDevice] systemVersion] intValue];
    // Calculate final frames for the container views
    CGRect leftViewFinalFrame = self.leftView.frame;
    leftViewFinalFrame.origin.x = kICSDrawerControllerLeftViewInitialOffset;
    CGRect centerViewFinalFrame = self.view.bounds;
    [UIView animateWithDuration:0.2 animations:^{
        self.centerView.frame = centerViewFinalFrame;
        self.leftView.frame = leftViewFinalFrame;
        NSLog(@"version%d",version);
        if(version==6)
        {}
        else
        [self setNeedsStatusBarAppearanceUpdate];
        
    }
                     completion:^(BOOL finished) {
                         [self didClose];
                     }];
//    [UIView animateWithDuration:kICSDrawerControllerAnimationDuration
//                          delay:0
//         usingSpringWithDamping:kICSDrawerControllerClosingAnimationSpringDamping
//          initialSpringVelocity:kICSDrawerControllerClosingAnimationSpringInitialVelocity
//                        options:UIViewAnimationOptionCurveLinear
//                     animations:^{
//                         self.centerView.frame = centerViewFinalFrame;
//                         self.leftView.frame = leftViewFinalFrame;
//                         
//                         [self setNeedsStatusBarAppearanceUpdate];
//                     }
//                     completion:^(BOOL finished) {
//                         [self didClose];
//                     }];
}

#pragma mark - Opening the drawer

- (void)open
{
    NSParameterAssert(self.drawerState == ICSDrawerControllerStateClosed);

    [self willOpen];
    
    [self animateOpening];
}

- (void)willOpen
{
    NSParameterAssert(self.drawerState == ICSDrawerControllerStateClosed);
    NSParameterAssert(self.leftView);
    NSParameterAssert(self.centerView);
    NSParameterAssert(self.leftViewController);
    NSParameterAssert(self.centerViewController);
    
    // Keep track that the drawer is opening
    self.drawerState = ICSDrawerControllerStateOpening;
    
    // Position the left view
    CGRect f = self.view.bounds;
    f.origin.x = kICSDrawerControllerLeftViewInitialOffset;
    NSParameterAssert(f.origin.x < 0.0f);
    self.leftView.frame = f;
    
    // Start adding the left view controller to the container
    [self addChildViewController:self.leftViewController];
    self.leftViewController.view.frame = self.leftView.bounds;
    [self.leftView addSubview:self.leftViewController.view];

    // Add the left view to the view hierarchy
    [self.view insertSubview:self.leftView belowSubview:self.centerView];
    
    // Notify the child view controllers that the drawer is about to open
    if ([self.leftViewController respondsToSelector:@selector(drawerControllerWillOpen:)]) {
        [self.leftViewController drawerControllerWillOpen:self];
    }
    if ([self.centerViewController respondsToSelector:@selector(drawerControllerWillOpen:)]) {
        [self.centerViewController drawerControllerWillOpen:self];
    }
}

- (void)didOpen
{
    NSParameterAssert(self.drawerState == ICSDrawerControllerStateOpening);
    NSParameterAssert(self.leftViewController);
    NSParameterAssert(self.centerViewController);
    
    // Complete adding the left controller to the container
    [self.leftViewController didMoveToParentViewController:self];
    
    [self addClosingGestureRecognizers];
    
    // Keep track that the drawer is open
    self.drawerState = ICSDrawerControllerStateOpen;
    
    // Notify the child view controllers that the drawer is open
    if ([self.leftViewController respondsToSelector:@selector(drawerControllerDidOpen:)]) {
        [self.leftViewController drawerControllerDidOpen:self];
    }
    if ([self.centerViewController respondsToSelector:@selector(drawerControllerDidOpen:)]) {
        [self.centerViewController drawerControllerDidOpen:self];
    }
}

#pragma mark - Closing the drawer

- (void)close
{
    NSParameterAssert(self.drawerState == ICSDrawerControllerStateOpen);

    [self willClose];

    [self animateClosing];
}

- (void)willClose
{
    NSParameterAssert(self.drawerState == ICSDrawerControllerStateOpen);
    NSParameterAssert(self.leftViewController);
    NSParameterAssert(self.centerViewController);
    
    // Start removing the left controller from the container
    [self.leftViewController willMoveToParentViewController:nil];
    
    // Keep track that the drawer is closing
    self.drawerState = ICSDrawerControllerStateClosing;
    
    // Notify the child view controllers that the drawer is about to close
    if ([self.leftViewController respondsToSelector:@selector(drawerControllerWillClose:)]) {
        [self.leftViewController drawerControllerWillClose:self];
    }
    if ([self.centerViewController respondsToSelector:@selector(drawerControllerWillClose:)]) {
        [self.centerViewController drawerControllerWillClose:self];
    }
}

- (void)didClose
{
    NSParameterAssert(self.drawerState == ICSDrawerControllerStateClosing);
    NSParameterAssert(self.leftView);
    NSParameterAssert(self.centerView);
    NSParameterAssert(self.leftViewController);
    NSParameterAssert(self.centerViewController);
    
    // Complete removing the left view controller from the container
    [self.leftViewController.view removeFromSuperview];
    [self.leftViewController removeFromParentViewController];
    
    // Remove the left view from the view hierarchy
    [self.leftView removeFromSuperview];
    
    [self removeClosingGestureRecognizers];
    
    // Keep track that the drawer is closed
    self.drawerState = ICSDrawerControllerStateClosed;
    
    // Notify the child view controllers that the drawer is closed
    if ([self.leftViewController respondsToSelector:@selector(drawerControllerDidClose:)]) {
        [self.leftViewController drawerControllerDidClose:self];
    }
    if ([self.centerViewController respondsToSelector:@selector(drawerControllerDidClose:)]) {
        [self.centerViewController drawerControllerDidClose:self];
    }
}

#pragma mark - Reloading/Replacing the center view controller

- (void)reloadCenterViewControllerUsingBlock:(void (^)(void))reloadBlock
{
    NSParameterAssert(self.drawerState == ICSDrawerControllerStateOpen);
    NSParameterAssert(self.centerViewController);
    
    [self willClose];
    
    CGRect f = self.centerView.frame;
    f.origin.x = self.view.bounds.size.width;
    
    [UIView animateWithDuration: kICSDrawerControllerAnimationDuration / 2
                     animations:^{
                         self.centerView.frame = f;
                     }
                     completion:^(BOOL finished) {
                         // The center view controller is now out of sight
                         if (reloadBlock) {
                             reloadBlock();
                         }
                         // Finally, close the drawer
                         [self animateClosing];
                     }];
}

- (void)replaceCenterViewControllerWithViewController:(UIViewController<ICSDrawerControllerChild, ICSDrawerControllerPresenting> *)viewController
{
    NSParameterAssert(self.drawerState == ICSDrawerControllerStateOpen);
    NSParameterAssert(viewController);
    NSParameterAssert(self.centerView);
    NSParameterAssert(self.centerViewController);
    
    [self willClose];
    
    CGRect f = self.centerView.frame;
    f.origin.x = self.view.bounds.size.width;
    
    [self.centerViewController willMoveToParentViewController:nil];
    [UIView animateWithDuration: kICSDrawerControllerAnimationDuration / 2
                     animations:^{
                         self.centerView.frame = f;
                     }
                     completion:^(BOOL finished) {
                         // The center view controller is now out of sight
                         
                         // Remove the current center view controller from the container
                         if ([self.centerViewController respondsToSelector:@selector(setDrawer:)]) {
                             self.centerViewController.drawer = nil;
                         }
                         [self.centerViewController.view removeFromSuperview];
                         [self.centerViewController removeFromParentViewController];
                         
                         // Set the new center view controller
                         self.centerViewController = viewController;
                         if ([self.centerViewController respondsToSelector:@selector(setDrawer:)]) {
                             self.centerViewController.drawer = self;
                         }
                         
                         // Add the new center view controller to the container
                         [self addCenterViewController];
                         
                         // Finally, close the drawer
                         [self animateClosing];
                     }];
}

@end
