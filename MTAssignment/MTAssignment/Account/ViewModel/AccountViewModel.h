//
//  AccountViewModel.h
//  MTAssignment
//
//  Created by Wu Chengyuan on 2019/03/23.
//  Copyright © 2019 Wu Chengyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

#define kAccountUpdateNotification @"kAccountUpdateNotification"

@class AccountModel;


@interface AccountViewModel : NSObject
@property (assign, nonatomic, readonly) NSString *headerTitle;
@property (strong, nonatomic, readonly) NSArray<AccountModel *> *data;

@end

@interface AccountModel : NSObject
@property (strong, nonatomic) NSString *section;
@property (strong, nonatomic) NSArray <Account *> *accountList;

- (instancetype)initWithSection:(NSString *)section accounts:(NSArray *)accounts;
- (void)update;

@end

NS_ASSUME_NONNULL_END
