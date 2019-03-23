//
//  TransactionViewController+DataSource.m
//  MTAssignment
//
//  Created by Wu Chengyuan on 2019/03/24.
//  Copyright © 2019 Wu Chengyuan. All rights reserved.
//

#import "TransactionViewController+DataSource.h"
#import "MTSimpleTableViewCell.h"

static NSString *const kTransactionCellIdentifier = @"kTransactionCellIdentifier";

@implementation TransactionViewController (DataSource)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.viewModel.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.data[section].transactionList.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.viewModel.data[section].section;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MTSimpleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTransactionCellIdentifier];
    if (cell == nil) {
        cell = [[MTSimpleTableViewCell alloc] init];
    }
    [cell populateCellWithData:self.viewModel.data[indexPath.section].transactionList[indexPath.row]];
    return cell;
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
