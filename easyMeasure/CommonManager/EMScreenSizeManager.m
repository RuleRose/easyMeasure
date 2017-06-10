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
@end

@implementation EMScreenSizeManager
Singleton_Implementation(EMScreenSizeManager);

- (instancetype)init {
    self = [super init];
    if (self) {
        _width = NON_OBJECT_DEFAULT_VALUE;
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
    else if ([platform isEqualToString:@"iPhone9,1"])
        type = @"iPhone 7";
    else if ([platform isEqualToString:@"iPhone9,2"])
        type = @"iPhone 7 Plus";
    else if ([platform isEqualToString:@"i386"])
        type = @"iPhone Simulator";
    else if ([platform isEqualToString:@"x86_64"])
        type = @"iPhone Simulator";

    if ([type isEqualToString:@"iPhone 4"] || [type isEqualToString:@"iPhone 4S"]) {
        type = @"4";
    } else if ([type isEqualToString:@"iPhone 5"] || [type isEqualToString:@"iPhone 5c"] || [type isEqualToString:@"iPhone 5s"] ||
               [type isEqualToString:@"iPhone SE"]) {
        type = @"5";
    } else if ([type isEqualToString:@"iPhone 6"] || [type isEqualToString:@"iPhone 6s"] || [type isEqualToString:@"iPhone 7"]) {
        type = @"6";
    } else if ([type isEqualToString:@"iPhone 6 Plus"] || [type isEqualToString:@"iPhone 6s Plus"] || [type isEqualToString:@"iPhone 7 Plus"]) {
        type = @"6p";
    } else if ([type isEqualToString:@"iPhone Simulator"]) {
        type = @"6";
    } else {
        type = @"4";
    }

    return type;
}

- (CGFloat)hkdegreeWithWidth:(CGFloat)width{
    if (width <= 12) {
        return 1;
    }else if (width <= 12.25){
        return 1.5;
    }else if (width <= 12.5){
        return 2;
    }else if (width <= 12.65){
        return 2.5;
    }else if (width <= 12.8){
        return 3;
    }else if (width <= 13){
        return 3.5;
    }else if (width <= 13.2){
        return 4;
    }else if (width <= 13.35){
        return 4.5;
    }else if (width <= 13.5){
        return 5;
    }else if (width <= 13.8){
        return 5.5;
    }else if (width <= 14.1){
        return 6;
    }else if (width <= 14.3){
        return 6.5;
    }else if (width <= 14.5){
        return 7;
    }else if (width <= 14.7){
        return 7.5;
    }else if (width <= 14.9){
        return 8;
    }else if (width <= 15.05){
        return 8.5;
    }else if (width <= 15.2){
        return 9;
    }else if (width <= 15.35){
        return 9.5;
    }else if (width <= 15.5){
        return 10;
    }else if (width <= 15.65){
        return 10.5;
    }else if (width <= 15.8){
        return 11;
    }else if (width <= 16.05){
        return 11.5;
    }else if (width <= 16.3){
        return 12;
    }else if (width <= 16.5){
        return 12.5;
    }else if (width <= 16.7){
        return 13;
    }else if (width <= 16.85){
        return 13.5;
    }else if (width <= 17){
        return 14;
    }else if (width <= 17.15){
        return 14.5;
    }else if (width <= 17.3){
        return 15;
    }else if (width <= 17.45){
        return 15.5;
    }else if (width <= 17.6){
        return 16;
    }else if (width <= 17.7){
        return 16.5;
    }else if (width <= 17.8){
        return 17;
    }else if (width <= 18){
        return 17.5;
    }else if (width <= 18.2){
        return 18;
    }else if (width <= 18.45){
        return 18.5;
    }else if (width <= 18.7){
        return 19;
    }else if (width <= 18.85){
        return 19.5;
    }else if (width <= 19){
        return 20;
    }else if (width <= 19.15){
        return 20.5;
    }else if (width <= 19.3){
        return 21;
    }else if (width <= 19.5){
        return 21.5;
    }else if (width <= 19.7){
        return 22;
    }else if (width <= 19.95){
        return 22.5;
    }else if (width <= 20.2){
        return 23;
    }else if (width <= 20.3){
        return 23.5;
    }else if (width <= 20.4){
        return 24;
    }else if (width <= 20.55){
        return 24.5;
    }else if (width <= 20.7){
        return 25;
    }else if (width <= 20.9){
        return 25.5;
    }else if (width <= 21){
        return 26;
    }else if (width <= 21.15){
        return 26.5;
    }else if (width <= 21.3){
        return 27;
    }else if (width <= 21.4){
        return 27.5;
    }else if (width <= 21.5){
        return 28;
    }else if (width <= 21.6){
        return 28.5;
    }else if (width <= 21.7){
        return 29;
    }else if (width <= 21.85){
        return 29.5;
    }else if (width <= 22){
        return 30;
    }
    return 30;
}

- (CGFloat)usdegreeWithWidth:(CGFloat)width{
    if (width <= 12) {
        return 1;
    }else if (width <= 12.25){
        return 1.5;
    }else if (width <= 12.5){
        return 2;
    }else if (width <= 12.65){
        return 2.5;
    }else if (width <= 12.8){
        return 3;
    }else if (width <= 13){
        return 3.5;
    }else if (width <= 13.2){
        return 4;
    }else if (width <= 13.35){
        return 4.5;
    }else if (width <= 13.5){
        return 5;
    }else if (width <= 13.8){
        return 5.5;
    }else if (width <= 14.1){
        return 6;
    }else if (width <= 14.3){
        return 6.5;
    }else if (width <= 14.5){
        return 7;
    }else if (width <= 14.7){
        return 7.5;
    }else if (width <= 14.9){
        return 8;
    }else if (width <= 15.05){
        return 8.5;
    }else if (width <= 15.2){
        return 9;
    }else if (width <= 15.35){
        return 9.5;
    }else if (width <= 15.5){
        return 10;
    }else if (width <= 15.65){
        return 10.5;
    }else if (width <= 15.8){
        return 11;
    }else if (width <= 16.05){
        return 11.5;
    }else if (width <= 16.3){
        return 12;
    }else if (width <= 16.5){
        return 12.5;
    }else if (width <= 16.7){
        return 13;
    }else if (width <= 16.85){
        return 13.5;
    }else if (width <= 17){
        return 14;
    }else if (width <= 17.15){
        return 14.5;
    }else if (width <= 17.3){
        return 15;
    }else if (width <= 17.45){
        return 15.5;
    }else if (width <= 17.6){
        return 16;
    }else if (width <= 17.7){
        return 16.5;
    }else if (width <= 17.8){
        return 17;
    }else if (width <= 18){
        return 17.5;
    }else if (width <= 18.2){
        return 18;
    }else if (width <= 18.45){
        return 18.5;
    }else if (width <= 18.7){
        return 19;
    }else if (width <= 18.85){
        return 19.5;
    }else if (width <= 19){
        return 20;
    }else if (width <= 19.15){
        return 20.5;
    }else if (width <= 19.3){
        return 21;
    }else if (width <= 19.5){
        return 21.5;
    }else if (width <= 19.7){
        return 22;
    }else if (width <= 19.95){
        return 22.5;
    }else if (width <= 20.2){
        return 23;
    }else if (width <= 20.3){
        return 23.5;
    }else if (width <= 20.4){
        return 24;
    }else if (width <= 20.55){
        return 24.5;
    }else if (width <= 20.7){
        return 25;
    }else if (width <= 20.9){
        return 25.5;
    }else if (width <= 21){
        return 26;
    }else if (width <= 21.15){
        return 26.5;
    }else if (width <= 21.3){
        return 27;
    }else if (width <= 21.4){
        return 27.5;
    }else if (width <= 21.5){
        return 28;
    }else if (width <= 21.6){
        return 28.5;
    }else if (width <= 21.7){
        return 29;
    }else if (width <= 21.85){
        return 29.5;
    }else if (width <= 22){
        return 30;
    }
    return 30;
}

- (CGFloat)eurodegreeWithWidth:(CGFloat)width{
    if (width <= 12) {
        return 1;
    }else if (width <= 12.25){
        return 1.5;
    }else if (width <= 12.5){
        return 2;
    }else if (width <= 12.65){
        return 2.5;
    }else if (width <= 12.8){
        return 3;
    }else if (width <= 13){
        return 3.5;
    }else if (width <= 13.2){
        return 4;
    }else if (width <= 13.35){
        return 4.5;
    }else if (width <= 13.5){
        return 5;
    }else if (width <= 13.8){
        return 5.5;
    }else if (width <= 14.1){
        return 6;
    }else if (width <= 14.3){
        return 6.5;
    }else if (width <= 14.5){
        return 7;
    }else if (width <= 14.7){
        return 7.5;
    }else if (width <= 14.9){
        return 8;
    }else if (width <= 15.05){
        return 8.5;
    }else if (width <= 15.2){
        return 9;
    }else if (width <= 15.35){
        return 9.5;
    }else if (width <= 15.5){
        return 10;
    }else if (width <= 15.65){
        return 10.5;
    }else if (width <= 15.8){
        return 11;
    }else if (width <= 16.05){
        return 11.5;
    }else if (width <= 16.3){
        return 12;
    }else if (width <= 16.5){
        return 12.5;
    }else if (width <= 16.7){
        return 13;
    }else if (width <= 16.85){
        return 13.5;
    }else if (width <= 17){
        return 14;
    }else if (width <= 17.15){
        return 14.5;
    }else if (width <= 17.3){
        return 15;
    }else if (width <= 17.45){
        return 15.5;
    }else if (width <= 17.6){
        return 16;
    }else if (width <= 17.7){
        return 16.5;
    }else if (width <= 17.8){
        return 17;
    }else if (width <= 18){
        return 17.5;
    }else if (width <= 18.2){
        return 18;
    }else if (width <= 18.45){
        return 18.5;
    }else if (width <= 18.7){
        return 19;
    }else if (width <= 18.85){
        return 19.5;
    }else if (width <= 19){
        return 20;
    }else if (width <= 19.15){
        return 20.5;
    }else if (width <= 19.3){
        return 21;
    }else if (width <= 19.5){
        return 21.5;
    }else if (width <= 19.7){
        return 22;
    }else if (width <= 19.95){
        return 22.5;
    }else if (width <= 20.2){
        return 23;
    }else if (width <= 20.3){
        return 23.5;
    }else if (width <= 20.4){
        return 24;
    }else if (width <= 20.55){
        return 24.5;
    }else if (width <= 20.7){
        return 25;
    }else if (width <= 20.9){
        return 25.5;
    }else if (width <= 21){
        return 26;
    }else if (width <= 21.15){
        return 26.5;
    }else if (width <= 21.3){
        return 27;
    }else if (width <= 21.4){
        return 27.5;
    }else if (width <= 21.5){
        return 28;
    }else if (width <= 21.6){
        return 28.5;
    }else if (width <= 21.7){
        return 29;
    }else if (width <= 21.85){
        return 29.5;
    }else if (width <= 22){
        return 30;
    }
    return 30;
}
@end
