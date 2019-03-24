//
//  CoreDataManagerTests.m
//  MTAssignmentTests
//
//  Created by Wu Chengyuan on 2019/03/24.
//  Copyright © 2019 Wu Chengyuan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CoreDataManager+Private.h"
#import "FetchManager+Private.h"

@interface CoreDataManagerTests : XCTestCase
@property (nonatomic,retain) NSManagedObjectContext *moc;
@property (nonatomic, retain) NSPersistentContainer *mockPersistentContainer;

@end

@implementation CoreDataManagerTests

- (void)setUp {
    NSManagedObjectModel *mom = [NSManagedObjectModel mergedModelFromBundles:[NSArray arrayWithObject:[NSBundle mainBundle]]];
 
    self.mockPersistentContainer = [NSPersistentContainer persistentContainerWithName:@"MTAssignment"];
    NSPersistentStoreDescription *desp = [[NSPersistentStoreDescription alloc] init];
    desp.type = NSInMemoryStoreType;
    desp.shouldAddStoreAsynchronously = NO;
    self.mockPersistentContainer.persistentStoreDescriptions = @[desp];
    [self.mockPersistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription * _Nonnull desc, NSError * _Nullable error) {
        
    }];
    
    self.moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    self.moc.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
}

- (void)tearDown {
    self.moc = nil;
    self.mockPersistentContainer = nil;
}

- (void)testAccountInit {
    NSDictionary *dict = @{@"id":@(1), @"nickname":@"SMBC"};
    Account *account = [[Account alloc] initWithContext:self.moc propertyDict:dict];
    XCTAssertTrue([account.nickname isEqualToString:@"SMBC"]);
}

- (void)testTransactionInit {
    NSDictionary *dict = @{@"account_id":@(1), @"id":@(2), @"amount":@(100)};
    Transaction *transaction = [[Transaction alloc] initWithContext:self.moc propertyDict:dict];
    XCTAssertTrue(transaction.accountID == 1);
    XCTAssertTrue(transaction.transactionID == 2);
    XCTAssertTrue(transaction.amount == 100);
}

- (void)testFetch {
    Account *acc = [NSEntityDescription insertNewObjectForEntityForName:@"Account" inManagedObjectContext:self.mockPersistentContainer.viewContext];
    acc.accountID = 1;
    acc.currency = @"USD";

    XCTAssertTrue(acc.accountID == 1);
    NSArray<Account *> *accountList = [[CoreDataManager sharedInstance] fetchCoreDataWithEntry:@"Account" context:self.mockPersistentContainer.viewContext predicate:nil];
    XCTAssertTrue(accountList.count == 1);
    XCTAssertTrue([accountList[0].currency isEqualToString:@"USD"]);
}


@end
