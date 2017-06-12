//
//  EMFingerChooseView.m
//  easyMeasure
//
//  Created by qiwl on 2017/6/12.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import "EMFingerChooseView.h"

@implementation EMFingerChooseView
- (instancetype)initWithIsLeft:(BOOL)isLeft
{
    self = [super init];
    if (self) {
        _isLeft = isLeft;
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    _measureNotiLabel = [[UILabel alloc] init];
    _measureNotiLabel.backgroundColor = [UIColor clearColor];
    _measureNotiLabel.text = kLocalization(@"em_label_measure_finger");
    _measureNotiLabel.textColor = kColor_Text1;
    _measureNotiLabel.font = [UIFont systemFontOfSize:16];
    _measureNotiLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_measureNotiLabel];
    _littleFingerView = [[EMFingerView alloc] initWithLeft:_isLeft fingerType:kFingerOfLittleFinger];
    [self addSubview:_littleFingerView];
    _ringFingerView = [[EMFingerView alloc] initWithLeft:_isLeft fingerType:kFingerOfRingFinger];
    [self addSubview:_ringFingerView];
    _middleFingerView = [[EMFingerView alloc] initWithLeft:_isLeft fingerType:kFingerOfMiddleFinger];
    [self addSubview:_middleFingerView];
    _indexFingerView = [[EMFingerView alloc] initWithLeft:_isLeft fingerType:kFingerOfIndexFinger];
    [self addSubview:_indexFingerView];
    _thumbView = [[EMFingerView alloc] initWithLeft:_isLeft fingerType:kFingerOfThumb];
    [self addSubview:_thumbView];
    
    CGFloat space = 60;
    if ([[UIScreen mainScreen] bounds].size.height < 667) {
        space = 48;
    }
    
    MJWeakSelf;
    [_measureNotiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@(space + kNavigationHeight + kStatusHeight));
        make.right.equalTo(@0);
        make.height.equalTo(@24);
    }];
    if (_isLeft) {
        [_littleFingerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.top.equalTo(weakSelf.measureNotiLabel.mas_bottom).offset(space);
            make.right.equalTo(@(kFitWidth(-152)));
            make.height.equalTo(@56);
        }];
        [_ringFingerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.top.equalTo(weakSelf.littleFingerView.mas_bottom).offset(10);
            make.right.equalTo(@(kFitWidth(-70)));
            make.height.equalTo(@56);
        }];
        [_middleFingerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.ringFingerView.mas_bottom).offset(10);
            make.height.equalTo(@56);
            make.left.equalTo(@0);
            make.right.equalTo(@(kFitWidth(-25)));
        }];
        [_indexFingerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.top.equalTo(weakSelf.middleFingerView.mas_bottom).offset(10);
            make.right.equalTo(@(kFitWidth(-91)));
            make.height.equalTo(@56);
        }];
        [_thumbView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.top.equalTo(weakSelf.indexFingerView.mas_bottom).offset(10);
            make.right.equalTo(@(kFitWidth(-245)));
            make.height.equalTo(@69);
        }];
    }else{
        [_littleFingerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@0);
            make.top.equalTo(weakSelf.measureNotiLabel.mas_bottom).offset(space);
            make.left.equalTo(@(kFitWidth(152)));
            make.height.equalTo(@56);
        }];
        [_ringFingerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@0);
            make.top.equalTo(weakSelf.littleFingerView.mas_bottom).offset(10);
            make.left.equalTo(@(kFitWidth(70)));
            make.height.equalTo(@56);
        }];
        [_middleFingerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@0);
            make.top.equalTo(weakSelf.ringFingerView.mas_bottom).offset(10);
            make.left.equalTo(@(kFitWidth(25)));
            make.height.equalTo(@56);
        }];
        [_indexFingerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@0);
            make.top.equalTo(weakSelf.middleFingerView.mas_bottom).offset(10);
            make.left.equalTo(@(kFitWidth(91)));
            make.height.equalTo(@56);
        }];
        [_thumbView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@0);
            make.top.equalTo(weakSelf.indexFingerView.mas_bottom).offset(10);
            make.left.equalTo(@(kFitWidth(245)));
            make.height.equalTo(@69);
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
