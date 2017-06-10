//
//  MeasureCell.h
//  easyMeasure
//
//  Created by qiwl on 2017/6/10.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import "MeasureModel.h"

@interface MeasureCell : UITableViewCell
@property(nonatomic, strong)UILabel *resultLabel;
@property(nonatomic, strong)UILabel *dateLabel;
@property(nonatomic, strong)MeasureModel *measure;
@end
