//
//  Transaction+CoreDataProperties.m
//  MTAssignment
//
//  Created by Wu Chengyuan on 2019/03/23.
//  Copyright © 2019 Wu Chengyuan. All rights reserved.
//
//

#import "Transaction+CoreDataProperties.h"

@implementation Transaction (CoreDataProperties)

@dynamic accountID;
@dynamic transactionID;
@dynamic categoryID;
@dynamic amount;
@dynamic content;
@dynamic date;

+ (NSFetchRequest<Transaction *> *)fetchRequest {
    return [NSFetchRequest fetchRequestWithEntityName:@"Transaction"];
}

- (instancetype)initWithContext:(NSManagedObjectContext *)moc propertyDict:(NSDictionary *)propertyDict {
    Transaction *transaction = [[Transaction alloc] initWithContext:moc];
    transaction.accountID = [propertyDict[@"account_id"] intValue];
    transaction.transactionID = [propertyDict[@"id"] intValue];
    transaction.categoryID = [propertyDict[@"category_id"] intValue];
    transaction.amount = [propertyDict[@"amount"] doubleValue];
    transaction.content = propertyDict[@"description"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss+09:00"; //TODO: how to get the time zone?
    transaction.date = [formatter dateFromString:propertyDict[@"date"]];
    return transaction;
}


@end
