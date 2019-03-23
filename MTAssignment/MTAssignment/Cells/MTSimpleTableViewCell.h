//
//  MTSimpleTableViewCell.h
//  MTAssignment
//
//  Created by Wu Chengyuan on 2019/03/23.
//  Copyright © 2019 Wu Chengyuan. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@protocol MTSimpleTableViewCellDataProtocol <NSObject>

- (NSString *)mainDescription;
- (NSString *)subDescription;

@end

@interface MTSimpleTableViewCell : UITableViewCell
- (void)populateCellWithData:(id<MTSimpleTableViewCellDataProtocol>)data;

@end

NS_ASSUME_NONNULL_END
