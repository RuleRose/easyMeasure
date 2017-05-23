//
//  SJAxisView.m
//  SJChartViewDemo
//
//  Created by Jaesun on 16/9/6.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import "SJAxisView.h"

#import "SJChartLineView.h"

/**
 *  Y轴刻度标签 与 Y轴 之间 空隙
 */
#define HORIZON_YMARKLAB_YAXISLINE 2.f

/**
 *  Y轴刻度标签  宽度
 */
#define YMARKLAB_WIDTH 35.f

/**
 *  Y轴刻度标签  高度
 */
#define YMARKLAB_HEIGHT kFontHeight9
/**
 *  X轴刻度标签  宽度
 */

#define XMARKLAB_WIDTH 40.f

/**
 *  X轴刻度标签  高度
 */
#define XMARKLAB_HEIGHT kFontHeight6

/**
 *  最上边的Y轴刻度标签距离顶部的 距离
 */
#define YMARKLAB_TO_TOP 12.f

@interface SJAxisView () {
    /**
     *  视图的宽度
     */
    CGFloat axisViewWidth;
    /**
     *  视图的高度
     */
    CGFloat axisViewHeight;
}

/**
 *  与x轴平行的网格线的间距(与坐标系视图的高度和y轴刻度标签的个数相关)
 */
@property(nonatomic, assign) CGFloat yScaleMarkLEN;

@end

@implementation SJAxisView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        axisViewHeight = frame.size.height;
        axisViewWidth = frame.size.width;

        CGFloat start_X = HORIZON_YMARKLAB_YAXISLINE + YMARKLAB_WIDTH;
        CGFloat start_Y = YMARKLAB_HEIGHT / 2.0 + YMARKLAB_TO_TOP;

        self.startPoint = CGPointMake(start_X, start_Y);
    }

    return self;
}

- (void)setXScaleMarkLEN:(CGFloat)xScaleMarkLEN {
    _xScaleMarkLEN = xScaleMarkLEN;
}

- (void)setYMarkTitles:(NSArray *)yMarkTitles {
    _yMarkTitles = yMarkTitles;
}

- (void)setXMarkTitles:(NSArray *)xMarkTitles {
    _xMarkTitles = xMarkTitles;
}

#pragma mark 绘图
- (void)mapping {
    self.yScaleMarkLEN = (self.frame.size.height - YMARKLAB_HEIGHT - XMARKLAB_HEIGHT - YMARKLAB_TO_TOP) / (self.yMarkTitles.count - 1);

    self.yAxis_L = self.yScaleMarkLEN * (self.yMarkTitles.count - 1);

    if (self.xScaleMarkLEN == 0) {
        self.xScaleMarkLEN = (axisViewWidth - HORIZON_YMARKLAB_YAXISLINE - YMARKLAB_WIDTH - XMARKLAB_WIDTH / 2.0) / (self.xMarkTitles.count - 1);
    } else {
        axisViewWidth = self.xScaleMarkLEN * (self.xMarkTitles.count - 1) + HORIZON_YMARKLAB_YAXISLINE + YMARKLAB_WIDTH + XMARKLAB_WIDTH / 2.0;
    }

    self.xAxis_L = self.xScaleMarkLEN * (self.xMarkTitles.count - 1);

    self.frame = CGRectMake(0, 0, axisViewWidth, axisViewHeight);

    [self setupYMarkLabs];
    [self setupXMarkLabs];

    [self drawYAxsiLine];
    [self drawXAxsiLine];

    //    [self drawYGridline];
    //    [self drawXGridline];

    [self drawHighAndLowLimitLine];
}

#pragma mark 更新坐标轴数据
- (void)reloadDatas {
    [self clearView];
    [self mapping];
}

#pragma mark Y轴上的刻度标签
- (void)setupYMarkLabs {
    for (int i = 0; i < self.yMarkTitles.count; i++) {
        UILabel *markLab =
            [[UILabel alloc] initWithFrame:CGRectMake(0, self.startPoint.y - YMARKLAB_HEIGHT / 2 + i * self.yScaleMarkLEN, YMARKLAB_WIDTH, YMARKLAB_HEIGHT)];
        markLab.textAlignment = NSTextAlignmentRight;
        markLab.font = kFont9;
        [markLab setTextColor:kColor_2_With_Alpha(0.5)];
        markLab.text = [NSString stringWithFormat:@"%@", self.yMarkTitles[self.yMarkTitles.count - 1 - i]];
        [self addSubview:markLab];
    }
}

#pragma mark X轴上的刻度标签
- (void)setupXMarkLabs {
    for (int i = 0; i < self.xMarkTitles.count; i++) {
        UILabel *markLab = [[UILabel alloc] initWithFrame:CGRectMake(self.startPoint.x - XMARKLAB_WIDTH / 2 + i * self.xScaleMarkLEN,
                                                                     self.yAxis_L + self.startPoint.y + YMARKLAB_HEIGHT / 2, XMARKLAB_WIDTH, XMARKLAB_HEIGHT)];
        markLab.textAlignment = NSTextAlignmentCenter;
        markLab.font = kFont6;
        [markLab setTextColor:kColor_2_With_Alpha(0.5)];
        markLab.text = self.xMarkTitles[i];
        [self addSubview:markLab];
    }
}

#pragma mark Y轴
- (void)drawYAxsiLine {
    UIBezierPath *yAxisPath = [[UIBezierPath alloc] init];
    [yAxisPath moveToPoint:CGPointMake(self.startPoint.x, self.startPoint.y + self.yAxis_L)];
    [yAxisPath addLineToPoint:CGPointMake(self.startPoint.x, self.startPoint.y)];

    CAShapeLayer *yAxisLayer = [CAShapeLayer layer];
    //    [yAxisLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1.5], nil]];    // 设置线为虚线
    yAxisLayer.lineWidth = 1.0f;
    yAxisLayer.strokeColor = [UIColor blackColor].CGColor;
    yAxisLayer.path = yAxisPath.CGPath;
    [self.layer addSublayer:yAxisLayer];
}

#pragma mark X轴
- (void)drawXAxsiLine {
    UIBezierPath *xAxisPath = [[UIBezierPath alloc] init];
    [xAxisPath moveToPoint:CGPointMake(self.startPoint.x, self.yAxis_L + self.startPoint.y)];
    [xAxisPath addLineToPoint:CGPointMake(self.xAxis_L + self.startPoint.x, self.yAxis_L + self.startPoint.y)];

    CAShapeLayer *xAxisLayer = [CAShapeLayer layer];
    //    [xAxisLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1.5], nil]];
    xAxisLayer.lineWidth = 1.0f;
    xAxisLayer.strokeColor = [UIColor blackColor].CGColor;
    xAxisLayer.path = xAxisPath.CGPath;
    [self.layer addSublayer:xAxisLayer];
}

#pragma mark 与 Y轴 平行的网格线
- (void)drawYGridline {
    for (int i = 0; i < self.xMarkTitles.count - 1; i++) {
        CGFloat curMark_X = self.startPoint.x + self.xScaleMarkLEN * (i + 1);

        UIBezierPath *yAxisPath = [[UIBezierPath alloc] init];
        [yAxisPath moveToPoint:CGPointMake(curMark_X, self.yAxis_L + self.startPoint.y)];
        [yAxisPath addLineToPoint:CGPointMake(curMark_X, self.startPoint.y)];

        CAShapeLayer *yAxisLayer = [CAShapeLayer layer];
        [yAxisLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1.5], nil]];  // 设置线为虚线
        yAxisLayer.lineWidth = 0.5;
        yAxisLayer.strokeColor = [UIColor blackColor].CGColor;
        yAxisLayer.path = yAxisPath.CGPath;
        [self.layer addSublayer:yAxisLayer];
    }
}

#pragma mark 与 X轴 平行的网格线
- (void)drawXGridline {
    for (int i = 0; i < self.yMarkTitles.count - 1; i++) {
        CGFloat curMark_Y = self.yScaleMarkLEN * i;

        UIBezierPath *xAxisPath = [[UIBezierPath alloc] init];
        [xAxisPath moveToPoint:CGPointMake(self.startPoint.x, curMark_Y + self.startPoint.y)];
        [xAxisPath addLineToPoint:CGPointMake(self.startPoint.x + self.xAxis_L, curMark_Y + self.startPoint.y)];

        CAShapeLayer *xAxisLayer = [CAShapeLayer layer];
        [xAxisLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1.5], nil]];
        xAxisLayer.lineWidth = 0.5;
        xAxisLayer.strokeColor = [UIColor blackColor].CGColor;
        xAxisLayer.path = xAxisPath.CGPath;
        [self.layer addSublayer:xAxisLayer];
    }
}

#pragma mark 上限 和 下限
- (void)drawHighAndLowLimitLine {
    // High
    CGFloat curMark_Y = self.yAxis_L * (1 - self.yHighLimitPercent);

    UIBezierPath *highAxisPath = [[UIBezierPath alloc] init];
    self.yPointLimitHigh = curMark_Y + self.startPoint.y;
    [highAxisPath moveToPoint:CGPointMake(self.startPoint.x, curMark_Y + self.startPoint.y)];
    [highAxisPath addLineToPoint:CGPointMake(self.startPoint.x + self.xAxis_L, curMark_Y + self.startPoint.y)];

    CAShapeLayer *highAxisLayer = [CAShapeLayer layer];
    [highAxisLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1.5], nil]];
    highAxisLayer.lineWidth = 0.5;
    highAxisLayer.strokeColor = [UIColor blackColor].CGColor;
    highAxisLayer.path = highAxisPath.CGPath;
    [self.layer addSublayer:highAxisLayer];

    UILabel *highLimitLab =
        [[UILabel alloc] initWithFrame:CGRectMake(self.startPoint.x + self.xAxis_L - 50, self.yPointLimitHigh - kFontHeight12, 50, kFontHeight12)];
    [highLimitLab setText:[NSString stringWithFormat:kLocalization(@"common_temperature_without_unit"), self.highLimitValue]];
    [highLimitLab setFont:kFont12];
    [highLimitLab setTextColor:kColor_2_With_Alpha(0.5)];
    [highLimitLab setTextAlignment:NSTextAlignmentRight];
    [self addSubview:highLimitLab];

    // Low
    curMark_Y = self.yAxis_L * (1 - self.yLowLimitPercent);
    UIBezierPath *lowAxisPath = [[UIBezierPath alloc] init];
    self.yPointLimitLow = curMark_Y + self.startPoint.y;
    [lowAxisPath moveToPoint:CGPointMake(self.startPoint.x, curMark_Y + self.startPoint.y)];
    [lowAxisPath addLineToPoint:CGPointMake(self.startPoint.x + self.xAxis_L, curMark_Y + self.startPoint.y)];

    CAShapeLayer *lowAxisLayer = [CAShapeLayer layer];
    [lowAxisLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1.5], nil]];
    lowAxisLayer.lineWidth = 0.5;
    lowAxisLayer.strokeColor = [UIColor blackColor].CGColor;
    lowAxisLayer.path = lowAxisPath.CGPath;
    [self.layer addSublayer:lowAxisLayer];

    UILabel *lowLimitLab =
        [[UILabel alloc] initWithFrame:CGRectMake(self.startPoint.x + self.xAxis_L - 50, self.yPointLimitLow - kFontHeight12, 50, kFontHeight12)];
    [lowLimitLab setText:[NSString stringWithFormat:kLocalization(@"common_temperature_without_unit"), self.lowLimitValue]];
    [lowLimitLab setFont:kFont12];
    [lowLimitLab setTextColor:kColor_2_With_Alpha(0.5)];
    [lowLimitLab setTextAlignment:NSTextAlignmentRight];
    [self addSubview:lowLimitLab];
}

#pragma mark - 清空视图
- (void)clearView {
    [self removeAllSubLabs];
    [self removeAllSubLayers];
}

#pragma mark 清空标签
- (void)removeAllSubLabs {
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            [(UILabel *)view removeFromSuperview];
        }
    }
}

#pragma mark 清空网格线
- (void)removeAllSubLayers {
    for (CALayer *layer in self.layer.sublayers) {
        [layer removeFromSuperlayer];
    }
}

@end
