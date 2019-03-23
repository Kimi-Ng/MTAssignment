//
//  FetchManager.h
//  MTAssignment
//
//  Created by Wu Chengyuan on 2019/03/23.
//  Copyright © 2019 Wu Chengyuan. All rights reserved.
//
//  Manage Remote Fetch (mock with local JSON files)
//

#import <Foundation/Foundation.h>
#import "Account+CoreDataClass.h"
#import "Transaction+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface FetchManager : NSObject

+ (instancetype)sharedInstance;

- (void)fetchAccountsWithCompletion:(void(^)(NSMutableArray<Account*>*))completion;
    
- (void)fetchTransactionsWithAccountID:(NSInteger)accountID
                            completion:(void(^)(NSMutableArray<Transaction *>*))completion;

@end

NS_ASSUME_NONNULL_END
