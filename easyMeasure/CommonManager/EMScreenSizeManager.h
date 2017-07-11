//
//  EMScreenSizeManager.h
//  easyMeasure
//
//  Created by yongche on 17/5/26.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EMScreenSizeManager : NSObject
Singleton_Interface(EMScreenSizeManager);

- (CGFloat)widthOfOnePoint; //返回毫米单位

- (CGFloat)hkdegreeWithWidth:(CGFloat)width basic:(BOOL)isBasic;
- (CGFloat)usdegreeWithWidth:(CGFloat)width basic:(BOOL)isBasic;
- (CGFloat)eurodegreeWithWidth:(CGFloat)width basic:(BOOL)isBasic;

@end
