//
//  MeasureButton.h
//  easyMeasure
//
//  Created by qiwl on 2017/6/9.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^MeasureButtonBlock)();

@interface EMMeasureButton : UIButton
@property(nonatomic, strong) UIColor *normalColor;
@property(nonatomic, strong) UIColor *highlightColor;
@property(nonatomic, strong) MeasureButtonBlock measureBlock;

@end
