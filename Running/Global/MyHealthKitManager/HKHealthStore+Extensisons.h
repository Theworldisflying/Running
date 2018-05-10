//
//  HKHealthStore+Extensisons.h
//  Running
//
//  Created by 123 on 2018/5/9.
//  Copyright © 2018年 123. All rights reserved.
//

#import <HealthKit/HealthKit.h>

@interface HKHealthStore (Extensisons)
/**
 * 获取某一项指标系统提供的所有结果
 * @param quantityType 指标类型
 * @param predicate 时间点
 * @param completion 回调
 */
- (void)emhk_mostRecentQuantitySampleOfType:(HKSampleType *)quantityType predicate:(NSPredicate *)predicate completion:(void (^)(NSArray *results, NSError *error))completion;


@end
