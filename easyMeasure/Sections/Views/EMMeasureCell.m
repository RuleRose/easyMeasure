//
//  MeasureCell.m
//  easyMeasure
//
//  Created by qiwl on 2017/6/10.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import "EMMeasureCell.h"
#import "NSDate+Extension.h"

@implementation EMMeasureCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    _resultLabel = [[UILabel alloc] init];
    _resultLabel.backgroundColor = [UIColor clearColor];
    _resultLabel.textColor = kColor_Text1;
    _resultLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_resultLabel];
    _dateLabel = [[UILabel alloc] init];
    _dateLabel.backgroundColor = [UIColor clearColor];
    _dateLabel.textColor = kColor_Text2;
    _dateLabel.font = [UIFont systemFontOfSize:12];
    _dateLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_dateLabel];
    MJWeakSelf;
    [_resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.left.equalTo(@10);
        make.right.equalTo(weakSelf.dateLabel.mas_right);
    }];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.right.equalTo(@(-10));
        make.left.equalTo(weakSelf.dateLabel.mas_left);
        make.width.equalTo(@80);
    }];
}

- (void)setMeasure:(EMMeasureModel *)measure{
    _measure = measure;
    BOOL isLeft = [measure.finger_left boolValue];
    FingerType fingerType= [measure.finger_type integerValue];
    NSString *title = @"";
    if (isLeft) {
        title = [title stringByAppendingString:kLocalization(@"em_left_hand")];
    }else{
        title = [title stringByAppendingString:kLocalization(@"em_right_hand")];
    }
    switch (fingerType) {
        case kFingerOfThumb:
            title = [title stringByAppendingString:kLocalization(@"em_thumb")];
            break;
        case kFingerOfIndexFinger:
            title = [title stringByAppendingString:kLocalization(@"em_indexfinger")];
            break;
        case kFingerOfMiddleFinger:
            title = [title stringByAppendingString:kLocalization(@"em_middlefinger")];
            break;
        case kFingerOfRingFinger:
            title = [title stringByAppendingString:kLocalization(@"em_ringfinger")];
            break;
        case kFingerOfLittleFinger:
            title = [title stringByAppendingString:kLocalization(@"em_littlefinger")];
            break;
        default:
            break;
    }
    title =[title stringByAppendingFormat:kLocalization(@"em_measure_result_detail"),[measure.width floatValue]/10];
    _resultLabel.text = title;
   NSDate *date = [NSDate dateFromTimestampStr:_measure.measure_time];
    _dateLabel.text = [NSDate stringFromDate:date format:@"yyyy-MM-dd"];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
