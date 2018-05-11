//
//  SportViewController.m
//  Running
//
//  Created by guangwei li on 2018/5/7.
//  Copyright © 2018年 123. All rights reserved.
//

#import "SportViewController.h"
#import "ArcProgress.h"
#import "CustomMyPickerView.h"
#import "BottomView.h"

#import "HealthKitManager.h"

#import "HealthModel.h"



@interface SportViewController ()<UIScrollViewDelegate>
@property(strong,nonatomic) ArcProgress * pregressView;

@property(strong,nonatomic) UIScrollView * scrollView;

@property(strong,nonatomic) UITextField  * textField;
@property(strong,nonatomic) UILabel * progressViewTitle;
@property(strong,nonatomic) UIButton * chooseBtn;

@property(strong,nonatomic) BottomView * btmView;

@property(assign,nonatomic) double  step;
@property(assign,nonatomic) double  energy;
@property(assign,nonatomic) double distance;
@property(strong,nonatomic) NSString * hours;
@property(assign,nonatomic) double weight;

@property(strong,nonatomic) FMDBManager *db;


@end

@implementation SportViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self setUIScrollView];
    
    [self setFMDB];
    
    [self setDataUI];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    //FMDB
    [self insertTableData];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
   
    
    
//    __block double stepGet;
    
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    

    
  
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//    });
    
  
    
}

#pragma mark-viewWillAppear set health
-(void)setDataUI{
    dispatch_group_t  group = dispatch_group_create();
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        [self getHealKitData];
        dispatch_group_leave(group);
    });
    
    //    dispatch_group_async(group, queue, ^{
    //
    //    });
    //    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if (self.progressViewTitle != nil) {
                [self.progressViewTitle removeFromSuperview];
            }
            if (self.chooseBtn != nil) {
                [self.chooseBtn removeFromSuperview];
            }
            
            if (self.pregressView != nil) {
                [self.pregressView removeFromSuperview];
            }
            if (self.btmView != nil) {
                [self.btmView removeFromSuperview];
            }
            
            [self setTextField];
            [self setProgerssView];
            
            self.pregressView.totalNum = [MyUserDefaults readUserDefaultsKey:STEPTARGET];
            
            [self setKm:self.distance kil:self.energy weight:self.weight hour:self.hours nowStep:self.step];
            
            
            
            //FMDB
            [self insertTableData];
            
        });
        
        
    });
}


#pragma mark-FMDB
-(void)setFMDB{
    //创建数据库
    self.db = [FMDBManager shareDatabase:@"healthdb.sqlite" path:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]];
    if (![self.db isExistTable:HealthTable]) {
        //创建表
        [self.db createTable:HealthTable dicOrModel:[HealthModel class]];
    }
    
}
-(void)insertTableData{
    NSDateFormatter * formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"yyyy-MM-dd";
    
    NSString * date = [formater stringFromDate:[NSDate date]];
   
    
    HealthModel * health = [[HealthModel alloc] init];
    health.distance = self.distance;
    health.totalStep = [MyUserDefaults readUserDefaultsKey:STEPTARGET];
    health.compStep = self.step;
    health.savedate  = date;
    health.weight = self.weight;
    health.energy = self.energy;
    health.hours = self.hours;
    
//    if ([self.db updateTable:HealthTable dicOrModel:health whereFormat:@"WHERE  savedate = '%@'",date]) {
//        NSLog(@"成功");
//    }else{
//        NSLog(@"失败");
//    }
//    [self.db updateTable:HealthTable dicOrModel:health whereFormat:@"WHERE  savedate = '%@'",date];
    
   
    [self.db deleteTable:HealthTable whereFormat:@"WHERE  savedate = '%@'",date];
    
    [self.db insertTable:HealthTable dicOrModel:health];
    
//    NSArray * healthArr = [self.db lookupTable:HealthTable dicOrModel:[HealthModel class] whereFormat:@"WHERE  savedate = '%@'",date];
//    NSLog(@"=====000=====%@",healthArr);
}

#pragma mark-设置里程
-(void)setKm:(double)km kil:(double)eny weight:(double)weight hour:(NSString*)h nowStep:(CGFloat)step{
    self.pregressView.comNum = step;
    
    
    
    if (eny == 0 && km >0) {
        if (weight ==0) {
            eny = 60 * 0.8214*km;
            self.weight = 60;
        }else{
            eny = weight * 0.8214*km;
        }
    }
    self.energy = eny;
//    self.weight = weight
    
    self.btmView.kmLabel.text = [NSString stringWithFormat:@"%.1lfkm",km/1000];
    self.btmView.kilLabel.text = [NSString stringWithFormat:@"%.1lf",eny/1000];
    self.btmView.hLabel.text = h;
    
    


}


#pragma mark- 获取健康数据
-(void)getHealKitData{
    [[HealthKitManager shareInstance] authorizeHealthKit:^(BOOL success, NSError *error) {
        if (success) {
            
          
            
            [[HealthKitManager shareInstance] getStepCount:^(double step,NSString*hours,NSError*err){
                
                
                self.step = step;
                self.hours = hours;
                //                stepGet = step;
                NSLog(@"=====步数====%lf====%@",step,hours);
                
            }];
            
            
//            [[HealthKitManager shareInstance] getStepFromHealthKitWithUnit:nil withCompltion:^(double value, NSError *error) {
//                NSLog(@"今日步数%.2f",value);
//                self.step = value;
//            }];
            
            [[HealthKitManager shareInstance] getDistancesFromHealthKitWithUnit:nil withCompltion:^(double value, NSError *error) {
//                NSLog(@"距离:%.2f",value);
                self.distance = value;
            }];
            
            [[HealthKitManager shareInstance] getEnergyFromHealthKitWithUnit:nil withCompltion:^(double value, NSError *error) {
//                NSLog(@"活动能量:%.2f",value);
                self.energy = value;
            }];
            
            [[HealthKitManager shareInstance] getBodyMassIndexFromHealthKitWithUnit:nil withCompltion:^(double value, NSError *error) {
//                NSLog(@"体重指数:%.2f",value);
                self.weight = value;
            }];
            
        } else {
//            NSLog(@"获取失败 error: %@",error);
            
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"%@",error] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction*action){}];
            [alert addAction:sure];
            [self presentViewController:alert animated:true completion:nil];
        }
    }];
    

}
#pragma mark-UIScrollview
-(void)setUIScrollView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Width, Height+0.5)];
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    
   
}

#pragma MARk-textField
-(void)setTextField{
    
    self.progressViewTitle = [[UILabel alloc] init];
    [self.scrollView addSubview:_progressViewTitle];
    self.progressViewTitle.numberOfLines = 0;
    self.progressViewTitle.backgroundColor = [UIColor whiteColor];
//    self.progressViewTitle.layer.borderWidth = 1;
//    self.progressViewTitle.layer.borderColor = [[UIColor orangeColor] CGColor];
    self.progressViewTitle.layer.cornerRadius = 3;
    self.progressViewTitle.layer.masksToBounds = YES;
    
    self.progressViewTitle.adjustsFontSizeToFitWidth = YES;
    self.progressViewTitle.height = 30;
    [self.progressViewTitle setTextColor:[UIColor blackColor]];
    [self.progressViewTitle setText:@"日常目标:"];
    [self.progressViewTitle setFont:[UIFont systemFontOfSize:21]];
    
    [self.progressViewTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(98);
        make.left.mas_equalTo(20);
    }];
    
    UIButton *chooseBtn = [[UIButton alloc] init];
    chooseBtn.layer.borderWidth = 1;
    chooseBtn.layer.cornerRadius = 10;
    chooseBtn.layer.masksToBounds = YES;
    chooseBtn.opaque = YES;
    chooseBtn.backgroundColor = [UIColor clearColor];
    
    if ([MyUserDefaults readUserDefaultsKey:STEPTARGET] > 0) {
        [chooseBtn setTitle:[NSString stringWithFormat:@"%.0f",[MyUserDefaults readUserDefaultsKey:STEPTARGET]] forState:UIControlStateNormal];
    }else{
        [chooseBtn setTitle:@"选择步数" forState:UIControlStateNormal];
    }
    
    chooseBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [chooseBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.chooseBtn = chooseBtn;
    
    [chooseBtn addTarget:self action:@selector(buttonclick) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:chooseBtn];
    [chooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.progressViewTitle);
        make.left.equalTo(self.progressViewTitle.mas_right).with.offset(5);
        make.width.mas_equalTo(Width/2);
        make.height.mas_equalTo(30);
    }];
    
    

}
- (void)buttonclick
{
    
    CustomMyPickerView *customVC =[[CustomMyPickerView alloc] initWithComponentDataArray:@[@"1000",@"2000",@"3000",@"4000",@"5000",@"6000",@"7000",@"8000",@"9000",@"10000",@"11000",@"12000",@"13000",@"14000",@"15000",@"16000",@"17000",@"18000",@"19000",@"20000",@"21000",@"22000",@"23000",@"24000",@"25000",@"26000",@"27000",@"28000",@"29000",@"30000",@"31000",@"32000",@"33000",@"34000",@"35000",@"36000",@"37000",@"38000",@"39000",@"40000",@"41000",@"42000",@"43000",@"44000",@"45000",@"46000",@"47000",@"48000",@"49000",@"50000",@"51000",@"52000",@"53000",@"54000",@"55000",@"56000",@"57000",@"58000",@"59000",@"60000",@"61000",@"62000",@"63000",@"64000",@"65000",@"66000",@"67000",@"68000",@"69000",@"70000",@"71000",@"72000",@"73000",@"74000",@"75000",@"76000",@"77000",@"78000",@"79000",@"80000",@"81000",@"82000",@"83000",@"84000",@"85000",@"86000",@"87000",@"88000",@"89000",@"90000",@"91000",@"92000",@"93000",@"94000",@"95000",@"96000",@"97000",@"98000",@"99000"] titleDataArray:@[@"步"]];
    customVC.getPickerValue = ^(NSString *compoentString, NSString *titileString) {
        [self.chooseBtn setTitle:[NSString stringWithFormat:@"%@ 步",compoentString] forState:UIControlStateNormal];
        
        
        
        
        if (self.pregressView != nil) {
            [self.pregressView removeFromSuperview];
        }
        if (self.btmView != nil) {
            [self.btmView removeFromSuperview];
        }
        [self setProgerssView];
        self.pregressView.totalNum = [compoentString floatValue];
        [MyUserDefaults wirteUserDefaultsF:[compoentString floatValue] andKey:STEPTARGET];
        [self setKm:self.distance kil:self.energy weight:self.weight hour:self.hours nowStep:self.step];
        
        //FMDB
        [self insertTableData];
    };
    
    [self.view addSubview:customVC];
}

#pragma MARK-progressView
-(void)setProgerssView{
    _pregressView = [[ArcProgress alloc] initWithFrame:CGRectMake(0, 0, Width/3*2, Width/3*2)];

    self.pregressView.opaque = YES;
    _pregressView.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:_pregressView];
    [self.pregressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.progressViewTitle.mas_bottom).with.offset(30);
        make.width.mas_equalTo(Width/3*2);
        make.height.mas_equalTo(Width/3*2);
        make.left.mas_equalTo(Width/3/2);
    }];
    
      [self setBottomView];
}

#pragma mark-bottomView
-(void)setBottomView{
    self.btmView = [[BottomView alloc] init];
    self.btmView.opaque = YES;
    [self.scrollView addSubview:_btmView];
    
    [self.btmView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.equalTo(self.pregressView.mas_bottom).offset(30);
        make.width.mas_equalTo(Width-20);
        make.height.mas_equalTo(300);
    }];
    
}

#pragma mark-UIScrollView delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y<=-50) {
//        NSLog(@"sdfsdfffdsfafafadsfs");
    }
}


@end


