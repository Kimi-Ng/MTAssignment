//
//  Account+CoreDataProperties.m
//  MTAssignment
//
//  Created by Wu Chengyuan on 2019/03/23.
//  Copyright © 2019 Wu Chengyuan. All rights reserved.
//
//

#import "Account+CoreDataProperties.h"

@implementation Account (CoreDataProperties)

@dynamic accountID;
@dynamic baseCurrentBalance;
@dynamic currency;
@dynamic currentBalance;
@dynamic institution;
@dynamic nickname;

+ (NSFetchRequest<Account *> *)fetchRequest {
    return [NSFetchRequest fetchRequestWithEntityName:@"Account"];
}

- (instancetype)initWithContext:(NSManagedObjectContext *)moc propertyDict:(NSDictionary *)propertyDict {
    Account *account = [[Account alloc] initWithContext:moc];
    account.accountID = [propertyDict[@"id"] intValue];
    account.nickname = propertyDict[@"nickname"];
    account.institution = propertyDict[@"institution"];
    account.currency = propertyDict[@"currency"];
    account.currentBalance = [propertyDict[@"current_balance"] doubleValue];
    account.baseCurrentBalance = [propertyDict[@"current_balance_in_base"] doubleValue];
    return account;
}

@end
