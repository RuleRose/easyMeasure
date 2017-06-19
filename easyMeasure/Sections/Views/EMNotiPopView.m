//
//  EMNotiPopView.m
//  easyMeasure
//
//  Created by qiwl on 2017/6/17.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import "EMNotiPopView.h"

@implementation EMNotiPopView
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
    _triImageView = [[UIImageView alloc] init];
    _triImageView.backgroundColor = [UIColor clearColor];
    _triImageView.image = kImage(@"jiantou");
    [self addSubview:_triImageView];
    
    _notiImageView = [[UIImageView alloc] init];
    _notiImageView.backgroundColor = [UIColor clearColor];
    _notiImageView.image = kImage(@"text");
    [self addSubview:_notiImageView];

    
    _confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 220, 44)];
    _confirmBtn.backgroundColor = [UIColor clearColor];
    [_confirmBtn setImage:kImage(@"button_highlight") forState:UIControlStateNormal];
    [_confirmBtn setImage:kImage(@"button") forState:UIControlStateHighlighted];
    [_confirmBtn addTarget:self action:@selector(confrimBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_confirmBtn];
    MJWeakSelf;
    [_triImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(kNavigationHeight + kStatusHeight));
        make.width.equalTo(@37);
        make.height.equalTo(@44);
        make.right.equalTo(weakSelf.notiImageView.mas_right);
    }];
    [_notiImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.triImageView.mas_bottom).offset(24);
        make.width.equalTo(@250);
        make.height.equalTo(@19);
        make.centerX.equalTo(weakSelf.mas_centerX);
    }];
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.notiImageView.mas_bottom).offset(64);
        make.width.equalTo(@220);
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
