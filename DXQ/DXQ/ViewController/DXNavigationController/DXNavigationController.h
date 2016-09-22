//
//  DXNavigationController.h
//  DXQ
//
//  Created by rason on 7/22/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNavigationController.H"
#import "ICSDrawerController.H"
@interface DXNavigationController : BaseNavigationController<ICSDrawerControllerPresenting>{
    BOOL _changing;
}
@property(nonatomic, retain)UIView *alphaView;
-(void)setAlph;
@property(nonatomic, weak) ICSDrawerController *drawer;
@end
