//
//  HKHealthStore+Extensisons.m
//  Running
//
//  Created by 123 on 2018/5/9.
//  Copyright © 2018年 123. All rights reserved.
//

#import "HKHealthStore+Extensisons.h"

@implementation HKHealthStore (Extensisons)

- (void)emhk_mostRecentQuantitySampleOfType:(HKSampleType *)quantityType predicate:(NSPredicate *)predicate completion:(void (^)(NSArray *results, NSError *error))completion {
    NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate ascending:NO];
    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:quantityType predicate:predicate limit:HKObjectQueryNoLimit sortDescriptors:@[timeSortDescriptor] resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {
        if (!results) {
            if (completion) {
                completion(nil, error);
            }
            return;
        }
        if (completion) {
            completion(results, error);
        }
    }];
    
    [self executeQuery:query];
}
@end
