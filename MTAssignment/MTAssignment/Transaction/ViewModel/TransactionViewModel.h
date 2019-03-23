//
//  TransactionViewModel.h
//  MTAssignment
//
//  Created by Wu Chengyuan on 2019/03/23.
//  Copyright © 2019 Wu Chengyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kTransactionUpdateNotification @"kTransactionUpdateNotification"

NS_ASSUME_NONNULL_BEGIN

@class TransactionModel;

@interface TransactionViewModel : NSObject
@property (strong, nonatomic, readonly) NSArray<TransactionModel *> *data;

- (instancetype)initWithAccountID:(NSInteger)accountID;

- (void)update;

@end

@interface TransactionModel : NSObject
@property (strong, nonatomic) NSString *section;
@property (strong, nonatomic) NSArray *transactionList;

- (instancetype)initWithSection:(NSString *)section transactions:(NSArray *)transactions;

@end


NS_ASSUME_NONNULL_END
