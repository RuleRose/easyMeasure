//
//  SJChartLineView.h
//  SJChartViewDemo
//
//  Created by Jaesun on 16/9/9.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SJAxisView.h"
#import "UNICCommonTemperturaSegmentModel.h"

@interface SJChartLineView : SJAxisView

@property(nonatomic, strong) NSArray<UNICCommonTemperturaSegmentModel *> *valueSegemntArray;

@property(nonatomic, assign) CGFloat maxValue;

@property(nonatomic, assign) CGFloat minValue;
/**
 *  绘图
 */
- (void)mapping;

/**
 *  更新折线图数据
 */
- (void)reloadDatas;

@end
