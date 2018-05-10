//
//  MyUserDefaults.h
//  Running
//
//  Created by 123 on 2018/5/8.
//  Copyright © 2018年 123. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyUserDefaults : NSObject


+(void)wirteUserDefaultsF:(float)f andKey:(NSString*)key;
+(float)readUserDefaultsKey:(NSString*)key;


@end
