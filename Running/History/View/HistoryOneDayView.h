//
//  HistoryOneDayView.h
//  Running
//
//  Created by 123 on 2018/5/10.
//  Copyright © 2018年 123. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryOneDayView : UIView

@property(strong,nonatomic) UILabel * targetStepLabel;
@property(strong,nonatomic) UILabel * completionStepLabel;
@property(strong,nonatomic) UILabel * percentLabel;
@property(strong,nonatomic) UILabel * kmLabel;
@property(strong,nonatomic) UILabel * kioLabel;
@property(strong,nonatomic) UILabel * timeLabel;

@property(assign,nonatomic) UILabel * typeLavel;

@property(strong,nonatomic) UIImageView * imgv;




@end
