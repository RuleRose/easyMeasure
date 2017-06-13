//
//  EMFingerChooseView.h
//  easyMeasure
//
//  Created by qiwl on 2017/6/12.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMFingerView.h"
#import "EMMeasureViewController.h"

@interface EMFingerChooseView : UIView
@property(nonatomic, assign) BOOL isLeft;
@property(nonatomic, strong)UILabel *measureNotiLabel;
@property(nonatomic, strong)EMFingerView *thumbView;
@property(nonatomic, strong)EMFingerView *indexFingerView;
@property(nonatomic, strong)EMFingerView *middleFingerView;
@property(nonatomic, strong)EMFingerView *ringFingerView;
@property(nonatomic, strong)EMFingerView *littleFingerView;
- (instancetype)initWithIsLeft:(BOOL)isLeft;
@end
