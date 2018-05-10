//
//  HealthModel.h
//  Running
//
//  Created by 123 on 2018/5/9.
//  Copyright © 2018年 123. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HealthModel : NSObject
@property (nonatomic, assign)float totalStep;
@property (nonatomic, assign)float compStep;
@property (nonatomic, assign)float distance;
@property (nonatomic, assign)float weight;
@property (nonatomic, assign)float energy;
@property (nonatomic, copy)NSString* hours;
@property (nonatomic, copy)NSString* savedate;

@end
