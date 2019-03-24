//
//  TransactionViewController.m
//  MTAssignment
//
//  Created by Wu Chengyuan on 2019/03/23.
//  Copyright © 2019 Wu Chengyuan. All rights reserved.
//

#import "TransactionViewController.h"
#import "MTTableViewController.h"
#import "MTHeaderView.h"
#import "TransactionViewController+DataSource.h"

@interface TransactionViewController ()
//Data
@property (strong, nonatomic, readwrite) TransactionViewModel *viewModel;
//UI
@property (strong, nonatomic) MTTableViewController *tableViewController;
@property (strong, nonatomic) MTHeaderView *headerView;

@end

@implementation TransactionViewController


- (instancetype)initWithAccountID:(NSInteger)accountID {
    self = [super init];
    if (self) {
        self.viewModel = [[TransactionViewModel alloc] initWithAccountID:accountID];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didDataUpdate:) name:kTransactionUpdateNotification object:nil];
}

- (void)didDataUpdate:(NSNotification *)notification {
    [self.tableViewController.tableView reloadData];
    //TODO: update header view
}

- (void)setupHeaderView {
    self.headerView = ({
        MTHeaderView *view = [[MTHeaderView alloc] init];
        [self.view addSubview:view];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *leftAnchor = [view.leftAnchor constraintEqualToAnchor:self.view.leftAnchor];
        NSLayoutConstraint *topAnchor = [view.topAnchor constraintEqualToAnchor:self.view.topAnchor];
        NSLayoutConstraint *width = [view.widthAnchor constraintEqualToAnchor:self.view.widthAnchor];
        NSLayoutConstraint *height = [view.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:0.15f];
        [NSLayoutConstraint activateConstraints:@[leftAnchor, topAnchor, width, height]];
        view;
    });
}

- (void)setupTableViewController {
    [self setupHeaderView];
    MTTableViewController *vc = [[MTTableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    [vc didMoveToParentViewController:self];
    
    vc.tableView.delegate = self;
    vc.tableView.dataSource = self;
    vc.tableView.allowsSelection = NO;
    vc.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *leftAnchor = [vc.view.leftAnchor constraintEqualToAnchor:self.view.leftAnchor];
    NSLayoutConstraint *topAnchor = [vc.view.topAnchor constraintEqualToAnchor:self.headerView.bottomAnchor];
    NSLayoutConstraint *width = [vc.view.widthAnchor constraintEqualToAnchor:self.view.widthAnchor];
    NSLayoutConstraint *bottom = [vc.view.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor];
    [NSLayoutConstraint activateConstraints:@[leftAnchor, topAnchor, width, bottom]];
    self.tableViewController = vc;
    
}

- (void)setUpView {
    self.navigationItem.title = @"Transactions";
    [self setupTableViewController];
}


@end
