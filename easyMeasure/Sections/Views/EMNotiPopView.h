//
//  EMNotiPopView.h
//  easyMeasure
//
//  Created by qiwl on 2017/6/17.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EMNotiPopView : UIView
@property(nonatomic,strong)UIView *baseView;
@property(nonatomic,strong)UIImageView *triImageView;
@property(nonatomic,strong)UIImageView *notiImageView;
@property(nonatomic,strong)UIButton *confirmBtn;

- (void)showMenus;
- (void)hiddenMenus;
@end
