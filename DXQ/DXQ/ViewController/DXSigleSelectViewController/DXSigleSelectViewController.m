//
//  DXSigleSelectViewController.m
//  DXQ
//
//  Created by rason on 8/18/15.
//  Copyright (c) 2015 rason. All rights reserved.
//

#import "DXSigleSelectViewController.h"

@interface DXSigleSelectViewController ()
@property id defautObj;
@end

@implementation DXSigleSelectViewController





- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = self.navigationTitle;
    if(_defautIndex>=0 && [_dataSource count]>_defautIndex)
        _defautObj = [_dataSource objectAtIndex:_defautIndex];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setDataSource:(NSArray*)dataSource
{
    _dataSource = dataSource;
}

#pragma mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataSource count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]init];
    }
    cell.textLabel.text = [[_dataSource objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    
    UIView *line =[[UIView alloc]initWithFrame:CGRectMake(0, cell.bounds.size.height-1, ScreenWidth, 1)];
    [line setBackgroundColor:[UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:0.8]];
    
    [ cell addSubview:line];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.backSel == nil) self.backSel = @selector(changeValue:);
    [_delegate performSelector:self.backSel withObject:[[_dataSource objectAtIndex:indexPath.row] objectForKey:@"name"]];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:YES completion:nil];
}

@end
