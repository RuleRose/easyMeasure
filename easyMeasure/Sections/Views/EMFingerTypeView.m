//
//  EMFingerTypeView.m
//  easyMeasure
//
//  Created by qiwl on 2017/7/10.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import "EMFingerTypeView.h"
#import "UIImage+Extension.h"

@implementation EMFingerTypeView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    _detailLabel = [[UILabel alloc] init];
    _detailLabel.backgroundColor = [UIColor clearColor];
    _detailLabel.font = [UIFont systemFontOfSize:16];
    _detailLabel.textColor = kColor_Text1;
    _detailLabel.numberOfLines = 0;
    _detailLabel.textAlignment = NSTextAlignmentCenter;
    _detailLabel.text = kLocalization(@"em_fingertype_detail");
    [self addSubview:_detailLabel];
    _fingerView = [[UIImageView alloc] init];
    _fingerView.backgroundColor = [UIColor clearColor];
    _fingerView.image = kImage(@"shouzhi");
    [self addSubview:_fingerView];
    _leftBtn = [[EMMeasureButton alloc] init];
    _leftBtn.backgroundColor = [UIColor clearColor];
    _leftBtn.layer.masksToBounds = YES;
    _leftBtn.layer.cornerRadius = 24;
    [_leftBtn setImage:[UIImage drawImageWithSize:CGSizeMake((kScreen_Width - 60)/2, 48) color:kColor_Button1] forState:UIControlStateNormal];
    [_leftBtn setImage:[UIImage drawImageWithSize:CGSizeMake((kScreen_Width - 60)/2, 48) color:kColor_Highlight_Button3] forState:UIControlStateHighlighted];
    _leftBtn.textLabel.text = kLocalization(@"em_fingertype_left");
    _leftBtn.textLabel.font = [UIFont systemFontOfSize:16];
    _leftBtn.textLabel.textColor = kColor_Text1;
    [self addSubview:_leftBtn];
    
    _rightBtn = [[EMMeasureButton alloc] init];
    _rightBtn.backgroundColor = [UIColor clearColor];
    _rightBtn.layer.masksToBounds = YES;
    _rightBtn.layer.cornerRadius = 24;
    [_rightBtn setImage:[UIImage drawImageWithSize:CGSizeMake(kScreen_Width - 60, 96) color:kColor_Button1] forState:UIControlStateNormal];
    [_rightBtn setImage:[UIImage drawImageWithSize:CGSizeMake(kScreen_Width - 60, 96) color:kColor_Highlight_Button3] forState:UIControlStateHighlighted];
    _rightBtn.textLabel.text = kLocalization(@"em_fingertype_right");
    _rightBtn.textLabel.font = [UIFont systemFontOfSize:16];
    _rightBtn.textLabel.textColor = kColor_Text1;
    [self addSubview:_rightBtn];
    MJWeakSelf;
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(kStatusHeight + kNavigationHeight));
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@168);
    }];
    [_fingerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.detailLabel.mas_bottom);
        make.width.equalTo(@211);
        make.height.equalTo(@240);
        make.centerX.equalTo(weakSelf.detailLabel.mas_centerX);
    }];
    [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.bottom.equalTo(@(-63));
        make.right.equalTo(weakSelf.rightBtn.mas_left).offset(-21);
        make.height.equalTo(@48);
        make.width.equalTo(weakSelf.rightBtn.mas_width);
    }];
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-20));
        make.bottom.equalTo(@(-63));
        make.left.equalTo(weakSelf.leftBtn.mas_right).offset(21);
        make.height.equalTo(@48);
        make.width.equalTo(weakSelf.leftBtn.mas_width);
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
