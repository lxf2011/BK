//
//  LeftSetupViewController.h
//  DXQ
//
//  Created by 做功课 on 15/8/7.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface LeftSetupViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewBackground;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)loginOut:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *buttonLogout;
@property (weak, nonatomic) IBOutlet UIButton *buttonIcon;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewHead;

- (IBAction)shareByQQ:(UIButton *)sender;
- (IBAction)shareByWB:(UIButton *)sender;
- (IBAction)shareByWX:(UIButton *)sender;
- (IBAction)shareByFriendCircle:(UIButton *)sender;

- (IBAction)changeHeadIcon:(UIButton *)sender;
- (IBAction)changeIconByCamera:(UIButton *)sender;

@end
