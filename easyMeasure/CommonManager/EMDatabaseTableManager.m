//
//  MMCDatabaseTableManager.m
//  mmcS2
//
//  Created by 肖君 on 16/10/25.
//  Copyright © 2016年 johnxiao. All rights reserved.
//

#import "EMDatabaseTableManager.h"
#import "XJFDBManager.h"

@implementation EMDatabaseTableManager
Singleton_Implementation(EMDatabaseTableManager);

- (void)initDatabase {
    //    NSArray *DBTableArray = @[ [UNICCommonOrderModel class], [UNICCommonTemperatureModel class] ];
    //
    //    for (Class model in DBTableArray) {
    //        /**
    //         *  创建表格
    //         *  注意，mode中的类型nstring/nsinteger/cgfloat，并且命名必须全部小写。
    //         *
    //         *  @param className 表明
    //         *
    //         *  @return 是否成功
    //         */
    //        [UNICDBManager createTableWithModel:model];
    //    }
}
@end
