//
//  EMMeasureView.m
//  easyMeasure
//
//  Created by qiwl on 2017/6/12.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import "EMMeasureView.h"
#import "EMScreenSizeManager.h"

@implementation EMMeasureView
- (instancetype)initWithFingerType:(FingerType)fingerType isLeft:(BOOL)isLeft
{
    self = [super init];
    if (self) {
        _isLeft = isLeft;
        _fingerType = fingerType;
        _time = 0.03;
        _widthUnit =  [[EMScreenSizeManager defaultInstance] widthOfOnePoint];
        [self setupViews];
        [self loadData];
    }
    return self;
}

- (void)loadData{
    NSString *notiText = @"";
    if (_isLeft) {
        notiText = [notiText stringByAppendingString:kLocalization(@"em_left_hand")];
        if(_fingerType == kFingerOfThumb){
            _fingerImageView.image= kImage(@"muzhi_1");
        }else{
            _fingerImageView.image= kImage(@"shou_1");
        }
    }else{
        notiText = [notiText stringByAppendingString:kLocalization(@"em_right_hand")];
        if(_fingerType == kFingerOfThumb){
            _fingerImageView.image= kImage(@"muzhi_2");
        }else{
            _fingerImageView.image= kImage(@"shou_2");
        }
    }
    
    switch (_fingerType) {
        case kFingerOfThumb:
            notiText = [notiText stringByAppendingString:kLocalization(@"em_thumb")];
            break;
        case kFingerOfIndexFinger:
            notiText = [notiText stringByAppendingString:kLocalization(@"em_indexfinger")];
            break;
        case kFingerOfMiddleFinger:
            notiText = [notiText stringByAppendingString:kLocalization(@"em_middlefinger")];
            break;
        case kFingerOfRingFinger:
            notiText = [notiText stringByAppendingString:kLocalization(@"em_ringfinger")];
            break;
        case kFingerOfLittleFinger:
            notiText = [notiText stringByAppendingString:kLocalization(@"em_littlefinger")];
            break;
        default:
            break;
    }
    notiText = [notiText stringByAppendingString:kLocalization(@"em_width")];
    _measureNotiLabel.text = notiText;
}

- (void)setupViews{
    _measureNotiLabel = [[UILabel alloc] init];
    _measureNotiLabel.backgroundColor = [UIColor clearColor];
    _measureNotiLabel.textColor = kColor_Text1;
    _measureNotiLabel.font = [UIFont systemFontOfSize:15];
    _measureNotiLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_measureNotiLabel];
    
    _measureLabel = [[UILabel alloc] init];
    _measureLabel.backgroundColor = [UIColor clearColor];
    _measureLabel.textColor = kColor_Text5;
    _measureLabel.font = [UIFont systemFontOfSize:40];
    _measureLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_measureLabel];
    _baseLine = [[UIView alloc] init];
    _baseLine.backgroundColor = [UIColor redColor];
    [self addSubview:_baseLine];
    _controlLine = [[UIView alloc] init];
    _controlLine.backgroundColor = [UIColor redColor];
    [self addSubview:_controlLine];
    _fingerImageView = [[UIImageView alloc] init];
    _fingerImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:_fingerImageView];
    
    _upRedCircle = [[UIView alloc] init];
    _upRedCircle.backgroundColor = [UIColor redColor];
    _upRedCircle.layer.masksToBounds = YES;
    _upRedCircle.layer.cornerRadius = 5;
    [self addSubview:_upRedCircle];
    
    _downRedCircle = [[UIView alloc] init];
    _downRedCircle.backgroundColor = [UIColor redColor];
    _downRedCircle.layer.masksToBounds = YES;
    _downRedCircle.layer.cornerRadius = 8;
    [self addSubview:_downRedCircle];
    
    _handleView = [[UIView alloc] init];
    _handleView.backgroundColor = [UIColor clearColor];
    [self addSubview:_handleView];
    _addBtn = [[UIButton alloc] init];
    _addBtn.backgroundColor = [UIColor clearColor];
    [_addBtn setImage:kImage(@"button_jia") forState:UIControlStateNormal];
    [_addBtn setImage:kImage(@"button_jia_highlight") forState:UIControlStateHighlighted];
    [_addBtn addTarget:self action:@selector(addBtnTouchDown) forControlEvents:UIControlEventTouchDown];
    [_addBtn addTarget:self action:@selector(addBtnTouchUpOutside) forControlEvents:UIControlEventTouchUpOutside];
    [_addBtn addTarget:self action:@selector(addBtnTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    [_addBtn addTarget:self action:@selector(addBtnDragOutside) forControlEvents:UIControlEventTouchDragExit];
    [_addBtn addTarget:self action:@selector(addBtnDragInside) forControlEvents:UIControlEventTouchDragEnter];
    [_handleView addSubview:_addBtn];
    _minusBtn = [[UIButton alloc] init];
    _minusBtn.backgroundColor = [UIColor clearColor];
    [_minusBtn setImage:kImage(@"button_jian") forState:UIControlStateNormal];
    [_minusBtn setImage:kImage(@"button_jian_highlight") forState:UIControlStateHighlighted];
    [_minusBtn addTarget:self action:@selector(minusBtnTouchDown) forControlEvents:UIControlEventTouchDown];
    [_minusBtn addTarget:self action:@selector(minusBtnTouchUpOutside) forControlEvents:UIControlEventTouchUpOutside];
    [_minusBtn addTarget:self action:@selector(minusBtnTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    [_minusBtn addTarget:self action:@selector(minusBtnDragOutside) forControlEvents:UIControlEventTouchDragExit];
    [_minusBtn addTarget:self action:@selector(minusBtnDragInside) forControlEvents:UIControlEventTouchDragEnter];
    [_handleView addSubview:_minusBtn];
    _finishBtn = [[UIButton alloc] init];
    _finishBtn.backgroundColor = [UIColor clearColor];
    [_finishBtn setImage:kImage(@"button_wancheng") forState:UIControlStateNormal];
    [_finishBtn setImage:kImage(@"button_wancheng_highlight") forState:UIControlStateHighlighted];
    [_handleView addSubview:_finishBtn];
    MJWeakSelf;
    [_measureNotiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@(28 + kNavigationHeight + kStatusHeight));
        make.right.equalTo(@0);
        make.height.equalTo(@32);
    }];
    [_measureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@56);
        make.top.equalTo(weakSelf.measureNotiLabel.mas_bottom);
    }];
    
    [_baseLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@1);
        make.bottom.equalTo(@(-258));
    }];
    
    CGFloat width = kScreen_Width*347/375;
    CGFloat height = 77;
    if(_fingerType == kFingerOfThumb){
        width = kScreen_Width*275/375;
        height = 104;
    }
    if (_isLeft) {
        [_fingerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.width.equalTo(@(width));
            make.height.equalTo(@(height));
            make.bottom.equalTo(weakSelf.baseLine.mas_top);
        }];
    }else{
        [_fingerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@0);
            make.width.equalTo(@(width));
            make.height.equalTo(@(height));
            make.bottom.equalTo(weakSelf.baseLine.mas_top);
        }];
    }
    
    [_controlLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@1);
        make.top.equalTo(weakSelf.baseLine.mas_top).offset(-(height + 1));
    }];
    if (_fingerType == kFingerOfThumb) {
        if (_isLeft) {
            [_downRedCircle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(weakSelf.baseLine.mas_centerX).dividedBy(3.0/2);
                make.centerY.equalTo(weakSelf.baseLine.mas_centerY);
                make.width.equalTo(@16);
                make.height.equalTo(@16);
            }];
            [_upRedCircle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(weakSelf.controlLine.mas_centerX).dividedBy(3.0/2);
                make.centerY.equalTo(weakSelf.controlLine.mas_centerY);
                make.width.equalTo(@10);
                make.height.equalTo(@10);
            }];
        }else{
            [_downRedCircle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(weakSelf.baseLine.mas_centerX).multipliedBy(4.0/3);
                make.centerY.equalTo(weakSelf.baseLine.mas_centerY);
                make.width.equalTo(@16);
                make.height.equalTo(@16);
            }];
            [_upRedCircle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(weakSelf.controlLine.mas_centerX).multipliedBy(4.0/3);
                make.centerY.equalTo(weakSelf.controlLine.mas_centerY);
                make.width.equalTo(@10);
                make.height.equalTo(@10);
            }];
        }
    }else{
        [_downRedCircle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.baseLine.mas_centerX);
            make.centerY.equalTo(weakSelf.baseLine.mas_centerY);
            make.width.equalTo(@16);
            make.height.equalTo(@16);
        }];
        [_upRedCircle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.controlLine.mas_centerX);
            make.centerY.equalTo(weakSelf.controlLine.mas_centerY);
            make.width.equalTo(@10);
            make.height.equalTo(@10);
        }];
    }
    if (_isLeft) {
        [_handleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@(-15));
            make.right.equalTo(@(-10));
            make.width.equalTo(@60);
            make.height.equalTo(@210);
        }];
    }else{
        [_handleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@(-15));
            make.left.equalTo(@10);
            make.width.equalTo(@60);
            make.height.equalTo(@210);
        }];
    }
    
    [_finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
        make.right.equalTo(@0);
        make.left.equalTo(@0);
        make.height.equalTo(@60);
    }];
    
    [_minusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.finishBtn.mas_top).offset(-15);
        make.right.equalTo(@0);
        make.left.equalTo(@0);
        make.height.equalTo(@60);
    }];
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.minusBtn.mas_top).offset(-15);
        make.right.equalTo(@0);
        make.left.equalTo(@0);
        make.height.equalTo(@60);
    }];
    [self refreshWithWithDisdance:height];
}

//按钮按下
- (void)addBtnTouchDown{
    _adding = YES;
    [self startTimer];
}

//手指向上滑动取消
- (void)addBtnTouchUpOutside{
    _adding = YES;
    [self stopTimer];
    
}

//松开手指
- (void)addBtnTouchUpInside{
    _adding = YES;
    [self stopTimer];
}

//手指向上滑
- (void)addBtnDragOutside{
    _adding = YES;
    
}

//手指向下滑
- (void)addBtnDragInside{
    _adding = YES;
}

//按钮按下
- (void)minusBtnTouchDown{
    _adding = NO;
    [self startTimer];
    
}

//手指向上滑动取消
- (void)minusBtnTouchUpOutside{
    _adding = NO;
    [self stopTimer];
    
}

//松开手指
- (void)minusBtnTouchUpInside{
    _adding = NO;
    [self stopTimer];
    
}

//手指向上滑
- (void)minusBtnDragOutside{
    _adding = NO;
    
}

//手指向下滑
- (void)minusBtnDragInside{
    _adding = NO;
    
}

//开启定时器
- (void)startTimer {
    //如果定时器已开启，先停止再重新开启
    if (self.timer) [self stopTimer];
    self.timer = [NSTimer timerWithTimeInterval:_time target:self selector:@selector(refreshLine) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

//关闭定时器
- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}

//刷新Line
- (void)refreshLine{
    CGFloat distace = _baseLine.frame.origin.y - _controlLine.frame.origin.y;
    if (_adding) {
        distace += 0.5;
    }else{
        distace -= 0.5;
    }
    if (distace < 0) {
        distace = 0;
    }
    if (distace > 200) {
        distace = 200;
    }
    MJWeakSelf;
    [_controlLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@1);
        make.top.equalTo(weakSelf.baseLine.mas_top).offset(-distace);
    }];
    [self layoutIfNeeded];
    [self refreshWithWithDisdance:distace - _controlLine.frame.size.height];
}

- (void)refreshWithWithDisdance:(CGFloat)distance{
    if (distance < 0) {
        distance = 0;
    }
    _width = distance*_widthUnit;
    _measureLabel.text = [NSString stringWithFormat:@"%0.1fmm",_width];
}

- (void)setIsLeft:(BOOL)isLeft{
    _isLeft = isLeft;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
