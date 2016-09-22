//
//  BaseViewControllerNormal.h
//  DXQ
//
//  Created by rason on 8/11/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^HideOrShow)(BOOL isHide);
@interface BaseViewControllerNormal : BaseViewController{
    UIView *blueView;
}
-(void)hidenBlueView;
-(void)showBlueView;
// // 滚动判断
@property (nonatomic, assign) CGFloat    startY;
@property (nonatomic, assign) BOOL       isNowUp;
@property (nonatomic, assign) BOOL       isNowDown;
@property (nonatomic, assign) BOOL       isUserDrag;// 是用户拖拽 而不是系统反弹
@property (nonatomic, copy) HideOrShow  hideOrShow;

@end
