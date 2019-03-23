//
//  TransactionViewController.h
//  MTAssignment
//
//  Created by Wu Chengyuan on 2019/03/23.
//  Copyright © 2019 Wu Chengyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransactionViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TransactionViewController : UIViewController
@property (strong, nonatomic, readonly) TransactionViewModel *viewModel;

- (instancetype)initWithAccountID:(NSInteger)accountID;

@end

NS_ASSUME_NONNULL_END
