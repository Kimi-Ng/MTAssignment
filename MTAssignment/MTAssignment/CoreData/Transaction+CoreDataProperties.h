//
//  Transaction+CoreDataProperties.h
//  MTAssignment
//
//  Created by Wu Chengyuan on 2019/03/23.
//  Copyright © 2019 Wu Chengyuan. All rights reserved.
//
//

#import "Transaction+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Transaction (CoreDataProperties)

@property (nonatomic) int16_t accountID;
@property (nonatomic) int16_t transactionID;
@property (nonatomic) int16_t categoryID;
@property (nonatomic) double amount;
@property (nullable, nonatomic, copy) NSString *content;
@property (nullable, nonatomic, copy) NSDate *date;

+ (NSFetchRequest<Transaction *> *)fetchRequest;

- (instancetype)initWithContext:(NSManagedObjectContext *)moc propertyDict:(NSDictionary *)propertyDict;
    
@end

NS_ASSUME_NONNULL_END
