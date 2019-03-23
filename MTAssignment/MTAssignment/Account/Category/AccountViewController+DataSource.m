//
//  AccountViewController+DataSource.m
//  MTAssignment
//
//  Created by Wu Chengyuan on 2019/03/24.
//  Copyright © 2019 Wu Chengyuan. All rights reserved.
//

#import "AccountViewController+DataSource.h"


static NSString *const kAccountCellIdentifier = @"kAccountCellIdentifier";

@implementation AccountViewController (DataSource)


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.viewModel.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.data
    [section].accountList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MTSimpleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kAccountCellIdentifier];
    if (cell == nil) {
        cell = [[MTSimpleTableViewCell alloc] init];
    }
    
    Account *account = self.viewModel.data[indexPath.section].accountList[indexPath.row];
    [cell populateCellWithData:account];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.viewModel.data[section].section;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //TODO: push  detail viewcontroller
    
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if([view isKindOfClass:[UITableViewHeaderFooterView class]]){
        UITableViewHeaderFooterView * headerView = (UITableViewHeaderFooterView *) view;
        headerView.textLabel.textColor  = [UIColor whiteColor];
        headerView.backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        
    }
}

@end
