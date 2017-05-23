//
//  UNICOrderResendManager.m
//  unicorn
//
//  Created by 肖君 on 17/3/4.
//  Copyright © 2017年 johnxiao. All rights reserved.
//

#import "UNICOrderResendManager.h"
#import "UNICCommonOrderModel.h"
#import "UNICNetworkAgent.h"

@interface UNICOrderResendManager ()
@property(nonatomic, strong) NSTimer *timerRetry;
@property(nonatomic, strong) NSMutableArray<UNICCommonOrderModel *> *orderList;
@property(nonatomic, assign) BOOL isOrderChanged;
@end

@implementation UNICOrderResendManager
Singleton_Implementation(UNICOrderResendManager);
- (NSTimer *)timerRetry {
    if (!_timerRetry) {
        _timerRetry = [NSTimer scheduledTimerWithTimeInterval:(60.0 * 5.0) target:self selector:@selector(retrySendOrder) userInfo:nil repeats:YES];
    }
    return _timerRetry;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _orderList = [NSMutableArray array];
        _isOrderChanged = NO;
    }
    return self;
}

- (void)startRetry {
    [self.timerRetry fire];
}

- (void)retrySendOrder {
    if ([[AFNetworkReachabilityManager sharedManager] isReachable]) {
        UNICCommonOrderModel *orderToUpdate = nil;

        if ([self.orderList count] > 0) {
            orderToUpdate = [self.orderList lastObject];
        } else {
            UNICCommonOrderModel *orderCondition = [[UNICCommonOrderModel alloc] init];
            orderCondition.order_type = 1;
            orderCondition.is_uploaded = 2;
            [self.orderList addObjectsFromArray:[UNICDBManager searchModelsWithCondition:orderCondition andpage:-1 andOrderby:nil isAscend:NO]];
            if ([self.orderList count] > 0) {
                orderToUpdate = [self.orderList lastObject];
            }
        }

        if (orderToUpdate) {
            @weakify(self);
            [[UNICNetworkAgent defaultInstance]
                registerOrderWithMac:orderToUpdate.mac
                          expressNum:orderToUpdate.number
                           hightTemp:orderToUpdate.high_temp
                             lowTemp:orderToUpdate.low_temp
                           startTime:orderToUpdate.start_time
                             endTime:nil
                               state:1
                            callback:^(NSError *error, NSDictionary *dic) {
                              @strongify(self);
                              if (!error) {
                                  orderToUpdate.order_id = [[dic leie_getObjectByPath:@"order_id"] integerValue];
                                  orderToUpdate.create_time = [[NSDate date] displayStringOfDate];
                                  orderToUpdate.is_uploaded = 1;
                                  [orderToUpdate updateToDBDependsOn:@[ @"mac", @"number", @"order_type" ]];
                                  [self.orderList removeLastObject];
                                  self.isOrderChanged = YES;
                                  [self retrySendOrder];
                              } else {
                                  //提交不成功，等待下次timer到时间。
                                  [self.orderList removeAllObjects];
                                  if (self.isOrderChanged) {
                                      self.isOrderChanged = NO;
                                      [[NSNotificationCenter defaultCenter] postNotificationName:UNICNotificationKeyOrderListChanged object:self];
                                  }
                              }
                            }];
        } else {
            if (self.isOrderChanged) {
                self.isOrderChanged = NO;
                [[NSNotificationCenter defaultCenter] postNotificationName:UNICNotificationKeyOrderListChanged object:self];
            }
        }
    }
}
@end
