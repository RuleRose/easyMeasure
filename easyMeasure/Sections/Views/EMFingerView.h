//
//  FingerView.h
//  easyMeasure
//
//  Created by qiwl on 2017/6/9.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMMeasureButton.h"

@protocol FingerViewDelegate;
@interface EMFingerView : UIView
- (instancetype)initWithLeft:(BOOL)left fingerType:(FingerType)fingerType;
@property(nonatomic, assign) CGFloat radius;
@property(nonatomic, assign) BOOL isLeft;
@property(nonatomic, assign) CGSize buttonSize;
@property(nonatomic, assign) CGFloat marginDisease;
@property(nonatomic, strong) UIView *contentView;
@property(nonatomic, strong) EMMeasureButton *fingerBtn;
@property(nonatomic, assign) id<FingerViewDelegate> delegate;
@property(nonatomic, assign) FingerType fingerType;
@property(nonatomic, strong) NSString *finger;

@end
@protocol FingerViewDelegate <NSObject>
@optional
- (void)measureFinger:(FingerType)fingerType left:(BOOL)isLeft;
@end
