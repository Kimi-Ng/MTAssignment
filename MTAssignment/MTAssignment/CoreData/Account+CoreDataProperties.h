//
//  Account+CoreDataProperties.h
//  MTAssignment
//
//  Created by Wu Chengyuan on 2019/03/23.
//  Copyright © 2019 Wu Chengyuan. All rights reserved.
//
//

#import "Account+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Account (CoreDataProperties)

@property (nonatomic) int16_t accountID;
@property (nonatomic) double baseCurrentBalance;
@property (nullable, nonatomic, copy) NSString *currency;
@property (nonatomic) double currentBalance;
@property (nullable, nonatomic, copy) NSString *institution;
@property (nullable, nonatomic, copy) NSString *nickname;

+ (NSFetchRequest<Account *> *)fetchRequest;

- (instancetype)initWithContext:(NSManagedObjectContext *)moc propertyDict:(NSDictionary *)propertyDict;

@end

NS_ASSUME_NONNULL_END
