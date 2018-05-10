//
//  HistoryTableViewCell.m
//  Running
//
//  Created by 123 on 2018/5/9.
//  Copyright © 2018年 123. All rights reserved.
//

#import "HistoryTableViewCell.h"
@interface HistoryTableViewCell()
@property(strong,nonatomic) UILabel * stepLabel;
@property(strong,nonatomic) UILabel * walkStepLabel;
@property(strong,nonatomic) UILabel * dateLabel;

@end

@implementation HistoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
    }
    
    return self;
}
-(void)setUI{
    
    UILabel * stepT = [[UILabel alloc] init];
    stepT.text = @"设定目标:";
    [self setLabel:stepT font:20 txtColor:[UIColor blackColor]];
    stepT.textAlignment = NSTextAlignmentCenter;
    [self addSubview:stepT];
    [stepT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(5);
        make.left.mas_equalTo(10);
        
    }];
    
    self.stepLabel = [[UILabel alloc] init];
    [self setLabel:_stepLabel font:20 txtColor:[UIColor blackColor]];
    [self addSubview:_stepLabel];
    
    [self.stepLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(stepT);
        make.left.equalTo(stepT.mas_right).offset(5);
        make.width.mas_equalTo(self.width/2-10-stepT.width);
        
    }];
    //完成步数
    self.walkStepLabel = [[UILabel alloc] init];
    [self setLabel:_walkStepLabel font:16 txtColor:[UIColor blackColor]];
    [self addSubview:_walkStepLabel];
    
    [self.walkStepLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.stepLabel).offset(15);
        make.left.equalTo(self.stepLabel.mas_right).offset(5);
        
    }];
    
    self.dateLabel = [[UILabel alloc] init];
    [self setLabel:_dateLabel font:13 txtColor:[UIColor grayColor]];
    [self addSubview:_dateLabel];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(stepT.mas_bottom).with.offset(5);
        make.left.equalTo(stepT);
        
    }];
}

-(void)loadUIForStep:(CGFloat)step  walkStep:(CGFloat)wStep Date:(NSString*)date{
    self.stepLabel.text = [NSString stringWithFormat:@"%.0f 步",step];
    if (wStep > step) {
        self.walkStepLabel.text = [NSString stringWithFormat:@"目标达成!"];
        self.walkStepLabel.textColor = [UIColor greenColor];
    }else{
        self.walkStepLabel.text = [NSString stringWithFormat:@"未达成!"];
        self.walkStepLabel.textColor = [UIColor redColor];
    }
    
    
    self.dateLabel.text = date;
}

-(void)setLabel:(UILabel*)label font:(CGFloat)font txtColor:(UIColor*)color{
    label.font = [UIFont systemFontOfSize:font];
    [label setTextColor:color];
    label.backgroundColor = [UIColor clearColor];
    label.adjustsFontSizeToFitWidth = true;
    label.textAlignment = NSTextAlignmentLeft;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
