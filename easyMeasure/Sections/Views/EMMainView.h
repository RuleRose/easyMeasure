//
//  EMMainView.h
//  easyMeasure
//
//  Created by qiwl on 2017/6/12.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMMeasureButton.h"
#import "EMFingerChooseViewController.h"
#import "EMResultsListViewController.h"

@interface EMMainView : UIView
@property(nonatomic, strong)UILabel *measureNotiLabel;
@property(nonatomic, strong)EMMeasureButton *leftFingerBtn;
@property(nonatomic, strong)EMMeasureButton *rightFingerBtn;
@property(nonatomic, strong)UIImageView *iconView;
@end
