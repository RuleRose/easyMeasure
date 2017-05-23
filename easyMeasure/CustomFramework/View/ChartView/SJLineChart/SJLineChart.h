//
//  SJLineChart.h
//  SJChartViewDemo
//
//  Created by Jaesun on 16/9/9.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UNICCommonTemperturaSegmentModel.h"

@interface SJLineChart : UIView

/**
 *
 */
@property(nonatomic, strong) NSString *timeRange;

/**
 *  表名
 */
@property(nonatomic, strong) NSString *title;

/**
 *  Y轴刻度标签title
 */
@property(nonatomic, strong) NSArray *yMarkTitles;

/**
 *  X轴刻度标签title
 */
@property(nonatomic, strong) NSArray *xMarkTitles;

/**
 *  折线value
 */
@property(nonatomic, strong) NSArray<UNICCommonTemperturaSegmentModel *> *valueSegemntArray;

/**
 *  Y轴最大值
 */
@property(nonatomic, assign) CGFloat maxValue;

/**
 *  Y轴最小值
 */
@property(nonatomic, assign) CGFloat minValue;

/**
 *  上限
 */
@property(nonatomic, assign) CGFloat highLimitValue;

/**
 *  下限
 */
@property(nonatomic, assign) CGFloat lowLimitValue;

/**
 *  X轴刻度标签的长度（单位长度）
 */
//@property(nonatomic, assign) CGFloat xScaleMarkLEN;

- (void)mapping;

- (void)reloadDatas;

@end
