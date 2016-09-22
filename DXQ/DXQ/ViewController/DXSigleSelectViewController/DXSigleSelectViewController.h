//
//  DXSigleSelectViewController.h
//  DXQ
//
//  Created by rason on 8/18/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseViewControllerNormal.h"
@interface DXSigleSelectViewController : BaseViewControllerNormal<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)id delegate;
@property (strong, nonatomic) NSString *navigationTitle;
@property (nonatomic)SEL backSel;
@property (strong, nonatomic)NSString *strTitle;
@property (strong, nonatomic)NSArray *dataSource;
@property (nonatomic)int defautIndex;
@end
