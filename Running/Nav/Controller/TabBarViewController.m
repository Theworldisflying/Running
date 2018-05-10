//
//  TabBarViewController.m
//  Running
//
//  Created by guangwei li on 2018/5/7.
//  Copyright © 2018年 123. All rights reserved.
//

#import "TabBarViewController.h"
#import "MyNavgationViewController.h"
#import "SportViewController.h"
#import "HistoryViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    ////
    //添加tabBar
    [self TabBarView];
}
//tabBar
-(void)TabBarView
{
    
    
    SportViewController *sport = [[SportViewController alloc] init];
    [self addChildVC:sport title:@"主页" image:@"tabbar_home" selImage:@"tabbar_home_selected"];
    
    HistoryViewController *myView = [[HistoryViewController alloc] init];
    [self addChildVC:myView title:@"历史记录" image:@"tabbar_discover" selImage:@"tabbar_discover_selected"];
    
}
-(void)addChildVC:(UIViewController *)ChildVC title:(NSString *)title image:(NSString *)image selImage:(NSString *)selImage
{
//    ChildVC.view.backgroundColor     = [UIColor whiteColor];
    // 设置子控制器的图片
    ChildVC.tabBarItem.image         = [UIImage imageNamed:image];
    ChildVC.tabBarItem.selectedImage = [[UIImage imageNamed:selImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置文字的样式
    NSMutableDictionary *textAttrs   = [NSMutableDictionary dictionary];
    ///tabbar 底部字体颜色
    textAttrs[NSForegroundColorAttributeName] = RCRGBColor(123, 123, 123);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [ChildVC.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [ChildVC.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    
    ChildVC.title    = title;
    
    //
    MyNavgationViewController *nav = [[MyNavgationViewController alloc] initWithRootViewController:ChildVC];
    
    
    [self addChildViewController:nav];
}


@end
