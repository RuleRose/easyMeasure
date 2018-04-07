//
//  EMScreenSizeManager.m
//  easyMeasure
//
//  Created by yongche on 17/5/26.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import "EMScreenSizeManager.h"
#import <sys/utsname.h>

@interface EMScreenSizeManager ()
@property(nonatomic, assign) CGFloat width;
@property(nonatomic, strong) NSMutableDictionary *degreeDic;

@end

@implementation EMScreenSizeManager
Singleton_Implementation(EMScreenSizeManager);

- (instancetype)init {
    self = [super init];
    if (self) {
        _width = NON_OBJECT_DEFAULT_VALUE;
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"EMDegree" ofType:@"plist"];
        _degreeDic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
        
        
        
    }
    return self;
}

- (CGFloat)widthOfOnePoint {
    if (self.width != NON_OBJECT_DEFAULT_VALUE) {
        return self.width;
    }

    NSString *screenSizePath = [[NSBundle mainBundle] pathForResource:@"DeviceScreenSize" ofType:@"plist"];
    NSDictionary *devicesInfo = [NSDictionary dictionaryWithContentsOfFile:screenSizePath];
    NSString *deviceType = [self iphoneType];

    NSDictionary *screenInof = [devicesInfo leie_getObjectByPath:deviceType];
    CGFloat size = ((NSNumber *)[screenInof leie_getObjectByPath:@"size"]).floatValue;
    CGFloat width = ((NSNumber *)[screenInof leie_getObjectByPath:@"width"]).floatValue;
    CGFloat height = ((NSNumber *)[screenInof leie_getObjectByPath:@"height"]).floatValue;

    self.width = (size / sqrt(width * width + height * height)) * 25.4;

    return self.width;
}

- (NSString *)iphoneType {
    struct utsname systemInfo;
    uname(&systemInfo);

    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    NSString *type = @"";

    if ([platform isEqualToString:@"iPhone3,1"])
        type = @"iPhone 4";
    else if ([platform isEqualToString:@"iPhone3,2"])
        type = @"iPhone 4";
    else if ([platform isEqualToString:@"iPhone3,3"])
        type = @"iPhone 4";
    else if ([platform isEqualToString:@"iPhone4,1"])
        type = @"iPhone 4S";
    else if ([platform isEqualToString:@"iPhone5,1"])
        type = @"iPhone 5";
    else if ([platform isEqualToString:@"iPhone5,2"])
        type = @"iPhone 5";
    else if ([platform isEqualToString:@"iPhone5,3"])
        type = @"iPhone 5c";
    else if ([platform isEqualToString:@"iPhone5,4"])
        type = @"iPhone 5c";
    else if ([platform isEqualToString:@"iPhone6,1"])
        type = @"iPhone 5s";
    else if ([platform isEqualToString:@"iPhone6,2"])
        type = @"iPhone 5s";
    else if ([platform isEqualToString:@"iPhone7,1"])
        type = @"iPhone 6 Plus";
    else if ([platform isEqualToString:@"iPhone7,2"])
        type = @"iPhone 6";
    else if ([platform isEqualToString:@"iPhone8,1"])
        type = @"iPhone 6s";
    else if ([platform isEqualToString:@"iPhone8,2"])
        type = @"iPhone 6s Plus";
    else if ([platform isEqualToString:@"iPhone8,4"])
        type = @"iPhone SE";
    else if ([platform isEqualToString:@"iPhone9,1"] || [platform isEqualToString:@"iPhone9,3"])
        type = @"iPhone 7";
    else if ([platform isEqualToString:@"iPhone9,2"] || [platform isEqualToString:@"iPhone9,4"])
        type = @"iPhone 7 Plus";
    else if ([platform isEqualToString:@"iPhone10,1"] || [platform isEqualToString:@"iPhone10,4"])
        type = @"iPhone 8";
    else if ([platform isEqualToString:@"iPhone10,2"] || [platform isEqualToString:@"iPhone10,5"])
        type = @"iPhone 8 Plus";
    else if ([platform isEqualToString:@"iPhone10,3"] || [platform isEqualToString:@"iPhone10,6"])
        type = @"iPhone X";
    else if ([platform isEqualToString:@"i386"])
        type = @"iPhone Simulator";
    else if ([platform isEqualToString:@"x86_64"])
        type = @"iPhone Simulator";

    if ([type isEqualToString:@"iPhone 4"] || [type isEqualToString:@"iPhone 4S"]) {
        type = @"4";
    } else if ([type isEqualToString:@"iPhone 5"] || [type isEqualToString:@"iPhone 5c"] || [type isEqualToString:@"iPhone 5s"] ||
               [type isEqualToString:@"iPhone SE"]) {
        type = @"5";
    } else if ([type isEqualToString:@"iPhone 6"] || [type isEqualToString:@"iPhone 6s"] || [type isEqualToString:@"iPhone 7"] || [type isEqualToString:@"iPhone 8"]) {
        type = @"6";
    } else if ([type isEqualToString:@"iPhone 6 Plus"] || [type isEqualToString:@"iPhone 6s Plus"] || [type isEqualToString:@"iPhone 7 Plus"] || [type isEqualToString:@"iPhone 8 Plus"]) {
        type = @"6p";
    } else if ([type isEqualToString:@"iPhone X"]) {
        type = @"X";
    }else if ([type isEqualToString:@"iPhone Simulator"]) {
        type = @"6";
    } else {
        type = @"4";
    }

    return type;
}

- (CGFloat)hkdegreeWithWidth:(CGFloat)width basic:(BOOL)isBasic{
    
    
    if (isBasic) {
        NSDictionary *basicDic = [_degreeDic objectForKey:@"basic"];
        NSDictionary *hkDic = [basicDic objectForKey:@"hk"];
        return [self degreeWithWidth:width degrees:hkDic];
    }else{
        NSDictionary *rangingDic = [_degreeDic objectForKey:@"ranging"];
        NSDictionary *hkDic = [rangingDic objectForKey:@"hk"];
        return [self degreeWithWidth:width degrees:hkDic];
    }

}

- (CGFloat)usdegreeWithWidth:(CGFloat)width basic:(BOOL)isBasic{
    if (isBasic) {
        NSDictionary *basicDic = [_degreeDic objectForKey:@"basic"];
        NSDictionary *usDic = [basicDic objectForKey:@"us"];
        return [self degreeWithWidth:width degrees:usDic];
    }else{
        NSDictionary *rangingDic = [_degreeDic objectForKey:@"ranging"];
        NSDictionary *usDic = [rangingDic objectForKey:@"us"];
        return [self degreeWithWidth:width degrees:usDic];
    }
}

- (CGFloat)eurodegreeWithWidth:(CGFloat)width basic:(BOOL)isBasic{
    if (isBasic) {
        NSDictionary *basicDic = [_degreeDic objectForKey:@"basic"];
        NSDictionary *euroDic = [basicDic objectForKey:@"euro"];
        return [self degreeWithWidth:width degrees:euroDic];
    }else{
        NSDictionary *rangingDic = [_degreeDic objectForKey:@"ranging"];
        NSDictionary *euroDic = [rangingDic objectForKey:@"euro"];
        return [self degreeWithWidth:width degrees:euroDic];
    }
}

- (CGFloat)degreeWithWidth:(CGFloat)width degrees:(NSDictionary *)degrees{
    CGFloat up_degree = 0;
    CGFloat down_degree = 0;
    CGFloat up_degree_width = 100;
    CGFloat down_degree_width = 0;
    for (NSString *degree_width in degrees.allKeys) {
        if ([degree_width floatValue] >= width && [degree_width floatValue] <= up_degree_width) {
            up_degree = [[degrees objectForKey:degree_width] floatValue];
            up_degree_width = [degree_width floatValue];
        }
        if ([degree_width floatValue] <= width && [degree_width floatValue] >= down_degree_width) {
            down_degree = [[degrees objectForKey:degree_width] floatValue];
            down_degree_width = [degree_width floatValue];
        }
    }
    
    if (width > up_degree_width) {
        return 0;
    }
    
    if (down_degree_width == 0) {
        return 0;
    }
    if (up_degree_width == 100) {
        return 0;
    }
    return up_degree;
}
@end
