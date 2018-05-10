//
//  HistoryTableViewCell.h
//  Running
//
//  Created by 123 on 2018/5/9.
//  Copyright © 2018年 123. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryTableViewCell : UITableViewCell
-(void)loadUIForStep:(CGFloat)step  walkStep:(CGFloat)wStep Date:(NSString*)date;
@end
