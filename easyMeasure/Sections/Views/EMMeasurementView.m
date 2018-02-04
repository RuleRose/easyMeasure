//
//  EMMeasurementView.m
//  easyMeasure
//
//  Created by qiwl on 2017/6/12.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import "EMMeasurementView.h"

@implementation EMMeasurementView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = [UIColor clearColor];
    [self addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
}

- (void)setFingerType:(FingerType)fingerType{
    _fingerType = fingerType;
    if (_fingerType == kFingerOfThumb) {
        _imageArr = @[@"1",@"content",@"3"];
    }else{
        _imageArr = @[@"2",@"content",@"3"];
    }
    for (UIView *subView in _scrollView.subviews) {
        [subView removeFromSuperview];
    }
    CGFloat y = 0;
    UIView *tempView = nil;
    for (NSString *imageStr in _imageArr) {
        UIImage *image = kImage(imageStr);
        CGSize imageSize = image.size;
        CGFloat height = 0;
        if (imageSize.width != 0) {
            height = kScreen_Width*imageSize.height/imageSize.width;
        }
        UIImageView *measurement = [[UIImageView alloc] init];
        measurement.backgroundColor = [UIColor clearColor];
        measurement.image = image;
        [_scrollView addSubview:measurement];
        if (tempView) {
            [measurement mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@0);
                make.width.equalTo(@(kScreen_Width));
                make.top.equalTo(tempView.mas_bottom);
                make.height.equalTo(@(height));
            }];
        }else{
            [measurement mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@0);
                make.top.equalTo(@0);
                make.width.equalTo(@(kScreen_Width));
                make.height.equalTo(@(height));
            }];
        }
        tempView = measurement;
        y += height;
    }
    _scrollView.contentSize = CGSizeMake(kScreen_Width, y);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
