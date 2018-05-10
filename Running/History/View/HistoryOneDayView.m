//
//  HistoryOneDayView.m
//  Running
//
//  Created by 123 on 2018/5/10.
//  Copyright © 2018年 123. All rights reserved.
//

#import "HistoryOneDayView.h"

@interface HistoryOneDayView()



@property(strong,nonatomic) NSString * path;
@end

@implementation HistoryOneDayView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
    self.imgv = [[UIImageView alloc] init];
    [self addSubview:_imgv];
    [self.imgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo((Width-Width/3)/2);
        make.top.equalTo(self).with.offset(80);
        make.width.mas_equalTo(Width/3);
        make.height.mas_equalTo(Width/3);
    }];
//    NSString * tips;
//    if (self.type == 1) {
//        self.path = [[NSBundle mainBundle] pathForResource:@"failure" ofType:@"png"];
//        tips = @"未完成制定目标!";
//    }else if (self.type == 2){
//        self.path = [[NSBundle mainBundle] pathForResource:@"happy" ofType:@"png"];
//        tips = @"恭喜完成制定目标!";
//    }else if (self.type == 3){
//        self.path = [[NSBundle mainBundle] pathForResource:@"happyp" ofType:@"png"];
//        tips = @"恭喜超额完成制定目标!";
//    }else {
//        self.path = [[NSBundle mainBundle] pathForResource:@"failure" ofType:@"png"];
//        tips = @"未完成制定目标!";
//    }
    
    UIImage * img = [UIImage imageWithContentsOfFile:_path];
    
    self.imgv.image = img;
    
    
    UILabel * tipLabel = [[UILabel alloc] init];
    self.typeLavel  = tipLabel;
    [self setLabel:tipLabel Font:15 text:@"" FontColor:[UIColor blackColor]];
    [self addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgv);
        make.top.equalTo(self.imgv.mas_bottom).offset(5);
        make.width.mas_equalTo(Width/3);
        make.height.mas_equalTo(40);
    }];
    
    
    CGFloat font = 22;
    CGFloat titleFont = 18;
    //制定目标
    self.targetStepLabel = [[UILabel alloc] init];
    [self setLabel:_targetStepLabel Font:font text:[NSString stringWithFormat:@"%.1f",0.0] FontColor:[UIColor blueColor]];
    [self addSubview:_targetStepLabel];
    self.targetStepLabel.font = [UIFont boldSystemFontOfSize:font];
    [self.targetStepLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(tipLabel.mas_bottom).with.offset(20);
        make.width.mas_equalTo(Width/3);
        make.height.mas_equalTo(40);
    }];
    
    UILabel * targetTitle = [[UILabel alloc] init];
    [self setLabel:targetTitle Font:titleFont text:@"制定目标" FontColor:[UIColor blackColor]];
    [self addSubview:targetTitle];
    [targetTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self.targetStepLabel.mas_bottom);
        make.width.mas_equalTo(Width/3);
        make.height.mas_equalTo(40);
    }];
    
    //实际步数
    self.completionStepLabel = [[UILabel alloc] init];
    [self setLabel:_completionStepLabel Font:font text:[NSString stringWithFormat:@"%.1f",0.0] FontColor:[UIColor blueColor]];
    [self addSubview:_completionStepLabel];
    self.completionStepLabel.font = [UIFont boldSystemFontOfSize:font];
    [self.completionStepLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.targetStepLabel.mas_right);
        make.top.equalTo(self.targetStepLabel);
        make.width.mas_equalTo(Width/3);
        make.height.mas_equalTo(40);
    }];
    
    UILabel * comTitle = [[UILabel alloc] init];
    [self setLabel:comTitle Font:titleFont text:@"实际步数" FontColor:[UIColor blackColor]];
    [self addSubview:comTitle];
    [comTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.completionStepLabel);
        make.top.equalTo(self.completionStepLabel.mas_bottom);
        make.width.mas_equalTo(Width/3);
        make.height.mas_equalTo(40);
    }];
    
    //完成度
    self.percentLabel = [[UILabel alloc] init];
    [self setLabel:_percentLabel Font:font text:[NSString stringWithFormat:@"%.1f",0.0] FontColor:[UIColor blueColor]];
    [self addSubview:_percentLabel];
    self.percentLabel.font = [UIFont boldSystemFontOfSize:font];
    [self.percentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.completionStepLabel.mas_right);
        make.top.equalTo(self.targetStepLabel);
        make.width.mas_equalTo(Width/3);
        make.height.mas_equalTo(40);
    }];
    
    UILabel * perTitle = [[UILabel alloc] init];
    [self setLabel:perTitle Font:titleFont text:@"完成度" FontColor:[UIColor blackColor]];
    [self addSubview:perTitle];
    [perTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.percentLabel);
        make.top.equalTo(self.percentLabel.mas_bottom);
        make.width.mas_equalTo(Width/3);
        make.height.mas_equalTo(40);
    }];
    
    //里程
    self.kmLabel = [[UILabel alloc] init];
    [self setLabel:_kmLabel Font:font text:[NSString stringWithFormat:@"%.1f",0.0] FontColor:[UIColor blueColor]];
    [self addSubview:_kmLabel];
    self.kmLabel.font = [UIFont boldSystemFontOfSize:font];
    [self.kmLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.targetStepLabel);
        make.top.equalTo(perTitle.mas_bottom).with.offset(50);
        make.width.mas_equalTo(Width/3);
        make.height.mas_equalTo(40);
    }];
    
    UILabel * kmTitle = [[UILabel alloc] init];
    [self setLabel:kmTitle Font:titleFont text:@"里程" FontColor:[UIColor blackColor]];
    [self addSubview:kmTitle];
    [kmTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.targetStepLabel);
        make.top.equalTo(self.kmLabel.mas_bottom);
        make.width.mas_equalTo(Width/3);
        make.height.mas_equalTo(40);
    }];
    //大卡
    self.kioLabel = [[UILabel alloc] init];
    [self setLabel:_kioLabel Font:font text:[NSString stringWithFormat:@"%.1f",0.0] FontColor:[UIColor blueColor]];
    [self addSubview:_kioLabel];
    self.kioLabel.font = [UIFont boldSystemFontOfSize:font];
    [self.kioLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.kmLabel.mas_right);
        make.top.equalTo(self.kmLabel);
        make.width.mas_equalTo(Width/3);
        make.height.mas_equalTo(40);
    }];
    
    UILabel * kioTitle = [[UILabel alloc] init];
    [self setLabel:kioTitle Font:titleFont text:@"大卡" FontColor:[UIColor blackColor]];
    [self addSubview:kioTitle];
    [kioTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.kioLabel);
        make.top.equalTo(self.kioLabel.mas_bottom);
        make.width.mas_equalTo(Width/3);
        make.height.mas_equalTo(40);
    }];
    
    //时间
    self.timeLabel = [[UILabel alloc] init];
    [self setLabel:_timeLabel Font:font text:[NSString stringWithFormat:@"%.1f",0.0] FontColor:[UIColor blueColor]];
    [self addSubview:_timeLabel];
    self.timeLabel.font = [UIFont boldSystemFontOfSize:font];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.kioLabel.mas_right);
        make.top.equalTo(self.kioLabel);
        make.width.mas_equalTo(Width/3);
        make.height.mas_equalTo(40);
    }];
    
    UILabel * timeTitle = [[UILabel alloc] init];
    [self setLabel:timeTitle Font:titleFont text:@"活跃时间" FontColor:[UIColor blackColor]];
    [self addSubview:timeTitle];
    [timeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLabel);
        make.top.equalTo(self.timeLabel.mas_bottom);
        make.width.mas_equalTo(Width/3);
        make.height.mas_equalTo(40);
    }];
    
}
-(void)setLabel:(UILabel*)label Font:(CGFloat)font text:(NSString*)str FontColor:(UIColor*)color{
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = color;
    label.text = str;
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = NSTextAlignmentCenter;
}

@end
