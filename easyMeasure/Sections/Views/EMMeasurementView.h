//
//  EMMeasurementView.h
//  easyMeasure
//
//  Created by qiwl on 2017/6/12.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EMMeasurementView : UIView
@property(nonatomic, assign) FingerType fingerType;
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) NSArray *imageArr;
@property(nonatomic, strong) UIView *contentView;

@end
