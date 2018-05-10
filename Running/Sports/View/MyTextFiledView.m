//
//  MyTextFiledView.m
//  Running
//
//  Created by 123 on 2018/5/8.
//  Copyright © 2018年 123. All rights reserved.
//

#import "MyTextFiledView.h"
@interface MyTextFiledView()<UITextFieldDelegate>

@property(strong,nonatomic)UITextField * textField;

@end
@implementation MyTextFiledView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setTextFieldView];
    }
    return self;
}
-(void)setTextFieldView{
    
}


@end
