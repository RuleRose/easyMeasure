//
//  MeasureResultViewController.h
//  easyMeasure
//
//  Created by qiwl on 2017/6/10.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import "XJFBaseViewController.h"
#import "EMMeasureModel.h"

@interface EMMeasureResultViewController : XJFBaseViewController
@property(nonatomic, strong)EMMeasureModel *measure;
@property(nonatomic, assign) BOOL isBasic;

@end
