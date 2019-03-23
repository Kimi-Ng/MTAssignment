//
//  FetchManagerTests.m
//  MTAssignmentTests
//
//  Created by Wu Chengyuan on 2019/03/24.
//  Copyright © 2019 Wu Chengyuan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FetchManager.h"
#import "FetchManager+Private.h"

//@interface FetchManager (Private)
//
//- (NSDictionary *)parseJSON:(NSString * __nonnull)json;
//
//- (NSString *)readFile:(NSString * __nonnull)fileName;
//
//- (NSString *)fileNameForAccountID:(NSInteger)accountID;
//
//@end


@interface FetchManagerTests : XCTestCase

@end

@implementation FetchManagerTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testParseJSON {
    NSString *valid_JSON_empty = @"{}";
    NSString *key = @"key";
    NSString *value = @"value";
    NSString *valid_JSON = [NSString stringWithFormat:@"{\"%@\":\"%@\"}",key, value];
    NSString *invalid_JSON_no_value = [NSString stringWithFormat:@"{\"%@\"}",key];
    
    NSDictionary *result = [[FetchManager sharedInstance] parseJSON:valid_JSON];
    
    XCTAssertTrue([result[key] isEqualToString:value]);
    XCTAssertNotNil([[FetchManager sharedInstance] parseJSON:valid_JSON_empty]);
    XCTAssertNil([[FetchManager sharedInstance] parseJSON:invalid_JSON_no_value]);
    
}
- (void)testReadFile {
    XCTAssertNil([[FetchManager sharedInstance] readFile:@"non_exist_file"]);
}

- (void)testFileNameForAccountID {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    XCTAssertNil([[FetchManager sharedInstance] fileNameForAccountID:0]);
    XCTAssertNotNil([[FetchManager sharedInstance] fileNameForAccountID:1]);
    XCTAssertNotNil([[FetchManager sharedInstance] fileNameForAccountID:2]);
    XCTAssertNotNil([[FetchManager sharedInstance] fileNameForAccountID:3]);
    XCTAssertNil([[FetchManager sharedInstance] fileNameForAccountID:4]);
}

@end
