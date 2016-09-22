//
//  ActivityMainController.h
//  DXQ
//
//  Created by 做功课 on 15/7/22.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseMainViewControllerNormal.h"

@interface ActivityMainController : BaseMainViewControllerNormal<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
