//
//  AppDelegate.m
//  Running
//
//  Created by 123 on 2018/5/7.
//  Copyright © 2018年 123. All rights reserved.
//

#import "AppDelegate.h"
#import "GuidePageViewController.h"
#import "TabBarViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //创建window
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    
    
    //1.获取当前版本号
    NSString *currentVerison = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    //2.获取上一次版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:YGVersionKey];
    //3.判断当前是否有新的版本，如果有新特性，进入新特性界面
    if ([currentVerison isEqualToString:lastVersion]) {//没有最新版本号
        
        self.window.rootViewController = [[TabBarViewController alloc] init];
        
    }else{//有最新版本号，进入新特性界面
        GuidePageViewController *newFeature = [[GuidePageViewController alloc]init];
        //保存当前版本
        [[NSUserDefaults standardUserDefaults] setObject:currentVerison forKey:YGVersionKey];
        //        // 设置窗口的根控制器
        self.window.rootViewController = newFeature;
    }
    
    
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
