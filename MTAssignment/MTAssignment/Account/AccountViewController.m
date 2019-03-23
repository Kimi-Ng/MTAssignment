//
//  AccountViewController.m
//  MTAssignment
//
//  Created by Wu Chengyuan on 2019/03/23.
//  Copyright © 2019 Wu Chengyuan. All rights reserved.
//

#import "AccountViewController.h"
#import "AccountViewController+DataSource.h"
#import "MTHeaderView.h"
#import "MTTableViewController.h"
#import "MTSimpleTableViewCell.h"



@interface AccountViewController ()
//Data
@property (strong, nonatomic, readwrite) AccountViewModel *viewModel;
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

@end
