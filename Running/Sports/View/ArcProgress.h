//
//  ArcProgress.h
//  Running
//
//  Created by 123 on 2018/5/8.
//  Copyright © 2018年 123. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kScreenW [[UIScreen mainScreen] bounds].size.width

#define kScreenH [[UIScreen mainScreen] bounds].size.height

@interface ArcProgress : UIView




@property(assign,nonatomic) CGFloat totalNum;
@property(assign,nonatomic) CGFloat comNum;

/**
 渐变色开始颜色。
 */
@property (nonatomic, strong) UIColor *startColor;

/**
 渐变色结束颜色。
 */
@property (nonatomic, strong) UIColor *endColor;

@end
