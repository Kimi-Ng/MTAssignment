//
//  AccountViewController.h
//  MTAssignment
//
//  Created by Wu Chengyuan on 2019/03/23.
//  Copyright © 2019 Wu Chengyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountViewModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface AccountViewController : UIViewController
@property (strong, nonatomic, readonly) AccountViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
