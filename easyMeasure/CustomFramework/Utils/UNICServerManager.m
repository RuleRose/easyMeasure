//
//  LeieServerManager.m
//  storyhouse2
//
//  Created by 肖君 on 16/7/8.
//  Copyright © 2016年 LEIE. All rights reserved.
//

#import "UNICServerManager.h"

static UNICServerManager *_shareManager = nil;

@implementation UNICServerManager

+ (UNICServerManager *)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      _shareManager = [[UNICServerManager alloc] init];
    });
    return _shareManager;
}

- (void)loadSettingsConfig {
    _serverURL = @"iotpilot.miaomiaoce.com";
}
@end
