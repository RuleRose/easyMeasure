//
//  MMCDBManager.m
//  mmcS2
//
//  Created by 肖君 on 16/10/24.
//  Copyright © 2016年 johnxiao. All rights reserved.
//

#import "UNICDBManager.h"
#import "UNICDBOperator.h"

@implementation UNICDBManager
+ (BOOL)createTableWithModel:(Class)className {
    Class class = className;
    NSMutableString *createSql = [NSMutableString new];
    UNICDBOperator *operator= [UNICDBOperator defaultInstance];

    NSString *tableName = NSStringFromClass(class);
    [createSql appendFormat:@"create table if not exists %@ (", tableName];
    [createSql appendFormat:@"%@ VARCHAR primary key, ", kModelPrimary];

    NSArray *ignoredPropertyNames = [class mj_totalIgnoredPropertyNames];

    while (class && ![[NSString stringWithUTF8String:object_getClassName(class)] isEqualToString:@"NSObject"]) {
        unsigned int numberOfIvars = 0;
        //获取class 类成员变量列表
        objc_property_t *ivars = class_copyPropertyList(class, &numberOfIvars);
        //采用指针+1 来获取下一个变量
        for (const objc_property_t *p = ivars; p < ivars + numberOfIvars; p++) {
            NSString *propertyName = [NSString stringWithUTF8String:property_getName(*p)];
            // 如果是忽略字段则不创建
            if (ignoredPropertyNames && [ignoredPropertyNames containsObject:propertyName]) continue;

            if (![propertyName isEqualToString:kModelPrimary]) {
                NSString *propertyType = [NSString stringWithUTF8String:property_getAttributes(*p)];
                DDLogDebug(@"property type %@", propertyType);
                if ([propertyType rangeOfString:@"NSString"].location != NSNotFound) {  // nsstring
                    [createSql appendFormat:@" %@ TEXT ,", propertyName];
                } else if (([propertyType rangeOfString:@"Tq"].location == 0) || ([propertyType rangeOfString:@"Ti"].location == 0)) {  // nsinteger
                    [createSql appendFormat:@" %@ INTEGER ,", propertyName];
                } else if (([propertyType rangeOfString:@"Td"].location == 0) || ([propertyType rangeOfString:@"Tf"].location == 0)) {  // double,float
                    [createSql appendFormat:@" %@ REAL ,", propertyName];
                }

                //                } else if ([propertyType rangeOfString:@"NSURL"].location != NSNotFound) {
                //                    [createSql appendFormat:@" %@ VARCHAR ,", propertyName];
                //
                //                } else if ([propertyType rangeOfString:@"NSNumber"].location != NSNotFound) {
                //                    [createSql appendFormat:@" %@ VARCHAR ,", propertyName];
                //
                //                } else if ([propertyType rangeOfString:@"NSDate"].location != NSNotFound) {
                //                    [createSql appendFormat:@" %@ VARCHAR ,", propertyName];
                //                } else {
                //                    DDLogDebug(@"%@ 的 %@ 属性(类型:%@)已在建表时自动忽略 ", tableName, propertyName,
                //                               [propertyType substringWithRange:NSMakeRange(3, [propertyType rangeOfString:@","].location - 4)]);
                //                }
            }
        }

        free(ivars);
        class = class_getSuperclass(class);
    }

    NSRange range = NSMakeRange(createSql.length - 1, 1);
    [createSql deleteCharactersInRange:range];  // 删除最后一个逗号","

    [createSql appendFormat:@" )"];

    BOOL isSuccess = [operator executeSQLs:createSql];
    if (!isSuccess) {
        DDLogDebug(@"== %@ 表创建失败 ==", tableName);
    } else {
        DDLogDebug(@"== %@ 表创建成功 ==", tableName);
    }

    return isSuccess;
}

+ (BOOL)insertModel:(BaseModel *)model {
    if (nil == model) {
        return NO;
    }
    if (![model valueForKey:kModelPrimary]) {
        model.pid = [NSString leie_UUID];
    }
    UNICDBOperator *operator= [UNICDBOperator defaultInstance];
    return [operator insertData:model];
}

+ (void)batchInsertModel:(NSArray<BaseModel *> *)modelList {
    if (nil == modelList || modelList.count == 0) {
        DDLogDebug(@"Batch insert failed!");
        return;
    }

    for (BaseModel *model in modelList) {
        if (![model valueForKey:kModelPrimary]) {
            model.pid = [NSString leie_UUID];
        }
    }

    UNICDBOperator *operator= [UNICDBOperator defaultInstance];
    [operator batchInsertData:modelList];
}

+ (BOOL)deleteModel:(BaseModel *)model dependOnKeys:(NSArray *)keys {
    if (nil == model) {
        return NO;
    }
    if (!keys || 0 == keys.count) {
        keys = [NSArray arrayWithObject:kModelPrimary];
    }

    UNICDBOperator *operator= [UNICDBOperator defaultInstance];
    return [operator deleteData:model dependOnKeys:keys];
}

+ (BOOL)updateModel:(BaseModel *)model dependOnKeys:(NSArray *)keys {
    if (nil == model) {
        return NO;
    }
    if (!keys || 0 == keys.count) {
        keys = [NSArray arrayWithObject:kModelPrimary];
    }
    UNICDBOperator *operator= [UNICDBOperator defaultInstance];
    return [operator updateData:model dependOnKeys:keys];
}

+ (BOOL)clearTableModel:(BaseModel *)model {
    if (nil == model) {
        return NO;
    }

    UNICDBOperator *operator= [UNICDBOperator defaultInstance];
    return [operator clearTable:model];
}

+ (NSArray *)searchModelsWithCondition:(BaseModel *)condition andpage:(int)pageindex andOrderby:(NSString *)orderBy isAscend:(BOOL)isAscend {
    UNICDBOperator *operator= [UNICDBOperator defaultInstance];
    return [operator searchModelsWithCondition:condition andpage:pageindex andOrderby:orderBy isAscend:isAscend];
}

+ (NSInteger)resultCountWithCondition:(BaseModel *)condition {
    UNICDBOperator *operator= [UNICDBOperator defaultInstance];
    return [operator resultCountWithCondition:condition];
}
@end
