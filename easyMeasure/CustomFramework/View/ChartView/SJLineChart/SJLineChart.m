//
//  SJLineChart.m
//  SJChartViewDemo
//
//  Created by Jaesun on 16/9/9.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import "SJLineChart.h"

#import "SJAxisView.h"
#import "SJChartLineView.h"

@interface SJLineChart ()
/**
 *  表名标签
 */
@property(nonatomic, strong) UILabel *timeRangeLab;

/**
 *  表名标签
 */
@property(nonatomic, strong) UILabel *titleLab;

/**
 *  显示折线图的可滑动视图
 */
@property(nonatomic, strong) UIScrollView *scrollView;

/**
 *  折线图
 */
@property(nonatomic, strong) SJChartLineView *chartLineView;
@end

@implementation SJLineChart

#pragma mark 绘图
- (void)mapping {
    static CGFloat topToContainView = 0.f;

    topToContainView = 18;
    self.timeRangeLab = [[UILabel alloc] initWithFrame:CGRectMake(50, topToContainView, CGRectGetWidth(self.frame) - 100, kFontHeight12)];
    self.timeRangeLab.text = self.timeRange;
    self.timeRangeLab.font = kFont12;
    [self.timeRangeLab setAdjustsFontSizeToFitWidth:YES];
    self.timeRangeLab.textAlignment = NSTextAlignmentCenter;
    [self.timeRangeLab setTextColor:kColor_2_With_Alpha(0.5)];
    [self addSubview:self.timeRangeLab];
    topToContainView += kFontHeight12;

    topToContainView += 18;
    self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(12, topToContainView, CGRectGetWidth(self.frame) - 20, kFontHeight12)];
    self.titleLab.text = self.title;
    self.titleLab.font = kFont12;
    self.titleLab.textAlignment = NSTextAlignmentLeft;
    [self.titleLab setTextColor:kColor_2_With_Alpha(0.5)];
    [self addSubview:self.titleLab];
    topToContainView += kFontHeight12;

    topToContainView += 18;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, topToContainView, self.frame.size.width, self.frame.size.height - topToContainView)];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    [self.scrollView setBounces:NO];
    [self addSubview:self.scrollView];

    self.chartLineView = [[SJChartLineView alloc] initWithFrame:self.scrollView.bounds];
    [self.chartLineView setBackgroundColor:kClear];
    self.chartLineView.yMarkTitles = self.yMarkTitles;
    self.chartLineView.xMarkTitles = self.xMarkTitles;
    self.chartLineView.valueSegemntArray = self.valueSegemntArray;
    self.chartLineView.maxValue = self.maxValue;
    self.chartLineView.minValue = self.minValue;
    self.chartLineView.highLimitValue = self.highLimitValue;
    self.chartLineView.lowLimitValue = self.lowLimitValue;
    self.chartLineView.yHighLimitPercent = (self.highLimitValue - self.minValue) / (self.maxValue - self.minValue);
    self.chartLineView.yLowLimitPercent = (self.lowLimitValue - self.minValue) / (self.maxValue - self.minValue);
    [self.scrollView addSubview:self.chartLineView];

    [self.chartLineView mapping];
    self.scrollView.contentSize = self.chartLineView.bounds.size;
}

#pragma mark 更新数据
- (void)reloadDatas {
    [self.chartLineView reloadDatas];
}

@end
