//
//  CoreDataManager.m
//  MTAssignment
//
//  Created by Wu Chengyuan on 2019/03/23.
//  Copyright © 2019 Wu Chengyuan. All rights reserved.
//

#import "CoreDataManager.h"
#import "AppDelegate.h"


@implementation CoreDataManager

+ (instancetype)sharedInstance
{
    static CoreDataManager *sharedInstance = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        sharedInstance = [[CoreDataManager alloc] init];
    });

    return sharedInstance;
}

- (NSArray <Account *> *)fetchAccounts {
    return [self fetchCoreDataWithEntry:@"Account" predicate:nil];
}

- (NSArray <Transaction *> *)fetchTransactionsWithAccountID:(NSInteger)accountID {
    return [self fetchCoreDataWithEntry:@"Transaction" predicate:[NSPredicate predicateWithFormat:@"accountID == %u", accountID]];
}


- (void)updateAccountWithData:(NSDictionary *)data completion:(void(^)(NSMutableArray <Account*> *))completion {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context =  appDelegate.persistentContainer.viewContext;
    [self updateAccountWithData:data context:context completion:completion];
}

- (void)updateAccountWithData:(NSDictionary *)data
                      context:(NSManagedObjectContext *)context
                   completion:(void(^)(NSMutableArray <Account*> *))completion {
    NSMutableArray <Account *> *accountList = [[NSMutableArray alloc] init];
    dispatch_async(dispatch_get_main_queue(), ^{
        // clear old data in core data
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Account"];
        NSBatchDeleteRequest *clearRequest = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
        [context executeRequest:clearRequest error:nil];
        
        // store new data to core data
        [data[@"accounts"] enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull accountDict, NSUInteger idx, BOOL * _Nonnull stop) {
            Account *account = [[Account alloc] initWithContext:context propertyDict:accountDict];
            [accountList addObject:account];
        }];
        [context save:nil];
        
        completion(accountList);
    });
}

- (void)updateTransactionWithAccountID:(NSInteger)accountID
                                  data:(NSDictionary *)data
                            completion:(void(^)(NSMutableArray <Transaction *> *))completion {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context =  appDelegate.persistentContainer.viewContext;
    [self updateTransactionWithAccountID:accountID data:data context:context completion:completion];
}

- (void)updateTransactionWithAccountID:(NSInteger)accountID
                                  data:(NSDictionary *)data
                               context:(NSManagedObjectContext *)context
                            completion:(void(^)(NSMutableArray <Transaction *> *))completion {
    NSMutableArray <Transaction*> *transactionList = [[NSMutableArray alloc] init];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // clear old transation data in core data
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Transaction"];
        request.predicate = [NSPredicate predicateWithFormat:@"accountID == %u", accountID];
        NSBatchDeleteRequest *deleteRequest = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
        [context executeRequest:deleteRequest error:nil];
        
        // add new transaction data in core data
        [data[@"transactions"] enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull transactionDict, NSUInteger idx, BOOL * _Nonnull stop) {
            Transaction *transaction = [[Transaction alloc] initWithContext:context propertyDict:transactionDict];
            [transactionList addObject:transaction];
            [context save:nil];
        }];
        
        completion(transactionList);
    });
    
}

- (NSArray *)fetchCoreDataWithEntry:(NSString *)entry predicate:(NSPredicate *)predicate{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context =  appDelegate.persistentContainer.viewContext;
    return [self fetchCoreDataWithEntry:entry context:context predicate:predicate];
}

- (NSArray *)fetchCoreDataWithEntry:(NSString *)entry
                            context:(NSManagedObjectContext *)context
                          predicate:(NSPredicate *)predicate {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entry];
    request.predicate = predicate;
    
    NSError *error;
    NSArray *result = [context executeFetchRequest:request error:&error];
    
    if (!error) {
        return result;
    } else {
        //TODO: error handling
        return nil;
    }
}



@end
