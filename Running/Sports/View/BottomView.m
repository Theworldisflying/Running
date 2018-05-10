//
//  BottomView.m
//  Running
//
//  Created by 123 on 2018/5/8.
//  Copyright © 2018年 123. All rights reserved.
//

#import "BottomView.h"

@implementation BottomView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setContent];
    }
    return self;
}

-(void)setContent{
    CGFloat font = 22;
    CGFloat titleFont = 18;
    
    self.kmLabel = [[UILabel alloc] init];
    [self setLabel:_kmLabel Font:font text:[NSString stringWithFormat:@"%.1f",0.0] FontColor:[UIColor blackColor]];
    [self addSubview:_kmLabel];
    self.kmLabel.font = [UIFont boldSystemFontOfSize:font];
    [self.kmLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.equalTo(self).with.offset(10);
        make.width.mas_equalTo((Width-20)/3);
        make.height.mas_equalTo(40);
    }];
    
    UILabel * kmTitle = [[UILabel alloc] init];
    [self setLabel:kmTitle Font:titleFont text:@"里程" FontColor:[UIColor grayColor]];
    [self addSubview:kmTitle];
    [kmTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.equalTo(self.kmLabel.mas_bottom);
        make.width.mas_equalTo((Width-20)/3);
        make.height.mas_equalTo(40);
    }];
    
    //大卡
    self.kilLabel = [[UILabel alloc] init];
    [self setLabel:_kilLabel Font:font text:[NSString stringWithFormat:@"%.0f",0.0] FontColor:[UIColor blackColor]];
    [self addSubview:_kilLabel];
    self.kilLabel.font = [UIFont boldSystemFontOfSize:font];
    [self.kilLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.kmLabel.mas_right);
        make.top.equalTo(self).with.offset(10);
        make.width.mas_equalTo((Width-20)/3);
        make.height.mas_equalTo(40);
    }];
    
    UILabel * kilTitle = [[UILabel alloc] init];
    [self setLabel:kilTitle Font:titleFont text:@"大卡" FontColor:[UIColor grayColor]];
    [self addSubview:kilTitle];
    [kilTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.kilLabel);
        make.top.equalTo(self.kilLabel.mas_bottom);
        make.width.mas_equalTo((Width-20)/3);
        make.height.mas_equalTo(40);
    }];
    
    //活跃时间
    self.hLabel = [[UILabel alloc] init];
    [self setLabel:_hLabel Font:font text:[NSString stringWithFormat:@"%.0f",0.0] FontColor:[UIColor blackColor]];
    [self addSubview:_hLabel];
    self.hLabel.font = [UIFont boldSystemFontOfSize:font];
    [self.hLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.kilLabel.mas_right);
        make.top.equalTo(self).with.offset(10);
        make.width.mas_equalTo((Width-20)/3);
        make.height.mas_equalTo(40);
    }];
    
    UILabel * hTitle = [[UILabel alloc] init];
    [self setLabel:hTitle Font:titleFont text:@"活跃时间" FontColor:[UIColor grayColor]];
    [self addSubview:hTitle];
    [hTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.hLabel);
        make.top.equalTo(self.hLabel.mas_bottom);
        make.width.mas_equalTo((Width-20)/3);
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
