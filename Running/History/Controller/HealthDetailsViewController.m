//
//  HealthDetailsViewController.m
//  Running
//
//  Created by 123 on 2018/5/9.
//  Copyright © 2018年 123. All rights reserved.
//

#import "HealthDetailsViewController.h"
#import "HealthModel.h"

#import "HistoryOneDayView.h"


@interface HealthDetailsViewController ()

@property(strong,nonatomic) HistoryOneDayView * hisView;

@property(strong,nonatomic) UIImageView * imgv;
@end

@implementation HealthDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _model.savedate;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.imgv = [[UIImageView alloc] initWithFrame:self.view.bounds];

    NSString * path = [[NSBundle mainBundle] pathForResource:@"runback" ofType:@"png"];
    UIImage * img = [UIImage imageWithContentsOfFile:path];
    
    self.imgv.image = img;
    
    [self.view addSubview:_imgv];
    
    [self setHisViewUI];
    
}



#pragma mark-contentView
-(void)setHisViewUI{
    self.hisView = [[HistoryOneDayView alloc] init];
    self.hisView.opaque = YES;
    self.hisView.backgroundColor = [UIColor clearColor];
    NSString * path;
    NSString * tips;
    if (_model.compStep < _model.totalStep) {
        path = [[NSBundle mainBundle] pathForResource:@"failure" ofType:@"png"];
        tips = @"未完成制定目标!";
    }else if (_model.compStep == _model.totalStep) {
        path = [[NSBundle mainBundle] pathForResource:@"happy" ofType:@"png"];
         tips = @"恭喜完成制定目标!";
    }else if (_model.compStep > _model.totalStep) {
        path = [[NSBundle mainBundle] pathForResource:@"happyp" ofType:@"png"];
        tips = @"恭喜超额完成制定目标!";
    }else{
        path = [[NSBundle mainBundle] pathForResource:@"failure" ofType:@"png"];
        tips = @"未完成制定目标!";
    }
    [self.hisView.imgv setImage:[UIImage imageWithContentsOfFile:path]];
    [self.hisView.typeLavel setText:tips];
    [self.view addSubview:_hisView];
    [self.hisView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(44);
        make.left.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(self.view);
        
    }];
    
    
    //data
    self.hisView.targetStepLabel.text = [NSString stringWithFormat:@"%.0f",_model.totalStep];
    self.hisView.completionStepLabel.text = [NSString stringWithFormat:@"%.0f",_model.compStep];
    self.hisView.percentLabel.text = [NSString stringWithFormat:@"%.0f%@",(_model.compStep/_model.totalStep)*100,@"%"];
    self.hisView.kmLabel.text = [NSString stringWithFormat:@"%.1f",_model.distance/1000];
    self.hisView.kioLabel.text = [NSString stringWithFormat:@"%.0f",_model.energy/1000];
    self.hisView.timeLabel.text = _model.hours;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
