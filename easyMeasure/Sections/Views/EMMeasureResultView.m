//
//  EMMeasureResultView.m
//  easyMeasure
//
//  Created by qiwl on 2017/6/12.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import "EMMeasureResultView.h"

@implementation EMMeasureResultView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    _imageView = [[UIImageView alloc] init];
    _imageView.backgroundColor = [UIColor clearColor];
    _imageView.image = [UIImage imageNamed:@"banner"];
    [self addSubview:_imageView];
    _measureTitleLabel = [[UILabel alloc] init];
    _measureTitleLabel.backgroundColor = [UIColor clearColor];
    _measureTitleLabel.text = kLocalization(@"em_label_ring_diameter");
    _measureTitleLabel.textColor = kColor_Text2;
    _measureTitleLabel.font = [UIFont systemFontOfSize:15];
    _measureTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_measureTitleLabel];
    _measureLabel = [[UILabel alloc] init];
    _measureLabel.backgroundColor = [UIColor clearColor];
    _measureLabel.textColor = kColor_Text5;
    _measureLabel.font = [UIFont boldSystemFontOfSize:40];
    _measureLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_measureLabel];
    _suggestTitleLabel = [[UILabel alloc] init];
    _suggestTitleLabel.backgroundColor = [UIColor clearColor];
    _suggestTitleLabel.text = kLocalization(@"em_label_ring_size");
    _suggestTitleLabel.textColor = kColor_Text2;
    _suggestTitleLabel.font = [UIFont systemFontOfSize:15];
    _suggestTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_suggestTitleLabel];
    
    _leftPoint = [[UIView alloc] init];
    _leftPoint.backgroundColor = [UIColor blackColor];
    _leftPoint.layer.masksToBounds = YES;
    _leftPoint.layer.cornerRadius = 4;
    [self addSubview:_leftPoint];
    _rightPoint = [[UIView alloc] init];
    _rightPoint.backgroundColor = [UIColor blackColor];
    _rightPoint.layer.masksToBounds = YES;
    _rightPoint.layer.cornerRadius = 4;
    [self addSubview:_rightPoint];
    
    _hkDegreeView = [[EMDegreeView alloc] init];
    _hkDegreeView.backgroundColor = [UIColor clearColor];
    _hkDegreeView.degreeTitleLabel.text = kLocalization(@"em_degree_hk");
    [self addSubview:_hkDegreeView];
    _euroDegreeView = [[EMDegreeView alloc] init];
    _euroDegreeView.backgroundColor = [UIColor clearColor];
    _euroDegreeView.degreeTitleLabel.text = kLocalization(@"em_degree_euro");
    [self addSubview:_euroDegreeView];
    _usDegreeView = [[EMDegreeView alloc] init];
    _usDegreeView.backgroundColor = [UIColor clearColor];
    _usDegreeView.degreeTitleLabel.text = kLocalization(@"em_degree_us");
    [self addSubview:_usDegreeView];
    
    _remeasureBtn = [[EMMeasureButton alloc] init];
    _remeasureBtn.layer.masksToBounds = YES;
    _remeasureBtn.layer.cornerRadius = 24;
    _remeasureBtn.normalColor = kColor_Button1;
    _remeasureBtn.highlightColor = kColor_Highlight_Button3;
    [_remeasureBtn setTitle:kLocalization(@"em_remeasure") forState:UIControlStateNormal];
    [_remeasureBtn setTitleColor:kColor_Text1 forState:UIControlStateNormal];
    _remeasureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:_remeasureBtn];
    CGFloat height = kScreen_Width/1.6;
    MJWeakSelf;
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@(kNavigationHeight + kStatusHeight));
        make.right.equalTo(@0);
        make.height.equalTo(@(height));
    }];
    [_measureTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(weakSelf.imageView.mas_bottom).offset(kFitWidth(31));
        make.height.equalTo(@23);
    }];
    [_measureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(weakSelf.measureTitleLabel.mas_bottom).offset(kFitWidth(14));
        make.height.equalTo(@48);
    }];
    [_suggestTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(weakSelf.measureLabel.mas_bottom).offset(kFitWidth(37));
        make.height.equalTo(@23);
    }];
    [_hkDegreeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.suggestTitleLabel.mas_bottom).offset(14);
        make.left.equalTo(@0);
        make.width.equalTo(weakSelf.euroDegreeView.mas_width);
        make.right.equalTo(weakSelf.euroDegreeView.mas_left);
        make.height.equalTo(@54);
    }];
    
    [_euroDegreeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.suggestTitleLabel.mas_bottom).offset(14);
        make.left.equalTo(weakSelf.hkDegreeView.mas_right);
        make.right.equalTo(weakSelf.usDegreeView.mas_left);
        make.height.equalTo(@54);
    }];
    
    [_usDegreeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.suggestTitleLabel.mas_bottom).offset(14);
        make.right.equalTo(@0);
        make.width.equalTo(weakSelf.euroDegreeView.mas_width);
        make.left.equalTo(weakSelf.euroDegreeView.mas_right);
        make.height.equalTo(@54);
    }];
    [_leftPoint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.suggestTitleLabel.mas_bottom).offset(38);
        make.left.equalTo(weakSelf.hkDegreeView.mas_right).offset(-4);
        make.width.equalTo(@8);
        make.height.equalTo(@8);
    }];
    [_rightPoint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.suggestTitleLabel.mas_bottom).offset(38);
        make.right.equalTo(weakSelf.usDegreeView.mas_left).offset(-4);
        make.width.equalTo(@8);
        make.height.equalTo(@8);
    }];
    
    [_remeasureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@295);
        make.height.equalTo(@44);
        make.bottom.equalTo(@(-19));
        make.centerX.equalTo(weakSelf.imageView.mas_centerX);
    }];

}

- (void)setMeasure:(EMMeasureModel *)measure{
    _measure = measure;
    _measureLabel.text = [NSString stringWithFormat:@"%0.1fmm", [_measure.width floatValue]];
    [_hkDegreeView loadWidth:kScreen_Width/3 degreeWidth:[_measure.width floatValue]];
    [_usDegreeView loadWidth:kScreen_Width/3 degreeWidth:[_measure.width floatValue]];
    [_euroDegreeView loadWidth:kScreen_Width/3 degreeWidth:[_measure.width floatValue]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
