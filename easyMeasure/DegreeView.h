//
//  DegreeView.h
//  easyMeasure
//
//  Created by qiwl on 2017/6/10.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DegreeView : UIView
@property(nonatomic, strong)UILabel *degreeTitleLabel;
@property(nonatomic, strong)UILabel *degreeUnitLabel;
@property(nonatomic, strong)UILabel *degreeLabel;
@property(nonatomic, assign)CGFloat degree;
- (void)loadWidth:(CGFloat)width degreeWidth:(CGFloat)degreeWidth;
@end
