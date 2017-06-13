//
//  EMMeasureResultView.h
//  easyMeasure
//
//  Created by qiwl on 2017/6/12.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMMeasureModel.h"
#import "EMMeasureButton.h"
#import "EMMeasureViewController.h"
#import "EMDegreeView.h"

@interface EMMeasureResultView : UIView
@property(nonatomic, strong)EMMeasureModel *measure;
@property(nonatomic, strong)UIImageView *imageView;
@property(nonatomic, strong)UILabel *measureTitleLabel;
@property(nonatomic, strong)UILabel *measureLabel;
@property(nonatomic, strong)UILabel *suggestTitleLabel;
@property(nonatomic, strong)EMDegreeView *hkDegreeView;
@property(nonatomic, strong)EMDegreeView *euroDegreeView;
@property(nonatomic, strong)EMDegreeView *usDegreeView;
@property(nonatomic, strong)EMMeasureButton *remeasureBtn;
@property(nonatomic, strong)UIView *leftPoint;
@property(nonatomic, strong)UIView *rightPoint;
@end
