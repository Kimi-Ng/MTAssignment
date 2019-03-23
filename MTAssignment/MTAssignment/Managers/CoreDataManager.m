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

- (NSArray <Account *> *)fetchAccountsFromCoreData {
    return [self fetchCoreDataWithEntry:@"Account" predicate:nil];
}

- (NSArray <Transaction *> *)fetchTransactionsFromCoreDataWithAccountID:(NSInteger)accountID {
    return [self fetchCoreDataWithEntry:@"Transaction" predicate:[NSPredicate predicateWithFormat:@"accountID == %u", accountID]];
}

- (NSArray *)fetchCoreDataWithEntry:(NSString *)entry predicate:(NSPredicate *)predicate{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context =  appDelegate.persistentContainer.viewContext;
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
