//
//  CustomMyPickerView.h
//  Running
//
//  Created by 123 on 2018/5/8.
//  Copyright © 2018年 123. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^customBlock)(NSString *compoentString,NSString *titileString);


@interface CustomMyPickerView : UIView

@property (nonatomic ,copy)NSString *componentString;
@property (nonatomic ,copy)NSString *titleString;
@property (nonatomic ,copy)customBlock getPickerValue;

@property (nonatomic ,copy)NSString *valueString;

- (instancetype)initWithComponentDataArray:(NSArray *)ComponentDataArray titleDataArray:(NSArray *)titleDataArray;
@end
