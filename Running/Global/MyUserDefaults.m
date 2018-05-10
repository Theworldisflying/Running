//
//  MyUserDefaults.m
//  Running
//
//  Created by 123 on 2018/5/8.
//  Copyright © 2018年 123. All rights reserved.
//

#import "MyUserDefaults.h"
//static MyUserDefaults * userdefaults;
@implementation MyUserDefaults

//+(instancetype)allocWithZone:(struct _NSZone *)zone{
//    static dispatch_once_t onceToken;
//    // 一次函数
//    dispatch_once(&onceToken, ^{
//        if (userdefaults == nil) {
//            userdefaults = [super allocWithZone:zone];
//        }
//    });
//
//    return userdefaults;
//}
//+ (instancetype)share{
//
//    return  [[self alloc] init];
//}
+(void)wirteUserDefaultsF:(float)f andKey:(NSString*)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setFloat:f forKey:key];
    [defaults synchronize];

}
+(float)readUserDefaultsKey:(NSString*)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults floatForKey:key];
}

@end
