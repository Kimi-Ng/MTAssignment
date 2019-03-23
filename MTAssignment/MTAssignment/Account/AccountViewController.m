//
//  AccountViewController.m
//  MTAssignment
//
//  Created by Wu Chengyuan on 2019/03/23.
//  Copyright © 2019 Wu Chengyuan. All rights reserved.
//

#import "AccountViewController.h"
#import "MTHeaderView.h"
#import "AccountViewModel.h"
#import "MTTableViewController.h"
#import "MTSimpleTableViewCell.h"

static NSString *const kAccountCellIdentifier = @"accountCell";


@interface AccountViewController () <UITableViewDelegate, UITableViewDataSource>
//Data
@property (strong, nonatomic) AccountViewModel *viewModel;

//View
@property (strong, nonatomic) MTHeaderView *headerView;

//ViewController
@property (strong, nonatomic) MTTableViewController *tableViewController;

@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didViewModelUpdate:) name:kAccountUpdateNotification object:nil];
    self.viewModel = [[AccountViewModel alloc] init];
    [self setUpViews];
}

- (void)didViewModelUpdate:(NSNotification *)notification {
    [self.tableViewController.tableView reloadData];
    [self.headerView setMainCaption:self.viewModel.headerTitle];
}

- (void)setUpViews {
    self.navigationItem.title = @"Balance";
    [self setUpTableViewController];
}

- (void)setUpTableViewController {
    
    [self setUpHeaderView];
    
    self.tableViewController = ({
        MTTableViewController *tableVC = [[MTTableViewController alloc] initWithStyle:UITableViewStylePlain];
        tableVC.tableView.delegate = self;
        tableVC.tableView.dataSource = self;

        //layout
        [self addChildViewController:tableVC];
        [self.view addSubview:tableVC.view];
        [tableVC didMoveToParentViewController:self];
        
        tableVC.view.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSLayoutConstraint *leftAnchor = [tableVC.view.leftAnchor constraintEqualToAnchor:self.view.leftAnchor];
        NSLayoutConstraint *topAnchor = [tableVC.view.topAnchor constraintEqualToAnchor:self.headerView.bottomAnchor];
        NSLayoutConstraint *width = [tableVC.view.widthAnchor constraintEqualToAnchor:self.view.widthAnchor];
        NSLayoutConstraint *bottom = [tableVC.view.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor];
        [NSLayoutConstraint activateConstraints:@[leftAnchor, topAnchor, width, bottom]];
        tableVC;
    });
}

- (void)setUpHeaderView {
    self.headerView = ({
        MTHeaderView *view = [[MTHeaderView alloc] init];
        [view setMainCaption:self.viewModel.headerTitle];
        [self.view addSubview:view];
        
        //layout
        view.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *leftAnchor = [view.leftAnchor constraintEqualToAnchor:self.view.leftAnchor];
        NSLayoutConstraint *topAnchor = [view.topAnchor constraintEqualToAnchor:self.view.topAnchor];
        NSLayoutConstraint *width = [view.widthAnchor constraintEqualToAnchor:self.view.widthAnchor];
        NSLayoutConstraint *height = [view.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:0.15f];
        [NSLayoutConstraint activateConstraints:@[leftAnchor, topAnchor, width, height]];
        view;
    });
}


#pragma mark UITableViewDataSource

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
