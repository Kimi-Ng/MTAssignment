//
//  MTSimpleTableViewCell.m
//  MTAssignment
//
//  Created by Wu Chengyuan on 2019/03/23.
//  Copyright © 2019 Wu Chengyuan. All rights reserved.
//

#import "MTSimpleTableViewCell.h"

@interface MTSimpleTableViewCell ()

@property (strong, nonatomic) UILabel* titleLabel;
@property (strong, nonatomic) UILabel* contentLabel;

@end


@implementation MTSimpleTableViewCell

- (void)prepareForReuse {
    [super prepareForReuse];
    self.titleLabel.text = @"";
    self.contentLabel.text = @"";
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        [self setUpView];
    }
    return self;
}

- (void)setUpView {
    [self setBackgroundColor:[UIColor clearColor]];
    self.titleLabel = [[UILabel alloc] init];
    [self.titleLabel setTextColor:[UIColor whiteColor]];
    [self.titleLabel setText:@""];
    
    [self addSubview:self.titleLabel];
    
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *leadingAnchor = [_titleLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:20];
    NSLayoutConstraint *topAnchor = [_titleLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:10];
    NSLayoutConstraint *width = [_titleLabel.widthAnchor constraintEqualToAnchor:self.widthAnchor multiplier:0.6f];
    NSLayoutConstraint *height = [_titleLabel.heightAnchor constraintEqualToConstant:40.f];
    [NSLayoutConstraint activateConstraints:@[leadingAnchor, topAnchor, width, height]];
    
    self.contentLabel = [[UILabel alloc] init];
    [self.contentLabel setTextColor:[UIColor whiteColor]];
    [self addSubview:_contentLabel];
    self.contentLabel.text = @"";
    self.contentLabel.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *trailingAnchor = [_contentLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-20];
    
    NSLayoutConstraint *topAnchor2 = [_contentLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:10];
    NSLayoutConstraint *width2 = [_contentLabel.widthAnchor constraintLessThanOrEqualToAnchor:self.widthAnchor multiplier:0.4f];
    NSLayoutConstraint *height2 = [_contentLabel.heightAnchor constraintEqualToConstant:40.f];
    [NSLayoutConstraint activateConstraints:@[trailingAnchor, topAnchor2, width2, height2]];
}

- (void)populateCellWithData:(id<MTSimpleTableViewCellDataProtocol>)data {
    self.titleLabel.text = [data mainDescription];
    self.contentLabel.text = [data subDescription];
}

@end
