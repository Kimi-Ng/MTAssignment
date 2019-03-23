//
//  TransactionViewModel.m
//  MTAssignment
//
//  Created by Wu Chengyuan on 2019/03/23.
//  Copyright © 2019 Wu Chengyuan. All rights reserved.
//

#import "TransactionViewModel.h"
#import "FetchManager.h"
#import "CoreDataManager.h"
#import "Transaction+CoreDataClass.h"

@interface TransactionViewModel()
@property (assign, nonatomic) NSInteger accountID;
@property (strong, nonatomic, readwrite) NSArray<TransactionModel *> *data;

@end


@implementation TransactionViewModel

- (instancetype)initWithAccountID:(NSInteger)accountID {
    self = [super init];
    if (self) {
        self.accountID = accountID;
        
        //data from coredata
        NSArray <Transaction *> * transactions = [[CoreDataManager sharedInstance] fetchTransactionsWithAccountID:accountID];
        self.data = [self viewModelFromTransacitonArray:transactions];
        if (self.data == nil || self.data.count == 0) {
            //fetch remote
            [self update];
        }
    }
    return self;
}

- (void)update
{
    //fetch from remote
    [[FetchManager sharedInstance] fetchTransactionsWithAccountID:self.accountID completion:^(NSMutableArray<Transaction *> * _Nonnull transactionList) {
        //need to update viewModel
        self.data = [self viewModelFromTransacitonArray:transactionList];
        [[NSNotificationCenter defaultCenter] postNotificationName:kTransactionUpdateNotification object:@{@"NewData":self.data}];
    }];
}


#pragma mark - private helper

//transform Transaction List into TransactionModel list
- (NSArray <TransactionModel *> *)viewModelFromTransacitonArray:(NSArray <Transaction *> *)transactionList {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [transactionList enumerateObjectsUsingBlock:^(Transaction * _Nonnull transaction, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *section = [self sectionFromDate:transaction.date];
        if (dict[section] == nil) {
            dict[section] = [[NSMutableArray alloc] initWithObjects:transaction, nil];
        } else {
            [dict[section] addObject:transaction];
        }
    }];
    
    NSMutableArray<TransactionModel *> *modelArr = [[NSMutableArray alloc] init];
    [dict enumerateKeysAndObjectsUsingBlock:^(NSString*  _Nonnull section, NSArray<Transaction *>*  _Nonnull transactions, BOOL * _Nonnull stop) {
        TransactionModel *viewModel = [[TransactionModel alloc] initWithSection:section transactions:transactions];
        [modelArr addObject:viewModel];
    }];
    
    //sort by date
    NSSortDescriptor *sortDesc = [[NSSortDescriptor alloc] initWithKey:@"section" ascending:NO];
    [modelArr sortUsingDescriptors:@[sortDesc]];
    
    NSDateComponents *today = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSString *month = [[formatter monthSymbols] objectAtIndex:today.month-1];
    
    if ([[modelArr firstObject].section isEqualToString:[NSString stringWithFormat:@"%@ %zd", month, today.year]]) {
        [modelArr firstObject].section = @"This Month";
    }
    return modelArr;
}

//generate display string from date
- (NSString *)sectionFromDate:(NSDate*)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSString *month = [[formatter monthSymbols] objectAtIndex:components.month-1];
    return [NSString stringWithFormat:@"%@ %zd", month, components.year];
}

@end


@implementation TransactionModel

- (instancetype)initWithSection:(NSString *)section transactions:(NSArray *)transactions{
    self = [super init];
    if(self) {
        self.section = section;
        self.transactionList = transactions;
    }
    return self;
}

@end


@implementation Transaction (TSimpleTableViewCellDataProtocol)

- (NSString *)mainDescription {
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self.date];
    
    return [NSString stringWithFormat:@"%zd %@", components.day, self.content];
}

- (NSString *)subDescription {
    return [NSString stringWithFormat:@"%.2f", self.amount];
}

@end
