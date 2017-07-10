//
//  EMFingerTypePopView.m
//  easyMeasure
//
//  Created by qiwl on 2017/7/10.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import "EMFingerTypePopView.h"
#import "UIImage+Extension.h"

@implementation EMFingerTypePopView

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
    _notiImageView = [[UIImageView alloc] init];
    _notiImageView.backgroundColor = [UIColor clearColor];
    _notiImageView.image = kImage(@"text1");
    [self addSubview:_notiImageView];
    
    
    _confirmBtn = [[EMMeasureButton alloc] init];
    _confirmBtn.backgroundColor = [UIColor clearColor];
    _confirmBtn.layer.masksToBounds = YES;
    _confirmBtn.layer.cornerRadius = 24;
    [_confirmBtn setImage:[UIImage drawImageWithSize:CGSizeMake(372, 88) color:kColor_Button1] forState:UIControlStateNormal];
    [_confirmBtn setImage:[UIImage drawImageWithSize:CGSizeMake(372, 88) color:kColor_Highlight_Button3] forState:UIControlStateHighlighted];
    [_confirmBtn addTarget:self action:@selector(confrimBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    _confirmBtn.iconView.image = kImage(@"text2");
    [self addSubview:_confirmBtn];
    MJWeakSelf;
    [_notiImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@233);
        make.width.equalTo(@280);
        make.height.equalTo(@64);
        make.centerX.equalTo(weakSelf.mas_centerX);
    }];
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.notiImageView.mas_bottom).offset(49);
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
