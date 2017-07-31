//
//  EMMeasurePopView.m
//  easyMeasure
//
//  Created by qiwl on 2017/7/10.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import "EMMeasurePopView.h"
#import "UIImage+Extension.h"

@implementation EMMeasurePopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kColorFromRGBA(0x000000, 0.5);
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    _measureLabel = [[UILabel alloc] init];
    _measureLabel.backgroundColor = [UIColor clearColor];
    _measureLabel.text = kLocalization(@"em_measure_intro");
    _measureLabel.textColor = kColorFromRGB(0xffffff);
    _measureLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:_measureLabel];
    
    _triView = [[UIImageView alloc] init];
    _triView.backgroundColor = [UIColor clearColor];
    _triView.image = kImage(@"dianji");
    [self addSubview:_triView];

    _notiImageView = [[UIImageView alloc] init];
    _notiImageView.backgroundColor = [UIColor clearColor];
    _notiImageView.image = kImage(@"text3");
    [self addSubview:_notiImageView];
    
    _confirmBtn = [[EMMeasureButton alloc] init];
    _confirmBtn.backgroundColor = [UIColor clearColor];
    _confirmBtn.layer.masksToBounds = YES;
    _confirmBtn.layer.cornerRadius = 24;
    [_confirmBtn setImage:[UIImage drawImageWithSize:CGSizeMake(372, 88) color:kColor_Button1] forState:UIControlStateNormal];
    [_confirmBtn setImage:[UIImage drawImageWithSize:CGSizeMake(372, 88) color:kColor_Highlight_Button3] forState:UIControlStateHighlighted];
    _confirmBtn.iconView.image = kImage(@"text4");
    [_confirmBtn addTarget:self action:@selector(confrimBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_confirmBtn];
    MJWeakSelf;
    [_measureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@20);
        make.width.equalTo(@80);
        make.height.equalTo(@44);
        make.right.equalTo(@(-5));
    }];
    [_triView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@50);
        make.width.equalTo(@57);
        make.height.equalTo(@44);
        make.right.equalTo(@(-92));
    }];
    [_notiImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.triView.mas_bottom).offset(56);
        make.width.equalTo(@254);
        make.height.equalTo(@41);
        make.centerX.equalTo(weakSelf.mas_centerX);
    }];
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.notiImageView.mas_bottom).offset(48);
        make.width.equalTo(@186);
        make.height.equalTo(@44);
        make.centerX.equalTo(weakSelf.mas_centerX);
    }];
    
}

- (void)confrimBtnPressed{
    [self hiddenMenus];
}

- (void)showMenus{
    UIWindow* window = [[UIApplication sharedApplication] keyWindow];
    if (_baseView) {
        [_baseView addSubview:self];
    }else{
        [window addSubview:self];
    }
    [UIView animateWithDuration:2 animations:^{
        [self showMenusAnimation];
    }];
}

- (void)hiddenMenus
{
    [UIView animateWithDuration:0.15 animations:^{
        [self hiddenMenusAnimation];
    }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

- (void)showMenusAnimation
{
    self.alpha = 1.0;
    
}

- (void)hiddenMenusAnimation
{
    self.alpha = 0.0;
}

- (void)touchAtPoint:(CGPoint)pos{
    if (CGRectContainsPoint(_notiImageView.frame, pos)) {
        [self hiddenMenus];
    }
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (touches.allObjects.count > 0) {
        UITouch *touch  = touches.allObjects[0];
        CGPoint pos = [touch locationInView:self];
        [self touchAtPoint:pos];
    }
}

@end
