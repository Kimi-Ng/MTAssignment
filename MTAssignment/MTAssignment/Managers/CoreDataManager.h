//
//  CoreDataManager.h
//  MTAssignment
//
//  Created by Wu Chengyuan on 2019/03/23.
//  Copyright © 2019 Wu Chengyuan. All rights reserved.
//
//  Manage CoreData I/O
//

#import <Foundation/Foundation.h>
#import "Account+CoreDataClass.h"
#import "Transaction+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataManager : NSObject

+ (instancetype)sharedInstance;

- (NSArray <Account *> *)fetchAccounts;

- (NSArray <Transaction *> *)fetchTransactionsWithAccountID:(NSInteger)accountID;

- (void)updateAccountWithData:(NSDictionary *)data
                   completion:(void(^)(NSMutableArray<Account*>*))completion;

- (void)updateTransactionWithAccountID:(NSInteger)accountID
                                  data:(NSDictionary *)data
                            completion:(void(^)(NSMutableArray <Transaction *> *))completion;

@end

NS_ASSUME_NONNULL_END
