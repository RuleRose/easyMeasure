//
//  CustTextField.m
//  unicorn
//
//  Created by 肖君 on 16/12/3.
//  Copyright © 2016年 johnxiao. All rights reserved.
//

#import "CustTextField.h"

@implementation CustTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setTextAlignment:NSTextAlignmentLeft];
        [self setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [self setPlaceholder:@"..."];
    }
    return self;
}
@end
