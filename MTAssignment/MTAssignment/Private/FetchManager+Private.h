//
//  FetchManager+Private.h
//  MTAssignment
//
//  Created by Wu Chengyuan on 2019/03/24.
//  Copyright © 2019 Wu Chengyuan. All rights reserved.
//

#import "FetchManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface FetchManager (Private)

- (NSDictionary *)parseJSON:(NSString * __nonnull)json;

- (NSString *)readFile:(NSString * __nonnull)fileName;

- (NSString *)fileNameForAccountID:(NSInteger)accountID;

@end

NS_ASSUME_NONNULL_END
