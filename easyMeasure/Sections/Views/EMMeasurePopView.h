//
//  EMMeasurePopView.h
//  easyMeasure
//
//  Created by qiwl on 2017/7/10.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMMeasureButton.h"

@interface EMMeasurePopView : UIView
@property(nonatomic,strong)UILabel *measureLabel;
@property(nonatomic,strong)UIImageView *triView;
@property(nonatomic,strong)UIView *baseView;
@property(nonatomic,strong)UIImageView *notiImageView;
@property(nonatomic,strong)EMMeasureButton *confirmBtn;

- (void)showMenus;
- (void)hiddenMenus;
@end
