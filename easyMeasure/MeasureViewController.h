//
//  MeasureViewController.h
//  easyMeasure
//
//  Created by qiwl on 2017/6/9.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import "XJFBaseViewController.h"
#import "MeasureModel.h"

@interface MeasureViewController : XJFBaseViewController
@property(nonatomic, assign) BOOL isLeft;
@property(nonatomic, assign) FingerType fingerType;
@property(nonatomic, strong) MeasureModel *measureModel;

@end
