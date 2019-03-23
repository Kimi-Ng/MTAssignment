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

- (NSArray <Account *> *)fetchAccountsFromCoreData;
- (NSArray <Transaction *> *)fetchTransactionsFromCoreDataWithAccountID:(NSInteger)accountID;

@end

NS_ASSUME_NONNULL_END
