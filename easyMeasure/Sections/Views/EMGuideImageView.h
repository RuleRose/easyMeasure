//
//  EMGuideImageView.h
//  easyMeasure
//
//  Created by qiwl on 2017/6/25.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^GuideHiddenBlock)();

@interface EMGuideImageView : UIImageView
@property(nonatomic, assign)GuideHiddenBlock hiddenblock;
@end
