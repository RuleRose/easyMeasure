//
//  FingerView.m
//  easyMeasure
//
//  Created by qiwl on 2017/6/9.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import "FingerView.h"

@implementation FingerView
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
                _finger = @"拇指";
                break;
            case kFingerOfIndexFinger:
                _marginDisease = 14;
                _buttonSize = CGSizeMake(60, 39);
                _radius = 28;
                _finger = @"食指";

                break;
            case kFingerOfMiddleFinger:
                _marginDisease = 11;
                _buttonSize = CGSizeMake(60, 39);
                _radius = 28;
                _finger = @"中指";

                break;
            case kFingerOfRingFinger:
                _marginDisease = 11;
                _buttonSize = CGSizeMake(69, 39);
                _radius = 28;
                _finger = @"无名指";

                break;
            case kFingerOfLittleFinger:
                _marginDisease = 11;
                _buttonSize = CGSizeMake(60, 39);
                _radius = 28;
                _finger = @"小指";

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
    _fingerBtn = [[MeasureButton alloc] init];
    _fingerBtn.layer.masksToBounds = YES;
    _fingerBtn.layer.cornerRadius = _buttonSize.height/2;
    _fingerBtn.normalColor = kColor_Button1;
    _fingerBtn.highlightColor = kColor_Highlight_Button3;
    [_fingerBtn setTitle:_finger forState:UIControlStateNormal];
    [_fingerBtn setTitleColor:kColor_Text1 forState:UIControlStateNormal];
    _fingerBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    MJWeakSelf;
    _fingerBtn.measureBlock = ^(){
        if (weakSelf.delegate && [_delegate respondsToSelector:@selector(measureFinger:left:)]) {
            [weakSelf.delegate measureFinger:weakSelf.fingerType left:weakSelf.isLeft];
        }
    };
    [self addSubview:_fingerBtn];
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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
