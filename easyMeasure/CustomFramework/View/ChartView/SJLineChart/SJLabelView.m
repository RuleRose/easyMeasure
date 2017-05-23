//
//  SJLabelView.m
//  unicorn
//
//  Created by 肖君 on 16/12/15.
//  Copyright © 2016年 johnxiao. All rights reserved.
//

#import "SJLabelView.h"

@implementation SJLabelView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 4, frame.size.width, 16)];
        self.temperatureLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 16, frame.size.width, frame.size.height - 16)];
        [self.dateLabel setFont:kFont9];
        [self.dateLabel setTextColor:kColor_4];
        [self.dateLabel setTextAlignment:NSTextAlignmentCenter];
        [self.dateLabel setAdjustsFontSizeToFitWidth:YES];
        [self.temperatureLabel setFont:kFont14];
        [self.temperatureLabel setTextColor:kColor_4];
        [self.temperatureLabel setTextAlignment:NSTextAlignmentCenter];
        [self.temperatureLabel setAdjustsFontSizeToFitWidth:YES];

        [self.layer setCornerRadius:kCorner_radio];
        [self.layer setMasksToBounds:YES];
        [self setBackgroundColor:kColor_12];
        [self addSubview:self.dateLabel];
        [self addSubview:self.temperatureLabel];
    }
    return self;
}

@end
