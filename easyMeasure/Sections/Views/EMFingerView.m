//
//  FingerView.m
//  easyMeasure
//
//  Created by qiwl on 2017/6/9.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import "EMFingerView.h"
#import "UIImage+Extension.h"

@implementation EMFingerView
- (instancetype)initWithLeft:(BOOL)left fingerType:(FingerType)fingerType{
    self = [super init];
    if (self) {
        _isLeft = left;
        _fingerType = fingerType;
        switch (fingerType) {
            case kFingerOfThumb:
                _marginDisease = 13;
                _buttonSize = CGSizeMake(68, 44);
                _radius = 34;
                _finger = kLocalization(@"em_thumb");
                break;
            case kFingerOfIndexFinger:
                _marginDisease = 14;
                _buttonSize = CGSizeMake(60, 39);
                _radius = 28;
                _finger = kLocalization(@"em_indexfinger");

                break;
            case kFingerOfMiddleFinger:
                _marginDisease = 11;
                _buttonSize = CGSizeMake(60, 39);
                _radius = 28;
                _finger = kLocalization(@"em_middlefinger");

                break;
            case kFingerOfRingFinger:
                _marginDisease = 11;
                _buttonSize = CGSizeMake(69, 39);
                _radius = 28;
                _finger = kLocalization(@"em_ringfinger");

                break;
            case kFingerOfLittleFinger:
                _marginDisease = 11;
                _buttonSize = CGSizeMake(60, 39);
                _radius = 28;
                _finger = kLocalization(@"em_littlefinger");

                break;
            default:
                break;
        }
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = kColor_Button2;
    _contentView.layer.masksToBounds = YES;
    _contentView.layer.cornerRadius = _radius;
    [self addSubview:_contentView];
    _fingerBtn = [[EMMeasureButton alloc] init];
    _fingerBtn.layer.masksToBounds = YES;
    _fingerBtn.layer.cornerRadius = _buttonSize.height/2;
    [_fingerBtn setImage:[UIImage drawImageWithSize:CGSizeMake(_buttonSize.width*2, _buttonSize.height*2) color:kColor_Button1] forState:UIControlStateNormal];
    [_fingerBtn setImage:[UIImage drawImageWithSize:CGSizeMake(_buttonSize.width*2, _buttonSize.height*2) color:kColor_Highlight_Button3] forState:UIControlStateHighlighted];
    _fingerBtn.textLabel.text = _finger;
    _fingerBtn.textLabel.font = [UIFont systemFontOfSize:14];
    _fingerBtn.textLabel.textColor = kColor_Text1;
    [_fingerBtn addTarget:self action:@selector(fingerBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_fingerBtn];
    MJWeakSelf;
    if (_isLeft) {
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.bottom.equalTo(@0);
            make.left.equalTo(@(-_radius));
            make.right.equalTo(@0);
        }];
        [_fingerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-_marginDisease));
            make.centerY.equalTo(weakSelf.contentView.mas_centerY);
            make.height.equalTo(@(weakSelf.buttonSize.height));
            make.width.equalTo(@(weakSelf.buttonSize.width));
        }];
    }else{
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.bottom.equalTo(@0);
            make.left.equalTo(@0);
            make.right.equalTo(@(_radius));
        }];
        [_fingerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(_marginDisease));
            make.centerY.equalTo(weakSelf.contentView.mas_centerY);
            make.height.equalTo(@(weakSelf.buttonSize.height));
            make.width.equalTo(@(weakSelf.buttonSize.width));
        }];
    }
}

- (void)fingerBtnPressed{
    if (_delegate && [_delegate respondsToSelector:@selector(measureFinger:left:)]) {
        [_delegate measureFinger:_fingerType left:_isLeft];
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
