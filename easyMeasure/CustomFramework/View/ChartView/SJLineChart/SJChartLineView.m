//
//  SJChartLineView.m
//  SJChartViewDemo
//
//  Created by Jaesun on 16/9/9.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import "SJChartLineView.h"
#import "SJCircleView.h"
#import "SJLabelView.h"

// Tag 基初值
#define BASE_TAG_COVERVIEW 100
#define BASE_TAG_CIRCLEVIEW 200
#define BASE_TAG_POPBTN 300
#define BASE_TAG_LABEL 400

@interface SJChartLineView () {
    NSMutableArray *pointArray;
    NSMutableArray *valueArray;
    NSInteger lastSelectedIndex;
    NSInteger valueCount;
}

@property(nonatomic, assign) CGFloat xValueScaleMarkLen;
@end

@implementation SJChartLineView
- (void)setValueSegemntArray:(NSArray *)valueSegemntArray {
    _valueSegemntArray = valueSegemntArray;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        lastSelectedIndex = -1;
        pointArray = [NSMutableArray array];
        valueArray = [NSMutableArray array];
    }
    return self;
}

- (void)mapping {
    [super mapping];
    valueCount = 0;
    for (UNICCommonTemperturaSegmentModel *segmentModel in self.valueSegemntArray) {
        valueCount += segmentModel.temperatureList.count;
    }

    //如果只有一个点，就不作任何操作。
    if (1 >= valueCount) {
        return;
    }

    self.xValueScaleMarkLen = self.xAxis_L / (valueCount - 1);

    [self drawChartLine];
    //    [self drawGradient];

    UITapGestureRecognizer *gesutre = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesutreAction:)];
    [self addGestureRecognizer:gesutre];
}

- (void)reloadDatas {
    [super reloadDatas];

    [self clearView];
    [self mapping];
}

#pragma mark 画折线图
- (void)drawChartLine {
    NSInteger lineWidth = 2;
    UIColor *normalColor = kColor_11;
    UIColor *abnormalColor = kColor_12;
    NSInteger i = 0;
    CGPoint prePoint;

    for (UNICCommonTemperturaSegmentModel *segmentModel in self.valueSegemntArray) {
        UIBezierPath *pAxisPath = [[UIBezierPath alloc] init];
        BOOL isFirstPoint = YES;

        for (UNICCommonTemperatureModel *temperatrueModel in segmentModel.temperatureList) {
            CGFloat point_X = self.xValueScaleMarkLen * i + self.startPoint.x;

            CGFloat percent = (temperatrueModel.temperature - self.minValue) / (self.maxValue - self.minValue);
            CGFloat point_Y = self.yAxis_L * (1 - percent) + self.startPoint.y;

            CGPoint point = CGPointMake(point_X, point_Y);
            // 记录各点的坐标方便后边添加渐变阴影 和 点击层视图 等
            [pointArray addObject:[NSValue valueWithCGPoint:point]];
            [valueArray addObject:temperatrueModel];

            if (isFirstPoint) {
                [pAxisPath moveToPoint:point];
                isFirstPoint = NO;
                if (i != 0) {
                    [self drawCrossLineFrom:prePoint to:point];
                }
            } else {
                [pAxisPath addLineToPoint:point];
            }

            prePoint = CGPointMake(point_X, point_Y);

            i++;
        }

        CAShapeLayer *pAxisLayer = [CAShapeLayer layer];
        pAxisLayer.lineWidth = lineWidth;
        if (segmentModel.temperatureType == 1) {
            pAxisLayer.strokeColor = normalColor.CGColor;
        } else {
            pAxisLayer.strokeColor = abnormalColor.CGColor;
        }
        pAxisLayer.fillColor = [UIColor clearColor].CGColor;
        pAxisLayer.path = pAxisPath.CGPath;
        [self.layer addSublayer:pAxisLayer];
    }
}

- (void)drawCrossLineFrom:(CGPoint)startPoint to:(CGPoint)endPoint {
    NSInteger lineWidth = 2;
    UIColor *normalColor = kColor_11;
    UIColor *abnormalColor = kColor_12;
    NSInteger lineType = 0;  // 1 上到中；2 下到中；3 中到上；4 中到下
    CGPoint crossPoint;
    UIBezierPath *pPath1 = [[UIBezierPath alloc] init];
    UIBezierPath *pPath2 = [[UIBezierPath alloc] init];
    CAShapeLayer *pLayer1 = [CAShapeLayer layer];
    CAShapeLayer *pLayer2 = [CAShapeLayer layer];

    pLayer1.lineWidth = lineWidth;
    pLayer1.fillColor = [UIColor clearColor].CGColor;
    pLayer2.lineWidth = lineWidth;
    pLayer2.fillColor = [UIColor clearColor].CGColor;

    if (startPoint.y < self.yPointLimitHigh) {
        lineType = 1;
        crossPoint = CGPointMake(startPoint.x + self.xValueScaleMarkLen / 2, self.yPointLimitHigh);
        pLayer1.strokeColor = abnormalColor.CGColor;
        pLayer2.strokeColor = normalColor.CGColor;
    } else if (startPoint.y > self.yPointLimitLow) {
        lineType = 2;
        crossPoint = CGPointMake(startPoint.x + self.xValueScaleMarkLen / 2, self.yPointLimitLow);
        pLayer1.strokeColor = abnormalColor.CGColor;
        pLayer2.strokeColor = normalColor.CGColor;
    } else {
        if (endPoint.y < self.yPointLimitHigh) {
            lineType = 3;
            crossPoint = CGPointMake(startPoint.x + self.xValueScaleMarkLen / 2, self.yPointLimitHigh);
        } else {
            lineType = 4;
            crossPoint = CGPointMake(startPoint.x + self.xValueScaleMarkLen / 2, self.yPointLimitLow);
        }
        pLayer1.strokeColor = normalColor.CGColor;
        pLayer2.strokeColor = abnormalColor.CGColor;
    }

    [pPath1 moveToPoint:startPoint];
    [pPath1 addLineToPoint:crossPoint];
    [pPath2 moveToPoint:crossPoint];
    [pPath2 addLineToPoint:endPoint];

    pLayer1.path = pPath1.CGPath;
    pLayer2.path = pPath2.CGPath;

    [self.layer addSublayer:pLayer1];
    [self.layer addSublayer:pLayer2];
}

#pragma mark 渐变阴影
- (void)drawGradient {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    gradientLayer.colors = @[
        (__bridge id)[UIColor colorWithRed:250 / 255.0 green:170 / 255.0 blue:10 / 255.0 alpha:0.8].CGColor,
        (__bridge id)[UIColor colorWithWhite:1 alpha:0.1].CGColor
    ];

    gradientLayer.locations = @[ @0.0, @1.0 ];
    gradientLayer.startPoint = CGPointMake(0.0, 0.0);
    gradientLayer.endPoint = CGPointMake(0.0, 1);

    UIBezierPath *gradientPath = [[UIBezierPath alloc] init];
    [gradientPath moveToPoint:CGPointMake(self.startPoint.x, self.yAxis_L + self.startPoint.y)];

    for (int i = 0; i < pointArray.count; i++) {
        [gradientPath addLineToPoint:[pointArray[i] CGPointValue]];
    }

    CGPoint endPoint = [[pointArray lastObject] CGPointValue];
    endPoint = CGPointMake(endPoint.x, self.yAxis_L + self.startPoint.y);
    [gradientPath addLineToPoint:endPoint];
    CAShapeLayer *arc = [CAShapeLayer layer];
    arc.path = gradientPath.CGPath;
    gradientLayer.mask = arc;
    [self.layer addSublayer:gradientLayer];
}

#pragma mark - 点击层视图的点击事件
- (void)gesutreAction:(UITapGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:sender.view];
    NSLog(@"x:%f, y:%f", point.x, point.y);

    if ((point.x < self.startPoint.x) || (point.x > self.startPoint.x + self.xAxis_L)) {
        return;
    }

    if (lastSelectedIndex != -1) {
        DDLogDebug(@"remove");
        SJCircleView *lastCircle = (SJCircleView *)[self viewWithTag:lastSelectedIndex + BASE_TAG_CIRCLEVIEW];
        SJLabelView *lastLabel = (SJLabelView *)[self viewWithTag:lastSelectedIndex + BASE_TAG_LABEL];
        [lastCircle removeFromSuperview];
        [lastLabel removeFromSuperview];
    }

    CGFloat xOffset = point.x - self.startPoint.x;
    CGFloat valueNumDraft = xOffset / self.xValueScaleMarkLen;
    NSInteger valueNum = 0;
    if (((NSInteger)(valueNumDraft * 10)) % 10 < 5) {
        valueNum = (NSInteger)valueNumDraft;
    } else {
        valueNum = (NSInteger)valueNumDraft + 1;
    }

    CGPoint locatPoint = [pointArray[valueNum] CGPointValue];
    SJCircleView *circleView = [[SJCircleView alloc] initWithCenter:locatPoint radius:6];
    circleView.tag = valueNum + BASE_TAG_CIRCLEVIEW;
    [self addSubview:circleView];

    UNICCommonTemperatureModel *temperatureModel = valueArray[valueNum];
    SJLabelView *labelView = [[SJLabelView alloc] initWithFrame:CGRectMake(locatPoint.x - 64 / 2, locatPoint.y - 40 - 6, 64, 40)];
    [labelView.dateLabel setText:[temperatureModel.time substringWithRange:NSMakeRange(2, temperatureModel.time.length - 5)]];
    [labelView.temperatureLabel setText:[NSString stringWithFormat:kLocalization(@"common_temperature"), temperatureModel.temperature]];
    labelView.tag = valueNum + BASE_TAG_LABEL;
    [self addSubview:labelView];

    lastSelectedIndex = valueNum;
}

#pragma mark - 清空视图
- (void)clearView {
    [self removeSubviews];
    [self removeSublayers];
}

#pragma mark 移除 点击图层 、圆环 、数值标签
- (void)removeSubviews {
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}

#pragma mark 移除折线
- (void)removeSublayers {
    for (CALayer *layer in self.layer.sublayers) {
        [layer removeFromSuperlayer];
    }
}

@end
