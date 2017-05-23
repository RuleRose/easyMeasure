//
//  SJAxisView.h
//  SJChartViewDemo
//
//  Created by Jaesun on 16/9/6.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJAxisView : UIView

/**
 *  Y轴刻度标签
 */
@property(nonatomic, strong) NSArray *yMarkTitles;
/**
 *  X轴刻度标签
 */
@property(nonatomic, strong) NSArray *xMarkTitles;

/**
 *  与x轴平行的网格线的间距
 */
@property(nonatomic, assign) CGFloat xScaleMarkLEN;

/**
 *  网格线的起始点(左上角)
 */
@property(nonatomic, assign) CGPoint startPoint;

/**
 *  y 轴长度
 */
@property(nonatomic, assign) CGFloat yAxis_L;

/**
 *  x 轴长度
 */
@property(nonatomic, assign) CGFloat xAxis_L;

/**
 *  上限 距离其实点占y轴长度的百分比
 */
@property(nonatomic, assign) CGFloat yHighLimitPercent;

/**
 *  下限 距离其实点占y轴长度的百分比
 */
@property(nonatomic, assign) CGFloat yLowLimitPercent;

//上下限温度值
@property(nonatomic, assign) CGFloat highLimitValue;
@property(nonatomic, assign) CGFloat lowLimitValue;

//屏幕point的Y值
@property(nonatomic, assign) CGFloat yPointLimitHigh;
@property(nonatomic, assign) CGFloat yPointLimitLow;
/**
 *  绘图
 */
- (void)mapping;
/**
 *  更新做标注数据
 */
- (void)reloadDatas;
@end
