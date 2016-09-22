//
//  LeftAboutWeViewController.h
//  DXQ
//
//  Created by 做功课 on 15/8/7.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface LeftAboutWeViewController : BaseViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *labelVersion;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewBackGround;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewLogo;

@end
