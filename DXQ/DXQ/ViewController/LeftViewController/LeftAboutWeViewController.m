//
//  LeftAboutWeViewController.m
//  DXQ
//
//  Created by 做功课 on 15/8/7.
//  Copyright (c) 2015年 rason. All rights reserved.
//

#import "LeftAboutWeViewController.h"

@interface LeftAboutWeViewController ()

@end

@implementation LeftAboutWeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftBarButtonItem:@"关于我们"];
    
    //设置版本号
    self.labelVersion.text = [NSString stringWithFormat:@"当前版本：%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"CFBundleShortVersionString"]];
    
    //适配
    [self.view adaptSubViews];
    [self.imageViewBackGround adaptHeight];
    [self.labelVersion alignTopWithView:self.imageViewBackGround];
    [self.tableView alignTopWithView:self.labelVersion];
    [self.imageViewLogo inBottomWithView:self.imageViewBackGround space:14];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeftAboutWeCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"LeftAboutWeCell"];
    }
    if (indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"weibo"];
        cell.textLabel.text = @"官方微博";
    }else{
        cell.imageView.image = [UIImage imageNamed:@"weixin"];
        cell.textLabel.text = @"微信公众号";

    }
    return cell;
}
@end
