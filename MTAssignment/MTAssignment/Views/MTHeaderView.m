//
//  MTHeaderView.m
//  MTAssignment
//
//  Created by Wu Chengyuan on 2019/03/23.
//  Copyright © 2019 Wu Chengyuan. All rights reserved.
//

#import "MTHeaderView.h"

@interface MTHeaderView()
@property (strong, nonatomic) UILabel *caption_1;
@property (strong, nonatomic) UILabel *caption_2;
@property (strong, nonatomic) UILabel *caption_3;
@property (strong, nonatomic) UILabel *subCaption_2;
@property (strong, nonatomic) UILabel *subCaption_3;

@end


@implementation MTHeaderView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setUpViews];
    }
    return self;
}

- (void)setMainCaption:(NSString *)caption
{
    [self.caption_2 setText:caption];
}


- (void)setUpViews {
    [self setBackgroundColor:[UIColor orangeColor]];
    CGFloat space = 10.f;
    self.caption_1 = ({
        UILabel *label = [[UILabel alloc] init];
        [label setTextColor:[UIColor whiteColor]];
        [label setFont:[UIFont systemFontOfSize:20]];
        [self addSubview:label];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *leading = [label.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:space];
        NSLayoutConstraint *top = [label.topAnchor constraintEqualToAnchor:self.topAnchor constant:space];
        NSLayoutConstraint *width = [label.widthAnchor constraintLessThanOrEqualToAnchor:self.widthAnchor multiplier:1];
        //        NSLayoutConstraint *height = [label.heightAnchor constraintEqualToConstant:30.f];
        NSLayoutConstraint *height = [label.heightAnchor constraintEqualToAnchor:self.heightAnchor multiplier:0.25f];
        
        [NSLayoutConstraint activateConstraints:@[leading, top, width, height]];
        label;
    });
    
    self.caption_2 = ({
        UILabel *label = [[UILabel alloc] init];
        [label setTextColor:[UIColor whiteColor]];
        [label setFont:[UIFont systemFontOfSize:36]];
        [self addSubview:label];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *leading = [label.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:space];
        NSLayoutConstraint *top = [label.topAnchor constraintEqualToAnchor:self.caption_1.bottomAnchor constant:space];
        NSLayoutConstraint *height = [label.heightAnchor constraintLessThanOrEqualToAnchor:self.heightAnchor multiplier:0.5];
        [NSLayoutConstraint activateConstraints:@[leading, top, height]];
        label;
    });
    
    self.caption_3 = ({
        UILabel *label = [[UILabel alloc] init];
        [label setTextColor:[UIColor whiteColor]];
        [label setFont:[UIFont systemFontOfSize:20]];
        [self addSubview:label];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *leading = [label.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:space];
        NSLayoutConstraint *top = [label.topAnchor constraintEqualToAnchor:self.caption_2.bottomAnchor constant:space];
        NSLayoutConstraint *width = [label.widthAnchor constraintLessThanOrEqualToAnchor:self.widthAnchor multiplier:0.5];
        NSLayoutConstraint *height = [label.heightAnchor constraintLessThanOrEqualToAnchor:self.heightAnchor multiplier:0.25];
        [NSLayoutConstraint activateConstraints:@[leading, top, width, height]];
        label;
    });
    
    self.subCaption_2 = ({
        UILabel *label = [[UILabel alloc] init];
        [label setTextColor:[UIColor whiteColor]];
        [self addSubview:label];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *trailing = [label.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:space];
        NSLayoutConstraint *bottom = [label.bottomAnchor constraintEqualToAnchor:self.caption_2.bottomAnchor];
        NSLayoutConstraint *width = [label.widthAnchor constraintLessThanOrEqualToAnchor:self.widthAnchor multiplier:0.5];
        NSLayoutConstraint *height = [label.heightAnchor constraintLessThanOrEqualToAnchor:self.heightAnchor multiplier:0.5];
        
        
        NSLayoutConstraint *caption2trailing = [self.caption_2.trailingAnchor constraintEqualToAnchor:label.leadingAnchor];
        
        [NSLayoutConstraint activateConstraints:@[trailing, bottom, width, height, caption2trailing]];
        label;
    });
    
    
    self.subCaption_3 = ({
        UILabel *label = [[UILabel alloc] init];
        [label setTextColor:[UIColor whiteColor]];
        [self addSubview:label];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *trailing = [label.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:space];
        NSLayoutConstraint *top = [label.topAnchor constraintEqualToAnchor:self.caption_3.topAnchor];
        NSLayoutConstraint *width = [label.widthAnchor constraintLessThanOrEqualToAnchor:self.widthAnchor multiplier:0.5];
        NSLayoutConstraint *height = [label.heightAnchor constraintLessThanOrEqualToAnchor:self.heightAnchor multiplier:0.25];
        [NSLayoutConstraint activateConstraints:@[trailing, top, width, height]];
        label;
    });
    
    self.caption_1.text = @"Digital Money";
    self.caption_2.text = @"JPY -";
    self.caption_3.text = @"";
    self.subCaption_2.text = @"";
    self.subCaption_3.text = @"";
    
}
@end
