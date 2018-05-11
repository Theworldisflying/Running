//
//  DateManager.m
//  Running
//
//  Created by 123 on 2018/5/11.
//  Copyright © 2018年 123. All rights reserved.
//

#import "DateManager.h"

@implementation DateManager

+(NSString*)getDateYMD{
    NSDateFormatter * f = [[NSDateFormatter alloc] init];
    f.dateFormat = @"yyyy-MM-dd";
    return [f stringFromDate:[NSDate date]];
}

@end
