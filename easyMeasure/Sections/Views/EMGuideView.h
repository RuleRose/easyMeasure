//
//  EMGuideView.h
//  easyMeasure
//
//  Created by qiwl on 2017/6/25.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EMGuideViewViewDelegate;
@interface EMGuideView : UIView
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImage *placeholderImage;
@property (nonatomic, strong) NSArray *imageNames;
@property (nonatomic, assign) id<EMGuideViewViewDelegate> delegate;

//- (void)setPageColor:(UIColor *)color andCurrentPageColor:(UIColor *)currentColor;
@end
@protocol EMGuideViewViewDelegate <NSObject>
@optional
- (void)hiddenGuide;
@end
