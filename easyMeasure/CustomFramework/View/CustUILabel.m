//
//  CustUILabel.m
//  storyhouse2
//
//  Created by 肖君 on 16/7/4.
//  Copyright © 2016年 LEIE. All rights reserved.
//

#import "CustUILabel.h"

@implementation CustUILabel
+ (CustUILabel *)custCreateLabel
{
    return [CustUILabel custCreateLabelWithText:nil];
}

+ (CustUILabel *)custCreateLabelWithText:(NSString *)text
{
    return [CustUILabel custCreateLabel:CGRectZero andText:text];
}

+ (CustUILabel *)custCreateLabel:(CGRect)frame andText:(NSString *)text
{
    CustUILabel *label = [[CustUILabel alloc] initWithFrame:frame];
    label.text=text;
    return label;
}

/**
 *  设置统一属性
 */
- (void)setDefaultAttributes
{
//    self.font = kFont15;
//    self.backgroundColor = kClear;
//    self.textAlignment = NSTextAlignmentLeft;
    self.numberOfLines = 1;
    [self setAdjustsFontSizeToFitWidth:YES];
}

-(instancetype)init
{
    self=[super init];
    if (self)
    {
        [self setDefaultAttributes];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        [self setDefaultAttributes];
        
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self setDefaultAttributes];
        
    }
    
    return self;
}
@end
