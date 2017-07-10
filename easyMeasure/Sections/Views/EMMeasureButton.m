//
//  MeasureButton.m
//  easyMeasure
//
//  Created by qiwl on 2017/6/9.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import "EMMeasureButton.h"

@implementation EMMeasureButton
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    _textLabel = [[UILabel alloc] init];
    _textLabel.userInteractionEnabled = NO;
    _textLabel.backgroundColor = [UIColor clearColor];
    _textLabel.textColor = kColor_Text1;
    _textLabel.font = [UIFont systemFontOfSize:16];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_textLabel];
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    
    _iconView = [[UIImageView alloc] init];
    _iconView.userInteractionEnabled = NO;
    _iconView.backgroundColor = [UIColor clearColor];
    _iconView.contentMode = UIViewContentModeCenter;
    [self addSubview:_iconView];
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
