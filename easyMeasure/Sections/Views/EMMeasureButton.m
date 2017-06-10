//
//  MeasureButton.m
//  easyMeasure
//
//  Created by qiwl on 2017/6/9.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import "EMMeasureButton.h"

@implementation EMMeasureButton
- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)setNormalColor:(UIColor *)normalColor{
    _normalColor = normalColor;
    self.backgroundColor = _normalColor;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.backgroundColor = self.highlightColor;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch* touch = [touches anyObject];
    CGPoint pos = [touch locationInView:self];
    if (CGRectContainsPoint(self.bounds, pos)) {
        self.backgroundColor = self.highlightColor;
    }else{
        self.backgroundColor = self.normalColor;
    }
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch* touch = [touches anyObject];
    CGPoint pos = [touch locationInView:self];
    if (CGRectContainsPoint(self.bounds, pos)) {
        if (_measureBlock) {
            _measureBlock();
        }
    }
    self.backgroundColor = self.normalColor;

}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.backgroundColor = self.normalColor;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
