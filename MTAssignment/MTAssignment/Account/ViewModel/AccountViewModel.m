//
//  AccountViewModel.m
//  MTAssignment
//
//  Created by Wu Chengyuan on 2019/03/23.
//  Copyright © 2019 Wu Chengyuan. All rights reserved.
//

#import "AccountViewModel.h"
#import "FetchManager.h"
#import "CoreDataManager.h"

@implementation AccountModel

- (instancetype)initWithSection:(NSString *)section accounts:(NSArray *)accounts {
    self = [super init];
    if(self) {
        self.section = section; //name to section
        self.accountList = accounts;
    }
    return self;
}

@end


@interface AccountViewModel()

@property (assign, nonatomic, readwrite) NSString *headerTitle;
@property (strong, nonatomic, readwrite) NSArray<AccountModel *> *data;

@end


@implementation AccountViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        //fetch data from core data
        NSArray *accountList = [[CoreDataManager sharedInstance] fetchAccountsFromCoreData];
        self.headerTitle = [self totalBalanceForAccounts:accountList];
        self.data = [self viewModelFromAccountList:accountList];
        
        //fetch data from remote if core data is empty
        if (self.data == nil || self.data.count == 0) {
            //fetch remote
            [self update];
        }
    }
    return self;
}

- (void)update {
    [[FetchManager sharedInstance] fetchAccountsWithCompletion:^(NSMutableArray<Account *> * _Nonnull accountList) {
        //need to update viewModel
        self.data = [self viewModelFromAccountList:accountList];
        self.headerTitle = [self totalBalanceForAccounts:accountList];
        //need to update view
        //post notification
        [[NSNotificationCenter defaultCenter] postNotificationName:kAccountUpdateNotification object:@{@"NewData":self.data}];
    }];
}

//transform Account list into AccountModel list
- (NSMutableArray <AccountModel *> *)viewModelFromAccountList:(NSArray *)accountList {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    [accountList enumerateObjectsUsingBlock:^(Account *  _Nonnull account, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *institution = account.institution;
        if (dict[institution] == nil) {
            dict[institution] = [[NSMutableArray alloc] initWithObjects:account, nil];
        } else {
            [dict[institution] addObject:account];
        }
    }];
    
    NSMutableArray<AccountModel *> *viewModelArr = [[NSMutableArray alloc] init];
    [dict enumerateKeysAndObjectsUsingBlock:^(NSString*  _Nonnull key, NSArray<Account *>*  _Nonnull accounts, BOOL * _Nonnull stop) {
        AccountModel *viewModel = [[AccountModel alloc] initWithSection:key accounts:accounts];
        [viewModelArr addObject:viewModel];
        
    }];
    
    NSSortDescriptor *sortDesc = [[NSSortDescriptor alloc] initWithKey:@"section" ascending:YES];
    [viewModelArr sortUsingDescriptors:@[sortDesc]];
    
    return viewModelArr;
}


#pragma mark - Private helpers

- (NSString *)totalBalanceForAccounts:(NSArray <Account *> *)accounts {
    NSNumber *sum = [accounts valueForKeyPath:@"@sum.baseCurrentBalance"];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setCurrencySymbol:@"JPY"];
    return [formatter stringFromNumber:sum];
}

@end
