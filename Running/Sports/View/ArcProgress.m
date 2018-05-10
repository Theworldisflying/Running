//
//  ArcProgress.m
//  Running
//
//  Created by 123 on 2018/5/8.
//  Copyright © 2018年 123. All rights reserved.
//

#import "ArcProgress.h"

@interface ArcProgress()
@property(strong,nonatomic) UILabel * comLabel;
@property(strong,nonatomic) UILabel * totalLabel;
@property(nonatomic,assign)CGFloat num;
@property(nonatomic,strong)UILabel *numLabel;
@property(nonatomic,strong)NSTimer *timer;

@end

@implementation ArcProgress


- (void)drawRect:(CGRect)rect {
    
    _startColor = [UIColor blueColor];
    _endColor = [UIColor redColor];
    
    //    仪表盘底部
    [self drawHu1];
    //    仪表盘进度
    [self drawHu2];
}
-(void)drawHu2
{
    //1.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //1.1 设置线条的宽度
    CGContextSetLineWidth(ctx, 20);
    //1.2 设置线条的起始点样式
    CGContextSetLineCap(ctx,kCGLineCapButt);
    //1.3  虚实切换 ，实线5虚线10
    CGFloat length[] = {4,10};
    CGContextSetLineDash(ctx, 0, length, 2);
    
    
    //2.设置路径
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(numberChange:) name:@"number" object:nil];
    //1.4 设置颜色
    //渐变色区间
    CGFloat colorFraction;
    colorFraction = 0.125+0.05;
    UIColor *currentColor = [self getGradientColor:colorFraction];
    [currentColor set];
    
    CGFloat end = -5*M_PI_4+(6*M_PI_4*_num/_totalNum);
    CGFloat X = self.width/2;
    CGFloat radius  = self.width/2-20;
    
    
    CGContextAddArc(ctx, X , X, radius, -5*M_PI_4, end , 0);
    
    //3.绘制
    CGContextStrokePath(ctx);
    
    
}

-(void)numberChange:(NSNotification*)text
{
    _num = [text.userInfo[@"num"] intValue];
    
    [self setNeedsDisplay];
    
}

-(void)drawHu1
{
    //1.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //1.1 设置线条的宽度
    CGContextSetLineWidth(ctx, 20);
    //1.2 设置线条的起始点样式
    CGContextSetLineCap(ctx,kCGLineCapButt);
    //1.3  虚实切换 ，实线5虚线10
    CGFloat length[] = {4,10};
    CGContextSetLineDash(ctx, 0, length, 2);
    //1.4 设置颜色
    [[UIColor blackColor] set];
    
    //2.设置路径
    CGFloat X = self.width/2;
    CGFloat radius  = self.width/2-20;
    CGContextAddArc(ctx, X , X, radius, -5*M_PI_4, M_PI_4, 0);
    //3.绘制
    CGContextStrokePath(ctx);
    
}

-(void)setNum:(CGFloat)num
{
    _num = num;
    
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
        
        CGFloat W = self.width/2-20;
        CGFloat H = self.height/3;
        
        UILabel * comp = [[UILabel alloc] initWithFrame:CGRectMake(self.width/4 , (self.height-H-30)/2, self.width/2, 30)];
        comp.adjustsFontSizeToFitWidth = YES;
        comp.textAlignment = NSTextAlignmentCenter;
      
        [comp setTextColor:[UIColor grayColor]];
        [comp setFont:[UIFont systemFontOfSize:25]];
        [self addSubview:comp];
        
        self.comLabel = comp;
        
        
        
        _numLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.width-W)/2, (self.height-H)/2, W, H)];
        _numLabel.textAlignment  = NSTextAlignmentCenter;
        _numLabel.adjustsFontSizeToFitWidth = YES;
        _numLabel.textColor = [UIColor blueColor];
        _numLabel.font = [UIFont systemFontOfSize:60];
        
        
        if (!_timer) {
            _timer = [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(change) userInfo:nil repeats:YES];
        }
      
        [self addSubview:_numLabel];
        
        
        //total
        self.totalLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.width-W)/2-10, self.height-60, self.width/2, 30)];
        
        self.totalLabel.adjustsFontSizeToFitWidth = YES;
        self.totalLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.totalLabel setTextColor:[UIColor grayColor]];
        [self.totalLabel setFont:[UIFont systemFontOfSize:20]];
        [self addSubview:_totalLabel];
        
        
        
        
        
    }
    return self;
}
-(void)change
{
    
    
    
    
    
   
    
    if (_comNum < _totalNum) {
         _num += _totalNum/100;
        if (_num > _comNum) {
            
            _num = _comNum;
            [[NSNotificationCenter defaultCenter] removeObserver:self name:@"number" object:nil];
            [_timer invalidate];
            //        _num = 0;
        }
    }else{
         _num += _comNum/100;
        if (_num > _totalNum + _comNum/100) {
            
            _num = _totalNum;
            [[NSNotificationCenter defaultCenter] removeObserver:self name:@"number" object:nil];
            [_timer invalidate];
            //        _num = 0;
        }
    }

    
   
    
    if (_comNum/_totalNum >= 1) {
        _comLabel.text = @"恭喜完成目标!";
    }else{
      _comLabel.text = [NSString stringWithFormat:@"已完成:%.0f%s",(_comNum/_totalNum)*100,"%"];
    }
    
    self.totalLabel.text = [NSString stringWithFormat:@"目标:%.0f",_totalNum];
    
    
    
    _numLabel.text = [NSString stringWithFormat:@"%.0f",_comNum];
    
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%.0f",_num],@"num", nil];
    
    //    创建通知
    NSNotification *noti = [NSNotification notificationWithName:@"number" object:nil userInfo:dic];
    //    发送通知
    [[NSNotificationCenter defaultCenter]postNotification:noti];
    
}

//获取当前颜色
- (UIColor *)getGradientColor:(CGFloat)current {
    
    CGFloat c1[4];
    CGFloat c2[4];
    NSLog(@"%f",current);
    
    [_startColor getRed:&c1[0] green:&c1[1] blue:&c1[2] alpha:&c1[3]];
    [_endColor getRed:&c2[0] green:&c2[1] blue:&c2[2] alpha:&c2[3]];
    
    return [UIColor colorWithRed:current*c2[0]+(1-current)*c1[0] green:current*c2[1]+(1-current)*c1[1] blue:current*c2[2]+(1-current)*c1[2] alpha:current*c2[3]+(1-current)*c1[3]];
}


@end
