//
//  LeieServerManager.h
//  storyhouse2
//
//  Created by 肖君 on 16/7/8.
//  Copyright © 2016年 LEIE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UNICServerManager : NSObject
@property(nonatomic, copy) NSString *serverURL;

+ (UNICServerManager *)shareManager;
- (void)loadSettingsConfig;
@end
