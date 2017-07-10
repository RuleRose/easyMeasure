//
//  EMFingerTypeView.h
//  easyMeasure
//
//  Created by qiwl on 2017/7/10.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMMeasureButton.h"

@interface EMFingerTypeView : UIView
@property(nonatomic, strong) UIImageView *fingerView;
@property(nonatomic, strong) EMMeasureButton *leftBtn;
@property(nonatomic, strong) EMMeasureButton *rightBtn;
@property(nonatomic, strong) UILabel *detailLabel;

@end
