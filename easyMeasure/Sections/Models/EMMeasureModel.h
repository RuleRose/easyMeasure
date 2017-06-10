//
//  MeasureModel.h
//  easyMeasure
//
//  Created by qiwl on 2017/6/10.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import "XJFBaseModel.h"

@interface EMMeasureModel : XJFBaseModel
@property(nonatomic, copy) NSString *measure_time;//测量时间
@property(nonatomic, copy) NSString *width; //宽度
@property(nonatomic, copy) NSString *finger_type;//手指
@property(nonatomic, copy) NSString *finger_left;//左右手

@end
