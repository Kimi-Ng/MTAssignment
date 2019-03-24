//
//  CoreDataManager+Private.h
//  MTAssignment
//
//  Created by Wu Chengyuan on 2019/03/24.
//  Copyright © 2019 Wu Chengyuan. All rights reserved.
//

#import "CoreDataManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataManager (Private)

- (void)updateAccountWithData:(NSDictionary *)data
                      context:(NSManagedObjectContext *)context
                   completion:(void(^)(NSMutableArray <Account*> *))completion;

- (void)updateTransactionWithAccountID:(NSInteger)accountID
                                  data:(NSDictionary *)data
                               context:(NSManagedObjectContext *)context
                            completion:(void(^)(NSMutableArray <Transaction *> *))completion;

- (NSArray *)fetchCoreDataWithEntry:(NSString *)entry
                            context:(NSManagedObjectContext *)context
                          predicate:(NSPredicate * _Nullable )predicate;
@end

NS_ASSUME_NONNULL_END
