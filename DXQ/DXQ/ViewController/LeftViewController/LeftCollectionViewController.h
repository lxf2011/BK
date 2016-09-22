//
//  LeftCollectionViewController.h
//  DXQ
//
//  Created by 做功课 on 15/8/7.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewControllerNormal.h"
#import "ICSDrawerController.h"

@interface LeftCollectionViewController : BaseViewControllerNormal < UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *centerImageView;

@end
