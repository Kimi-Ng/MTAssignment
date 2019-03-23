//
//  FetchManager.m
//  MTAssignment
//
//  Created by Wu Chengyuan on 2019/03/23.
//  Copyright © 2019 Wu Chengyuan. All rights reserved.
//

#import "FetchManager.h"
#import "AppDelegate.h"
#import "CoreDataManager.h"

static double const MOCK_FETCH_DELAY_IN_SEC = 2.f;
static NSString * const ACCOUNT_JSON_FILE = @"accounts";

@implementation FetchManager

+ (instancetype)sharedInstance {
    static FetchManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[FetchManager alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

- (void)fetchAccountsWithCompletion:(void(^)(NSMutableArray<Account*>*))completion {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //mock fetch delay
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MOCK_FETCH_DELAY_IN_SEC * NSEC_PER_SEC));
        dispatch_after(delayTime, dispatch_get_main_queue(), ^(void){
            //mock remote fetch with local JSON file
            NSDictionary *content = [self parseJSON:[self readFile:ACCOUNT_JSON_FILE]];
            
            //update new data to core data
            [[CoreDataManager sharedInstance] updateAccountWithData:content completion:^(NSMutableArray<Account *> * _Nonnull accountList) {
                completion(accountList);
            }];
        });
    });
}

- (void)fetchTransactionsWithAccountID:(NSInteger)accountID
                            completion:(void(^)(NSMutableArray<Transaction *>*))completion
{
    NSString *fileName = [self fileNameForAccountID:accountID];
    
    if (fileName == nil) {
        return completion(nil);
    }
    
    //Mock remote fetch
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //Mock remote fetch
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MOCK_FETCH_DELAY_IN_SEC * NSEC_PER_SEC));
        dispatch_after(delayTime, dispatch_get_main_queue(), ^(void){
            //mock remote fetch with local JSON file
            NSDictionary *content = [self parseJSON:[self readFile:fileName]];
            
            //update new data to core data
            [[CoreDataManager sharedInstance] updateTransactionWithAccountID:accountID data:content completion:^(NSMutableArray<Transaction *> * _Nonnull transactionList) {
                completion(transactionList);
            }];
        });
    });
}


#pragma mark - File parser

- (NSDictionary *)parseJSON:(NSString * __nonnull)json {
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    return jsonDict;
}

- (NSString *)readFile:(NSString * __nonnull)fileName {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    NSError *err;
    NSString *fileContent = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&err];
    if (err == nil) {
        return fileContent;
    } else {
        NSLog(@"%@", err);
        return nil;
    }
}


#pragma mark - Private helpers

- (NSString *)fileNameForAccountID:(NSInteger)accountID {
    NSString *fileName;
    switch (accountID) {
        case 1:
            fileName = @"transactions_1";
            break;
        case 2:
            fileName = @"transactions_2";
            break;
        case 3:
            fileName = @"transactions_3";
            break;
        default:
            break;
    }
    return fileName;
}

@end
