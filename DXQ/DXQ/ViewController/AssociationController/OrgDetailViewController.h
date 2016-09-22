//
//  OrgDetailViewController.h
//  DXQ
//
//  Created by 做功课 on 15/8/22.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import "BaseViewControllerNormal.h"
#import "DxGetOrgsItemModel.h"

@interface OrgDetailViewController : BaseViewControllerNormal<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *buttonPraise;
@property (nonatomic, strong) DxGetOrgsItemModel *model;
- (IBAction)praise:(UIButton *)sender;

@end
