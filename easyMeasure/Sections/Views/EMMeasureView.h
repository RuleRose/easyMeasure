//
//  EMMeasureView.h
//  easyMeasure
//
//  Created by qiwl on 2017/6/12.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMMeasureModel.h"

@interface EMMeasureView : UIView
@property(nonatomic, assign) BOOL isLeft;
@property(nonatomic, assign) FingerType fingerType;
@property(nonatomic, strong) EMMeasureModel *measureModel;
@property(nonatomic, strong)UILabel *measureNotiLabel;
@property(nonatomic, strong)UILabel *measureLabel;
@property(nonatomic, strong)UIButton *addBtn;
@property(nonatomic, strong)UIButton *minusBtn;
@property(nonatomic, strong)UIButton *finishBtn;
@property(nonatomic, strong)UIView *handleView;
@property(nonatomic, assign)BOOL adding;
@property(nonatomic, assign)NSTimeInterval time; //刷新间隔
@property(nonatomic, strong)NSTimer *timer; //定时器
@property(nonatomic, strong)UIView *baseLine;//基准线
@property(nonatomic, strong)UIView *controlLine;//调节线
@property(nonatomic, assign)CGFloat width;//手指宽度
@property(nonatomic, assign)CGFloat widthUnit;//毫米单位
@property(nonatomic, strong)UIImageView *fingerImageView;
@property(nonatomic, strong)UIView *upRedCircle;
@property(nonatomic, strong)UIView *downRedCircle;
- (instancetype)initWithFingerType:(FingerType)fingerType isLeft:(BOOL)isLeft;
@end
