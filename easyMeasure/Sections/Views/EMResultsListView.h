//
//  EMResultsListView.h
//  easyMeasure
//
//  Created by qiwl on 2017/6/12.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMMeasureModel.h"

@protocol EMResultsListViewDelegate;
@interface EMResultsListView : UIView
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *measures;
@property(nonatomic, assign) id<EMResultsListViewDelegate> delegate;

@end
@protocol EMResultsListViewDelegate <NSObject>
@optional
- (void)showResultWithMeasure:(EMMeasureModel *)measure;
@end
