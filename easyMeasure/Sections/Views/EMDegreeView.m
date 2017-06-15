//
//  DegreeView.m
//  easyMeasure
//
//  Created by qiwl on 2017/6/10.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import "EMDegreeView.h"
#import "NSString+Extension.h"
#import "EMScreenSizeManager.h"

@implementation EMDegreeView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    _degreeTitleLabel = [[UILabel alloc] init];
    _degreeTitleLabel.backgroundColor = [UIColor clearColor];
    _degreeTitleLabel.textColor = kColor_Text2;
    _degreeTitleLabel.font = [UIFont systemFontOfSize:15];
    _degreeTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_degreeTitleLabel];
    _degreeLabel = [[UILabel alloc] init];
    _degreeLabel.backgroundColor = [UIColor clearColor];
    _degreeLabel.textColor = kColor_Text5;
    _degreeLabel.font = [UIFont boldSystemFontOfSize:20];
    _degreeLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_degreeLabel];
    _degreeUnitLabel = [[UILabel alloc] init];
    _degreeUnitLabel.backgroundColor = [UIColor clearColor];
    _degreeUnitLabel.textColor = kColor_Text5;
    _degreeUnitLabel.font = [UIFont systemFontOfSize:12];
    _degreeUnitLabel.text = kLocalization(@"em_degree_unit");
    [self addSubview:_degreeUnitLabel];
    MJWeakSelf;
    [_degreeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(@0);
        make.height.equalTo(@24);

    }];
    [_degreeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(weakSelf.degreeUnitLabel.mas_left);
        make.bottom.equalTo(@(-4));
        make.height.equalTo(@24);
    }];
    [_degreeUnitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.degreeLabel.mas_right);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
        make.height.equalTo(@24);
    }];
    
}

- (void)loadWidth:(CGFloat)width degree:(CGFloat)degree{
    _degree = degree;
    NSString *text = @"";
    if (_degree == 0) {
        text = kLocalization(@"em_degree_none");
        _degreeLabel.text = text;
        _degreeLabel.textAlignment = NSTextAlignmentCenter;
        MJWeakSelf;
        [_degreeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.bottom.equalTo(@(-4));
            make.height.equalTo(@24);
            make.right.equalTo(@0);
        }];
        [_degreeUnitLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.degreeLabel.mas_right);
            make.right.equalTo(@0);
            make.bottom.equalTo(@0);
            make.height.equalTo(@24);
        }];
    }else{
        _degreeLabel.textAlignment = NSTextAlignmentRight;
        if (_degree == (NSInteger)_degree)  {
            text = [NSString stringWithFormat:@"%0.0f",_degree];
        }else{
            text = [NSString stringWithFormat:@"%0.1f",_degree];
        }
        _degreeLabel.text = text;
        CGSize size1 = [text sizeWithFont:[UIFont systemFontOfSize:20]];
        CGSize size2 = [kLocalization(@"em_degree_unit") sizeWithFont:[UIFont systemFontOfSize:12]];
        CGFloat viewWidth = width/2 + (size1.width - size2.width)/2;
        MJWeakSelf;
        [_degreeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.bottom.equalTo(@(-4));
            make.height.equalTo(@24);
            make.width.equalTo(@(viewWidth));
        }];
        [_degreeUnitLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.degreeLabel.mas_right);
            make.right.equalTo(@0);
            make.bottom.equalTo(@0);
            make.height.equalTo(@24);
        }];
        [self layoutIfNeeded];
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
