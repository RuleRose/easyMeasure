//
//  EMMainView.m
//  easyMeasure
//
//  Created by qiwl on 2017/6/12.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import "EMMainView.h"
#import "UIImage+Extension.h"

@interface EMMainView ()

@end
@implementation EMMainView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    _measureNotiLabel = [[UILabel alloc] init];
    _measureNotiLabel.backgroundColor = [UIColor clearColor];
    _measureNotiLabel.text = kLocalization(@"em_label_measure_hand");
    _measureNotiLabel.textColor = kColor_Text1;
    _measureNotiLabel.font = [UIFont systemFontOfSize:16];
    _measureNotiLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_measureNotiLabel];
    
    _iconView = [[UIImageView alloc] init];
    _iconView.backgroundColor = [UIColor clearColor];
    _iconView.image = kImage(@"image");
    [self addSubview:_iconView];
    MJWeakSelf;
    _leftFingerBtn = [[EMMeasureButton alloc] init];
    _leftFingerBtn.backgroundColor = [UIColor clearColor];
    _leftFingerBtn.layer.masksToBounds = YES;
    _leftFingerBtn.layer.cornerRadius = 24;
    [_leftFingerBtn setImage:[UIImage drawImageWithSize:CGSizeMake(kScreen_Width - 59, 96) color:kColor_Button1] forState:UIControlStateNormal];
    [_leftFingerBtn setImage:[UIImage drawImageWithSize:CGSizeMake(kScreen_Width - 59, 96) color:kColor_Highlight_Button3] forState:UIControlStateHighlighted];
    _leftFingerBtn.textLabel.text = kLocalization(@"em_measure_lefthand");
    _leftFingerBtn.textLabel.font = [UIFont systemFontOfSize:16];
    _leftFingerBtn.textLabel.textColor = kColor_Text1;
    [self addSubview:_leftFingerBtn];
    
    _rightFingerBtn = [[EMMeasureButton alloc] init];
    _rightFingerBtn.backgroundColor = [UIColor clearColor];
    _rightFingerBtn.layer.masksToBounds = YES;
    _rightFingerBtn.layer.cornerRadius = 24;
    [_rightFingerBtn setImage:[UIImage drawImageWithSize:CGSizeMake(kScreen_Width - 59, 96) color:kColor_Button1] forState:UIControlStateNormal];
    [_rightFingerBtn setImage:[UIImage drawImageWithSize:CGSizeMake(kScreen_Width - 59, 96) color:kColor_Highlight_Button3] forState:UIControlStateHighlighted];
    _rightFingerBtn.textLabel.text = kLocalization(@"em_measure_righthand");
    _rightFingerBtn.textLabel.font = [UIFont systemFontOfSize:16];
    _rightFingerBtn.textLabel.textColor = kColor_Text1;
    [self addSubview:_rightFingerBtn];
    
    [_measureNotiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@(60 + kNavigationHeight + kStatusHeight));
        make.right.equalTo(@0);
        make.height.equalTo(@24);
    }];
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.measureNotiLabel.mas_bottom).offset(35);
        make.centerX.equalTo(weakSelf.measureNotiLabel.mas_centerX);
        make.height.equalTo(@176);
        make.width.equalTo(@176);
    }];
    [_leftFingerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@19);
        make.top.equalTo(weakSelf.iconView.mas_bottom).offset(49);
        make.right.equalTo(weakSelf.rightFingerBtn.mas_left).offset(-21);
        make.height.equalTo(@48);
        make.width.equalTo(weakSelf.rightFingerBtn.mas_width);
    }];
    [_rightFingerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-19));
        make.top.equalTo(weakSelf.iconView.mas_bottom).offset(49);
        make.left.equalTo(weakSelf.leftFingerBtn.mas_right).offset(21);
        make.height.equalTo(@48);
        make.width.equalTo(weakSelf.rightFingerBtn.mas_width);
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
